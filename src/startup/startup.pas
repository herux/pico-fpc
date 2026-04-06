{
  RP2040 Startup Code for Free Pascal
  
  Based on Raspberry Pi Pico SDK
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause
  
  Converted to Free Pascal
}
unit startup;

{$mode objfpc}
{$H+}

interface

uses
  rp2040;

{ Called from reset - initializes clocks, resets, and runtime }
procedure runtime_init;

{ Initialize clocks to default configuration }
procedure clocks_init;

{ Initialize the watchdog }
procedure watchdog_init;

implementation

const
  { XOSC registers }
  XOSC_CTRL      = XOSC_BASE + $00;
  XOSC_STATUS    = XOSC_BASE + $04;
  XOSC_STARTUP   = XOSC_BASE + $0C;
  
  { Clock generator registers }
  CLK_REF_CTRL   = CLOCKS_BASE + $30;
  CLK_REF_DIV    = CLOCKS_BASE + $34;
  CLK_SYS_CTRL   = CLOCKS_BASE + $3C;
  CLK_SYS_DIV    = CLOCKS_BASE + $40;
  CLK_PERI_CTRL  = CLOCKS_BASE + $48;
  
  { PLL registers }
  PLL_SYS_CS     = PLL_SYS_BASE + $00;
  PLL_SYS_PWR    = PLL_SYS_BASE + $04;
  PLL_SYS_FBDIV  = PLL_SYS_BASE + $08;
  PLL_SYS_PRIM   = PLL_SYS_BASE + $0C;
  
  { XOSC frequency (12 MHz crystal on Pico) }
  XOSC_MHZ = 12;

procedure xosc_init;
var
  pCtrl: PLongWord absolute XOSC_CTRL;
  pStatus: PLongWord absolute XOSC_STATUS;
  pStartup: PLongWord absolute XOSC_STARTUP;
begin
  { Configure startup delay (1ms at 12MHz = 12000 cycles) }
  pStartup^ := (12000 div 256);
  
  { Enable XOSC }
  pCtrl^ := $FAB000 or $AA0; { ENABLE=FAB, FREQ_RANGE=1-15MHz }
  
  { Wait for XOSC to be stable }
  while (pStatus^ and $80000000) = 0 do
    { wait };
end;

procedure pll_init(pll_base: LongWord; refdiv, vco_freq, post_div1, post_div2: LongWord);
var
  fbdiv: LongWord;
  pCS: PLongWord;
  pPWR: PLongWord;
  pFBDIV: PLongWord;
  pPRIM: PLongWord;
begin
  pCS := PLongWord(pll_base + $00);
  pPWR := PLongWord(pll_base + $04);
  pFBDIV := PLongWord(pll_base + $08);
  pPRIM := PLongWord(pll_base + $0C);
  
  { Calculate feedback divider }
  fbdiv := vco_freq div (XOSC_MHZ div refdiv);
  
  { Reset PLL }
  if pll_base = PLL_SYS_BASE then
    hw_set_bits(resets_hw^.reset, RESETS_RESET_PLL_SYS_BITS)
  else
    hw_set_bits(resets_hw^.reset, RESETS_RESET_PLL_USB_BITS);
    
  if pll_base = PLL_SYS_BASE then
    hw_clear_bits(resets_hw^.reset, RESETS_RESET_PLL_SYS_BITS)
  else
    hw_clear_bits(resets_hw^.reset, RESETS_RESET_PLL_USB_BITS);
  
  { Wait for reset done }
  if pll_base = PLL_SYS_BASE then
    while (resets_hw^.reset_done and RESETS_RESET_PLL_SYS_BITS) = 0 do { wait }
  else
    while (resets_hw^.reset_done and RESETS_RESET_PLL_USB_BITS) = 0 do { wait };
  
  { Configure PLL }
  pCS^ := refdiv;
  pFBDIV^ := fbdiv;
  
  { Power on PLL (clear VCOPD and PD bits) }
  hw_clear_bits(pPWR^, $21);
  
  { Wait for PLL lock }
  while (pCS^ and $80000000) = 0 do
    { wait };
  
  { Set up post dividers }
  pPRIM^ := (post_div1 shl 16) or (post_div2 shl 12);
  
  { Power on post dividers }
  hw_clear_bits(pPWR^, $08);
end;

procedure clocks_init;
var
  pRefCtrl: PLongWord absolute CLK_REF_CTRL;
  pRefDiv: PLongWord absolute CLK_REF_DIV;
  pSysCtrl: PLongWord absolute CLK_SYS_CTRL;
  pSysDiv: PLongWord absolute CLK_SYS_DIV;
  pPeriCtrl: PLongWord absolute CLK_PERI_CTRL;
begin
  { Start crystal oscillator }
  xosc_init;
  
  { Configure clk_ref to use XOSC }
  pRefCtrl^ := 2; { XOSC as source }
  pRefDiv^ := 1 shl 8; { Divider = 1 }
  
  { Initialize PLL_SYS to 125 MHz }
  { 12 MHz * 125 / 6 / 2 = 125 MHz }
  pll_init(PLL_SYS_BASE, 1, 1500, 6, 2);
  
  { Configure clk_sys to use PLL_SYS }
  { First set aux mux to PLL_SYS }
  hw_write_masked(pSysCtrl^, 0, $E0); { AUXSRC = 0 (PLL_SYS) }
  { Then switch glitchless mux to aux }
  hw_write_masked(pSysCtrl^, 1, $01); { SRC = 1 (aux) }
  pSysDiv^ := 1 shl 8; { Divider = 1 }
  
  { Configure clk_peri to use clk_sys }
  pPeriCtrl^ := $800; { Enable, source = clk_sys }
end;

procedure watchdog_init;
begin
  { TODO: Initialize watchdog if needed }
  { For now, watchdog is disabled by default }
end;

procedure runtime_init;
begin
  { Initialize resets - unreset critical peripherals }
  unreset_block_wait(
    RESETS_RESET_IO_BANK0_BITS or
    RESETS_RESET_PADS_BANK0_BITS or
    RESETS_RESET_TIMER_BITS
  );
  
  { Initialize clocks to default configuration }
  clocks_init;
  
  { Initialize watchdog }
  watchdog_init;
end;

procedure unreset_block_wait(bits: LongWord);
begin
  hw_clear_bits(resets_hw^.reset, bits);
  while (resets_hw^.reset_done and bits) <> bits do
    { wait };
end;

end.
