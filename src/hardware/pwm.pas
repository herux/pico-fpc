{
  PWM Hardware Functions for RP2040

  Based on Raspberry Pi Pico SDK - hardware/pwm
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause

  Converted to Free Pascal
}
unit pwm;

{$mode objfpc}
{$H+}

interface

uses
  rp2040, gpio, resets;

const
  NUM_PWM_SLICES = 8;

  PWM_CHAN_A = 0;
  PWM_CHAN_B = 1;

type
  TPwmChan = (pwmA = PWM_CHAN_A, pwmB = PWM_CHAN_B);

  TPwmSliceHW = packed record
    csr: LongWord;
    div_: LongWord;
    ctr: LongWord;
    cc: LongWord;
    top: LongWord;
  end;

  TPwmHW = packed record
    slice: array[0..NUM_PWM_SLICES - 1] of TPwmSliceHW;
    en: LongWord;
    intr: LongWord;
    inte: LongWord;
    intf: LongWord;
    ints: LongWord;
  end;
  PPwmHW = ^TPwmHW;

  TPwmConfig = packed record
    csr: LongWord;
    div_: LongWord;
    top: LongWord;
  end;

var
  pwm_hw: PPwmHW absolute PWM_BASE;

function pwm_gpio_to_slice_num(gpio_pin: LongWord): LongWord;
function pwm_gpio_to_channel(gpio_pin: LongWord): LongWord;

procedure pwm_gpio_init(gpio_pin: LongWord);

function pwm_get_default_config: TPwmConfig;
procedure pwm_init(slice_num: LongWord; const config: TPwmConfig; start: Boolean);

procedure pwm_set_wrap(slice_num: LongWord; wrap: Word);
procedure pwm_set_chan_level(slice_num: LongWord; chan: LongWord; level: Word);
procedure pwm_set_gpio_level(gpio_pin: LongWord; level: Word);

procedure pwm_set_clkdiv_int_frac4(slice_num: LongWord; div_int, div_frac4: Byte);
procedure pwm_set_clkdiv_int(slice_num: LongWord; div_int: Byte);

procedure pwm_set_enabled(slice_num: LongWord; enabled: Boolean);

implementation

const
  PWM_CH0_CSR_EN_BITS = $00000001;
  PWM_CH0_CC_A_BITS = $0000FFFF;
  PWM_CH0_CC_B_BITS = $FFFF0000;

var
  pwm_hw_initialized: Boolean = False;

procedure pwm_hw_init_once;
begin
  if pwm_hw_initialized then
    Exit;

  unreset_block_wait(RESETS_RESET_PWM_BITS);
  pwm_hw_initialized := True;
end;

function pwm_gpio_to_slice_num(gpio_pin: LongWord): LongWord;
begin
  if gpio_pin >= 32 then
    Result := 8 + ((gpio_pin shr 1) and 3)
  else
    Result := (gpio_pin shr 1) and 7;
end;

function pwm_gpio_to_channel(gpio_pin: LongWord): LongWord;
begin
  Result := gpio_pin and 1;
end;

procedure pwm_gpio_init(gpio_pin: LongWord);
begin
  if gpio_pin >= NUM_BANK0_GPIOS then
    Exit;

  pwm_hw_init_once;
  gpio_set_function(gpio_pin, gfPWM);
end;

function pwm_get_default_config: TPwmConfig;
begin
  Result.csr := 0;
  Result.div_ := $10;   { div_int = 1, div_frac = 0 }
  Result.top := $FFFF;
end;

procedure pwm_init(slice_num: LongWord; const config: TPwmConfig; start: Boolean);
begin
  if slice_num >= NUM_PWM_SLICES then
    Exit;

  pwm_hw_init_once;

  pwm_hw^.slice[slice_num].csr := 0;
  pwm_hw^.slice[slice_num].ctr := 0;
  pwm_hw^.slice[slice_num].cc := 0;
  pwm_hw^.slice[slice_num].top := config.top;
  pwm_hw^.slice[slice_num].div_ := config.div_;

  if start then
    pwm_hw^.slice[slice_num].csr := config.csr or PWM_CH0_CSR_EN_BITS
  else
    pwm_hw^.slice[slice_num].csr := config.csr and not PWM_CH0_CSR_EN_BITS;
end;

procedure pwm_set_wrap(slice_num: LongWord; wrap: Word);
begin
  if slice_num >= NUM_PWM_SLICES then
    Exit;

  pwm_hw^.slice[slice_num].top := wrap;
end;

procedure pwm_set_chan_level(slice_num: LongWord; chan: LongWord; level: Word);
var
  cc: LongWord;
begin
  if slice_num >= NUM_PWM_SLICES then
    Exit;

  cc := pwm_hw^.slice[slice_num].cc;
  if chan = PWM_CHAN_B then
    cc := (cc and LongWord($0000FFFF)) or (LongWord(level) shl 16)
  else
    cc := (cc and LongWord($FFFF0000)) or LongWord(level);

  pwm_hw^.slice[slice_num].cc := cc;
end;

procedure pwm_set_gpio_level(gpio_pin: LongWord; level: Word);
begin
  pwm_set_chan_level(
    pwm_gpio_to_slice_num(gpio_pin),
    pwm_gpio_to_channel(gpio_pin),
    level
  );
end;

procedure pwm_set_clkdiv_int_frac4(slice_num: LongWord; div_int, div_frac4: Byte);
begin
  if slice_num >= NUM_PWM_SLICES then
    Exit;

  if div_int < 1 then
    div_int := 1;

  div_frac4 := div_frac4 and $0F;
  pwm_hw^.slice[slice_num].div_ := (LongWord(div_int) shl 4) or LongWord(div_frac4);
end;

procedure pwm_set_clkdiv_int(slice_num: LongWord; div_int: Byte);
begin
  pwm_set_clkdiv_int_frac4(slice_num, div_int, 0);
end;

procedure pwm_set_enabled(slice_num: LongWord; enabled: Boolean);
begin
  if slice_num >= NUM_PWM_SLICES then
    Exit;

  if enabled then
    pwm_hw^.slice[slice_num].csr := pwm_hw^.slice[slice_num].csr or PWM_CH0_CSR_EN_BITS
  else
    pwm_hw^.slice[slice_num].csr := pwm_hw^.slice[slice_num].csr and not PWM_CH0_CSR_EN_BITS;
end;

end.
