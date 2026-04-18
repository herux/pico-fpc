{
  Pico SDK Main Unit for Free Pascal
  
  Based on Raspberry Pi Pico SDK
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause
  
  Converted to Free Pascal
}
unit pico;

{$mode objfpc}
{$H+}

interface

uses
  rp2040, gpio;

{ Timing functions }
procedure sleep_ms(ms: LongWord);
procedure sleep_us(us: LongWord);
procedure busy_wait_us(us: LongWord);
procedure busy_wait_ms(ms: LongWord);

{ Get time since boot in microseconds }
function time_us_64: QWord;

{ Reset subsystems }
procedure reset_block(bits: LongWord);
procedure unreset_block(bits: LongWord);
procedure unreset_block_wait(bits: LongWord);

{ SDK initialization }
procedure stdio_init_all;

implementation

uses
  clocks, platform;

const
  TIMER_TIME_LR = TIMER_BASE + $28;
  TIMER_TIME_HR = TIMER_BASE + $2C;

  { XOSC and CLOCKS registers used to get stable reference clock (12MHz crystal) }
  XOSC_CTRL          = XOSC_BASE + $00;
  XOSC_STATUS        = XOSC_BASE + $04;
  XOSC_STARTUP       = XOSC_BASE + $0C;

  CLOCKS_CLK_REF_CTRL     = CLOCKS_BASE + $30;
  CLOCKS_CLK_REF_DIV      = CLOCKS_BASE + $34;
  CLOCKS_CLK_REF_SELECTED = CLOCKS_BASE + $38;
  CLOCKS_CLK_SYS_CTRL     = CLOCKS_BASE + $3C;
  CLOCKS_CLK_SYS_DIV      = CLOCKS_BASE + $40;
  CLOCKS_CLK_SYS_SELECTED = CLOCKS_BASE + $44;
  CLOCKS_CLK_PERI_CTRL    = CLOCKS_BASE + $48;

  PLL_SYS_CS              = PLL_SYS_BASE + $00;
  PLL_SYS_PWR             = PLL_SYS_BASE + $04;
  PLL_SYS_FBDIV_INT       = PLL_SYS_BASE + $08;
  PLL_SYS_PRIM            = PLL_SYS_BASE + $0C;

  WATCHDOG_TICK           = WATCHDOG_BASE + $2C;

  XOSC_CTRL_FREQ_RANGE_1_15MHZ = $00000AA0;
  XOSC_CTRL_ENABLE_MAGIC       = $00FAB000;
  XOSC_STATUS_STABLE_BITS      = $80000000;

  CLOCKS_CLK_REF_CTRL_SRC_XOSC_CLKSRC         = 2;
  CLOCKS_CLK_REF_DIV_INT_1                    = 1 shl 8;
  CLOCKS_CLK_REF_SELECTED_XOSC                = 1 shl 2;
  CLOCKS_CLK_SYS_CTRL_SRC_CLKSRC_CLK_SYS_AUX  = 1;
  CLOCKS_CLK_SYS_CTRL_AUXSRC_CLKSRC_PLL_SYS   = 0 shl 5;
  CLOCKS_CLK_SYS_SELECTED_PLL_SYS             = 1 shl 1;
  CLOCKS_CLK_PERI_CTRL_ENABLE                 = 1 shl 11;

  WATCHDOG_TICK_ENABLE_BITS                   = 1 shl 9;
  WATCHDOG_TICK_CYCLES_12MHZ                  = 12;

  PLL_PWR_PD_BITS                             = 1 shl 0;
  PLL_PWR_VCOPD_BITS                          = 1 shl 5;
  PLL_PWR_POSTDIVPD_BITS                      = 1 shl 3;
  PLL_CS_LOCK_BITS                            = 1 shl 31;

function time_us_64: QWord;
var
  lo, hi: LongWord;
begin
  { Read hi first, then lo, then hi again to check for rollover }
  repeat
    hi := PLongWord(TIMER_TIME_HR)^;
    lo := PLongWord(TIMER_TIME_LR)^;
  until PLongWord(TIMER_TIME_HR)^ = hi;
  
  Result := (QWord(hi) shl 32) or lo;
end;

procedure busy_wait_us(us: LongWord);
var
  start: QWord;
begin
  start := time_us_64;
  while (time_us_64 - start) < us do
    { busy wait };
end;

procedure busy_wait_ms(ms: LongWord);
begin
  busy_wait_us(ms * 1000);
end;

procedure sleep_us(us: LongWord);
begin
  { Simple implementation - just busy wait }
  { TODO: Implement proper low-power sleep }
  busy_wait_us(us);
end;

procedure sleep_ms(ms: LongWord);
begin
  sleep_us(ms * 1000);
end;

procedure reset_block(bits: LongWord);
const
  RESETS_RESET = RESETS_BASE;
begin
  PLongWord(RESETS_RESET)^ := PLongWord(RESETS_RESET)^ or bits;
end;

procedure unreset_block(bits: LongWord);
const
  RESETS_RESET = RESETS_BASE;
begin
  PLongWord(RESETS_RESET)^ := PLongWord(RESETS_RESET)^ and not bits;
end;

procedure unreset_block_wait(bits: LongWord);
const
  RESETS_RESET = RESETS_BASE;
  RESETS_RESET_DONE = RESETS_BASE + $08;
begin
  PLongWord(RESETS_RESET)^ := PLongWord(RESETS_RESET)^ and not bits;
  while (PLongWord(RESETS_RESET_DONE)^ and bits) <> bits do
    { wait for reset done };
end;

procedure xosc_init;
begin
  { Configure and enable XOSC 12MHz }
  PLongWord(XOSC_CTRL)^ := XOSC_CTRL_FREQ_RANGE_1_15MHZ;
  PLongWord(XOSC_STARTUP)^ := 47; { same startup delay used by pico-sdk }
  PLongWord(XOSC_CTRL)^ := PLongWord(XOSC_CTRL)^ or XOSC_CTRL_ENABLE_MAGIC;

  while (PLongWord(XOSC_STATUS)^ and XOSC_STATUS_STABLE_BITS) = 0 do
    { wait for crystal stable };

  { Switch glitchless clk_ref source directly to XOSC with divider = 1 }
  PLongWord(CLOCKS_CLK_REF_DIV)^ := CLOCKS_CLK_REF_DIV_INT_1;
  PLongWord(CLOCKS_CLK_REF_CTRL)^ := CLOCKS_CLK_REF_CTRL_SRC_XOSC_CLKSRC;

  while (PLongWord(CLOCKS_CLK_REF_SELECTED)^ and CLOCKS_CLK_REF_SELECTED_XOSC) = 0 do
    { wait for clk_ref source switch };
end;

procedure pll_sys_init_125mhz;
begin
  reset_block(RESETS_RESET_PLL_SYS_BITS);
  unreset_block_wait(RESETS_RESET_PLL_SYS_BITS);

  { 12 MHz / 1 * 125 = 1500 MHz VCO; / 6 / 2 = 125 MHz output }
  PLongWord(PLL_SYS_CS)^ := 1;
  PLongWord(PLL_SYS_FBDIV_INT)^ := 125;
  PLongWord(PLL_SYS_PWR)^ := 0;

  while (PLongWord(PLL_SYS_CS)^ and PLL_CS_LOCK_BITS) = 0 do
    { wait for pll lock };

  PLongWord(PLL_SYS_PRIM)^ := (6 shl 16) or (2 shl 12);
  hw_clear_bits(PLongWord(PLL_SYS_PWR)^, PLL_PWR_POSTDIVPD_BITS);
end;

procedure init_system_clock_125mhz;
begin
  pll_sys_init_125mhz;

  { Configure clk_sys to use PLL_SYS auxiliary source. }
  hw_write_masked(
    PLongWord(CLOCKS_CLK_SYS_CTRL)^,
    CLOCKS_CLK_SYS_CTRL_AUXSRC_CLKSRC_PLL_SYS,
    $000000E0
  );
  hw_write_masked(
    PLongWord(CLOCKS_CLK_SYS_CTRL)^,
    CLOCKS_CLK_SYS_CTRL_SRC_CLKSRC_CLK_SYS_AUX,
    $00000001
  );
  PLongWord(CLOCKS_CLK_SYS_DIV)^ := 1 shl 8;

  while (PLongWord(CLOCKS_CLK_SYS_SELECTED)^ and CLOCKS_CLK_SYS_SELECTED_PLL_SYS) = 0 do
    { wait for clk_sys source switch };

  { Route clk_peri from clk_sys. }
  PLongWord(CLOCKS_CLK_PERI_CTRL)^ := CLOCKS_CLK_PERI_CTRL_ENABLE;
end;

procedure init_timer_tick_1mhz;
begin
  { On RP2040, timer/SysTick derive from watchdog tick generator.
    Program it explicitly to 1MHz from clk_ref (12MHz / 12). }
  PLongWord(WATCHDOG_TICK)^ := WATCHDOG_TICK_CYCLES_12MHZ or WATCHDOG_TICK_ENABLE_BITS;
end;

procedure stdio_init_all;
begin
  xosc_init;
  init_system_clock_125mhz;

  { Keep reported peripheral clocks consistent with the actual hardware clocks. }
  clocks_init;
  init_timer_tick_1mhz;

  { Unreset IO_BANK0, PADS_BANK0, and TIMER }
  unreset_block_wait(RESETS_RESET_IO_BANK0_BITS or 
                     RESETS_RESET_PADS_BANK0_BITS or
                     RESETS_RESET_TIMER_BITS);
end;

{ _haltproc is called by FPC runtime when program exits (halt/exit call) }
{ For embedded systems, this should be an infinite loop }
{ Note: For flash builds, crt0.S provides this symbol - use --allow-multiple-definition }
procedure _haltproc; public name '_haltproc'; noreturn;
begin
  while True do
    asm
      nop
    end;
end;

end.
