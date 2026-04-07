{
  GPIO Hardware Functions for RP2040
  
  Based on Raspberry Pi Pico SDK - hardware/gpio
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause
  
  Converted to Free Pascal
}
unit gpio;

{$mode objfpc}
{$H+}

interface

uses
  rp2040;

type
  TGpioFunction = (
    gfXIP   = GPIO_FUNC_XIP,
    gfSPI   = GPIO_FUNC_SPI,
    gfUART  = GPIO_FUNC_UART,
    gfI2C   = GPIO_FUNC_I2C,
    gfPWM   = GPIO_FUNC_PWM,
    gfSIO   = GPIO_FUNC_SIO,
    gfPIO0  = GPIO_FUNC_PIO0,
    gfPIO1  = GPIO_FUNC_PIO1,
    gfGPCK  = GPIO_FUNC_GPCK,
    gfUSB   = GPIO_FUNC_USB,
    gfNULL  = GPIO_FUNC_NULL
  );
  
  TGpioDirection = (
    gdInput  = GPIO_IN,
    gdOutput = GPIO_OUT
  );
  
  TGpioDriveStrength = (
    gds2mA  = 0,
    gds4mA  = 1,
    gds8mA  = 2,
    gds12mA = 3
  );
  
  TGpioSlewRate = (
    gsrSlow = 0,
    gsrFast = 1
  );

{ Initialize a GPIO pin for software control }
procedure gpio_init(gpio: LongWord);

{ Deinitialize a GPIO pin }
procedure gpio_deinit(gpio: LongWord);

{ Initialize multiple GPIO pins }
procedure gpio_init_mask(gpio_mask: LongWord);

{ Set GPIO function }
procedure gpio_set_function(gpio: LongWord; fn: TGpioFunction);

{ Get GPIO function }
function gpio_get_function(gpio: LongWord): TGpioFunction;

{ Set GPIO direction }
procedure gpio_set_dir(gpio: LongWord; direction: TGpioDirection);

{ Get GPIO direction }
function gpio_get_dir(gpio: LongWord): TGpioDirection;

{ Set multiple GPIO directions at once }
procedure gpio_set_dir_masked(mask, value: LongWord);

{ Set all GPIO directions }
procedure gpio_set_dir_all_bits(values: LongWord);

{ Set output enable for GPIO }
procedure gpio_set_dir_out_masked(mask: LongWord);

{ Clear output enable for GPIO }
procedure gpio_set_dir_in_masked(mask: LongWord);

{ Put a value on GPIO }
procedure gpio_put(gpio: LongWord; value: Boolean);

{ Put values on multiple GPIOs }
procedure gpio_put_masked(mask, value: LongWord);

{ Put values on all GPIOs }
procedure gpio_put_all(value: LongWord);

{ Set GPIO high }
procedure gpio_set_mask(mask: LongWord);

{ Set GPIO low }
procedure gpio_clr_mask(mask: LongWord);

{ Toggle GPIO }
procedure gpio_xor_mask(mask: LongWord);

{ Get GPIO value }
function gpio_get(gpio: LongWord): Boolean;

{ Get all GPIO values }
function gpio_get_all: LongWord;

{ Set GPIO pull up }
procedure gpio_pull_up(gpio: LongWord);

{ Set GPIO pull down }
procedure gpio_pull_down(gpio: LongWord);

{ Disable GPIO pulls }
procedure gpio_disable_pulls(gpio: LongWord);

{ Set GPIO pulls }
procedure gpio_set_pulls(gpio: LongWord; up, down: Boolean);

{ Check if GPIO is pulled up }
function gpio_is_pulled_up(gpio: LongWord): Boolean;

{ Check if GPIO is pulled down }
function gpio_is_pulled_down(gpio: LongWord): Boolean;

{ Set GPIO input enable }
procedure gpio_set_input_enabled(gpio: LongWord; enabled: Boolean);

{ Set GPIO drive strength }
procedure gpio_set_drive_strength(gpio: LongWord; drive: TGpioDriveStrength);

{ Get GPIO drive strength }
function gpio_get_drive_strength(gpio: LongWord): TGpioDriveStrength;

{ Set GPIO slew rate }
procedure gpio_set_slew_rate(gpio: LongWord; slew: TGpioSlewRate);

{ Get GPIO slew rate }  
function gpio_get_slew_rate(gpio: LongWord): TGpioSlewRate;

{ Enable/disable input hysteresis (Schmitt trigger) }
procedure gpio_set_input_hysteresis_enabled(gpio: LongWord; enabled: Boolean);

{ Check if input hysteresis is enabled }
function gpio_is_input_hysteresis_enabled(gpio: LongWord): Boolean;

implementation

procedure gpio_set_function(gpio: LongWord; fn: TGpioFunction);
begin
  if gpio >= NUM_BANK0_GPIOS then Exit;
  
  { Direct pointer access like blink_standalone - each GPIO has status(+0) and ctrl(+4) = 8 bytes }
  PLongWord(IO_BANK0_BASE + (gpio * 8) + 4)^ := LongWord(fn);
end;

function gpio_get_function(gpio: LongWord): TGpioFunction;
begin
  if gpio >= NUM_BANK0_GPIOS then
    Exit(gfNULL);
    
  Result := TGpioFunction(
    (io_bank0_hw^.gpio[gpio].ctrl and IO_BANK0_GPIO_CTRL_FUNCSEL_BITS) 
    shr IO_BANK0_GPIO_CTRL_FUNCSEL_LSB
  );
end;

procedure gpio_init(gpio: LongWord);
begin
  if gpio >= NUM_BANK0_GPIOS then Exit;
  
  { Set to SIO function }
  gpio_set_function(gpio, gfSIO);
  
  { Clear output value }
  gpio_clr_mask(1 shl gpio);
  
  { Set to input }
  gpio_set_dir(gpio, gdInput);
end;

procedure gpio_deinit(gpio: LongWord);
begin
  if gpio >= NUM_BANK0_GPIOS then Exit;
  
  { Set to NULL function }
  gpio_set_function(gpio, gfNULL);
end;

procedure gpio_init_mask(gpio_mask: LongWord);
var
  gpio: LongWord;
begin
  for gpio := 0 to NUM_BANK0_GPIOS - 1 do
  begin
    if (gpio_mask and (1 shl gpio)) <> 0 then
      gpio_init(gpio);
  end;
end;

procedure gpio_set_dir(gpio: LongWord; direction: TGpioDirection);
const
  GPIO_OE_SET = SIO_BASE + $024;
  GPIO_OE_CLR = SIO_BASE + $028;
var
  mask: LongWord;
begin
  if gpio >= NUM_BANK0_GPIOS then Exit;
  
  mask := 1 shl gpio;
  if direction = gdOutput then
    PLongWord(GPIO_OE_SET)^ := mask
  else
    PLongWord(GPIO_OE_CLR)^ := mask;
end;

function gpio_get_dir(gpio: LongWord): TGpioDirection;
begin
  if gpio >= NUM_BANK0_GPIOS then
    Exit(gdInput);
    
  if (sio_hw^.gpio_oe and (1 shl gpio)) <> 0 then
    Result := gdOutput
  else
    Result := gdInput;
end;

procedure gpio_set_dir_masked(mask, value: LongWord);
begin
  sio_hw^.gpio_oe_xor := (sio_hw^.gpio_oe xor value) and mask;
end;

procedure gpio_set_dir_all_bits(values: LongWord);
begin
  sio_hw^.gpio_oe := values;
end;

procedure gpio_set_dir_out_masked(mask: LongWord);
begin
  sio_hw^.gpio_oe_set := mask;
end;

procedure gpio_set_dir_in_masked(mask: LongWord);
begin
  sio_hw^.gpio_oe_clr := mask;
end;

procedure gpio_put(gpio: LongWord; value: Boolean);
const
  GPIO_OUT_SET = SIO_BASE + $014;
  GPIO_OUT_CLR = SIO_BASE + $018;
var
  mask: LongWord;
begin
  if gpio >= NUM_BANK0_GPIOS then Exit;
  
  mask := 1 shl gpio;
  if value then
    PLongWord(GPIO_OUT_SET)^ := mask
  else
    PLongWord(GPIO_OUT_CLR)^ := mask;
end;

procedure gpio_put_masked(mask, value: LongWord);
begin
  sio_hw^.gpio_out_xor := (sio_hw^.gpio_out xor value) and mask;
end;

procedure gpio_put_all(value: LongWord);
begin
  sio_hw^.gpio_out := value;
end;

procedure gpio_set_mask(mask: LongWord);
begin
  sio_hw^.gpio_out_set := mask;
end;

procedure gpio_clr_mask(mask: LongWord);
const
  GPIO_OUT_CLR = SIO_BASE + $018;
begin
  PLongWord(GPIO_OUT_CLR)^ := mask;
end;

procedure gpio_xor_mask(mask: LongWord);
begin
  sio_hw^.gpio_out_xor := mask;
end;

function gpio_get(gpio: LongWord): Boolean;
begin
  if gpio >= NUM_BANK0_GPIOS then
    Exit(False);
    
  Result := (sio_hw^.gpio_in and (1 shl gpio)) <> 0;
end;

function gpio_get_all: LongWord;
begin
  Result := sio_hw^.gpio_in;
end;

procedure gpio_set_pulls(gpio: LongWord; up, down: Boolean);
var
  value: LongWord;
begin
  if gpio >= NUM_BANK0_GPIOS then Exit;
  
  value := 0;
  if up then
    value := value or PADS_BANK0_GPIO_PUE_BITS;
  if down then
    value := value or PADS_BANK0_GPIO_PDE_BITS;
    
  hw_write_masked(
    pads_bank0_hw^.io[gpio],
    value,
    PADS_BANK0_GPIO_PUE_BITS or PADS_BANK0_GPIO_PDE_BITS
  );
end;

procedure gpio_pull_up(gpio: LongWord);
begin
  gpio_set_pulls(gpio, True, False);
end;

procedure gpio_pull_down(gpio: LongWord);
begin
  gpio_set_pulls(gpio, False, True);
end;

procedure gpio_disable_pulls(gpio: LongWord);
begin
  gpio_set_pulls(gpio, False, False);
end;

function gpio_is_pulled_up(gpio: LongWord): Boolean;
begin
  if gpio >= NUM_BANK0_GPIOS then
    Exit(False);
    
  Result := (pads_bank0_hw^.io[gpio] and PADS_BANK0_GPIO_PUE_BITS) <> 0;
end;

function gpio_is_pulled_down(gpio: LongWord): Boolean;
begin
  if gpio >= NUM_BANK0_GPIOS then
    Exit(False);
    
  Result := (pads_bank0_hw^.io[gpio] and PADS_BANK0_GPIO_PDE_BITS) <> 0;
end;

procedure gpio_set_input_enabled(gpio: LongWord; enabled: Boolean);
begin
  if gpio >= NUM_BANK0_GPIOS then Exit;
  
  if enabled then
    hw_set_bits(pads_bank0_hw^.io[gpio], PADS_BANK0_GPIO_IE_BITS)
  else
    hw_clear_bits(pads_bank0_hw^.io[gpio], PADS_BANK0_GPIO_IE_BITS);
end;

procedure gpio_set_drive_strength(gpio: LongWord; drive: TGpioDriveStrength);
begin
  if gpio >= NUM_BANK0_GPIOS then Exit;
  
  hw_write_masked(
    pads_bank0_hw^.io[gpio],
    LongWord(drive) shl 4,
    PADS_BANK0_GPIO_DRIVE_BITS
  );
end;

function gpio_get_drive_strength(gpio: LongWord): TGpioDriveStrength;
begin
  if gpio >= NUM_BANK0_GPIOS then
    Exit(gds4mA);
    
  Result := TGpioDriveStrength((pads_bank0_hw^.io[gpio] and PADS_BANK0_GPIO_DRIVE_BITS) shr 4);
end;

procedure gpio_set_slew_rate(gpio: LongWord; slew: TGpioSlewRate);
begin
  if gpio >= NUM_BANK0_GPIOS then Exit;
  
  hw_write_masked(
    pads_bank0_hw^.io[gpio],
    LongWord(slew),
    PADS_BANK0_GPIO_SLEWFAST_BITS
  );
end;

function gpio_get_slew_rate(gpio: LongWord): TGpioSlewRate;
begin
  if gpio >= NUM_BANK0_GPIOS then
    Exit(gsrSlow);
    
  Result := TGpioSlewRate(pads_bank0_hw^.io[gpio] and PADS_BANK0_GPIO_SLEWFAST_BITS);
end;

procedure gpio_set_input_hysteresis_enabled(gpio: LongWord; enabled: Boolean);
begin
  if gpio >= NUM_BANK0_GPIOS then Exit;
  
  if enabled then
    hw_set_bits(pads_bank0_hw^.io[gpio], PADS_BANK0_GPIO_SCHMITT_BITS)
  else
    hw_clear_bits(pads_bank0_hw^.io[gpio], PADS_BANK0_GPIO_SCHMITT_BITS);
end;

function gpio_is_input_hysteresis_enabled(gpio: LongWord): Boolean;
begin
  if gpio >= NUM_BANK0_GPIOS then
    Exit(True);
    
  Result := (pads_bank0_hw^.io[gpio] and PADS_BANK0_GPIO_SCHMITT_BITS) <> 0;
end;

end.
