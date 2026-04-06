{
  Clock Unit for RP2040
  
  Based on Raspberry Pi Pico SDK - hardware/clocks
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause
  
  Converted to Free Pascal
}
unit clocks;

{$mode objfpc}
{$H+}

interface

uses
  rp2040;

const
  { Clock indices }
  clk_gpout0 = 0;
  clk_gpout1 = 1;
  clk_gpout2 = 2;
  clk_gpout3 = 3;
  clk_ref    = 4;
  clk_sys    = 5;
  clk_peri   = 6;
  clk_usb    = 7;
  clk_adc    = 8;
  clk_rtc    = 9;
  CLK_COUNT  = 10;
  
  { Clock sources for clk_ref }
  CLOCKS_CLK_REF_CTRL_SRC_VALUE_ROSC_CLKSRC_PH = 0;
  CLOCKS_CLK_REF_CTRL_SRC_VALUE_CLKSRC_CLK_REF_AUX = 1;
  CLOCKS_CLK_REF_CTRL_SRC_VALUE_XOSC_CLKSRC = 2;
  
  { Clock sources for clk_sys }
  CLOCKS_CLK_SYS_CTRL_SRC_VALUE_CLK_REF = 0;
  CLOCKS_CLK_SYS_CTRL_SRC_VALUE_CLKSRC_CLK_SYS_AUX = 1;
  
  { Auxiliary clock sources }
  CLOCKS_CLK_SYS_CTRL_AUXSRC_VALUE_CLKSRC_PLL_SYS = 0;
  CLOCKS_CLK_SYS_CTRL_AUXSRC_VALUE_CLKSRC_PLL_USB = 1;
  CLOCKS_CLK_SYS_CTRL_AUXSRC_VALUE_ROSC_CLKSRC = 2;
  CLOCKS_CLK_SYS_CTRL_AUXSRC_VALUE_XOSC_CLKSRC = 3;
  CLOCKS_CLK_SYS_CTRL_AUXSRC_VALUE_CLKSRC_GPIN0 = 4;
  CLOCKS_CLK_SYS_CTRL_AUXSRC_VALUE_CLKSRC_GPIN1 = 5;

type
  { Clock generator registers }
  TCLK_REG = packed record
    ctrl: LongWord;
    div_: LongWord;
    selected: LongWord;
  end;
  
  { Clocks hardware structure }  
  TCLOCKS_HW = packed record
    clk: array[0..CLK_COUNT-1] of TCLK_REG;
    resus_ctrl: LongWord;
    resus_status: LongWord;
    fc0_ref_khz: LongWord;
    fc0_min_khz: LongWord;
    fc0_max_khz: LongWord;
    fc0_delay: LongWord;
    fc0_interval: LongWord;
    fc0_src: LongWord;
    fc0_status: LongWord;
    fc0_result: LongWord;
    wake_en0: LongWord;
    wake_en1: LongWord;
    sleep_en0: LongWord;
    sleep_en1: LongWord;
    enabled0: LongWord;
    enabled1: LongWord;
    intr: LongWord;
    inte: LongWord;
    intf: LongWord;
    ints: LongWord;
  end;
  PCLOCKS_HW = ^TCLOCKS_HW;

var
  clocks_hw: PCLOCKS_HW absolute CLOCKS_BASE;

{ Initialize clocks to default configuration }
procedure clocks_init;

{ Get frequency of a clock in Hz }
function clock_get_hz(clk_index: LongWord): LongWord;

implementation

var
  { Configured clock frequencies }
  configured_freq: array[0..CLK_COUNT-1] of LongWord;

procedure clocks_init;
begin
  { Default frequencies after init }
  { clk_ref = 12 MHz (XOSC) }
  { clk_sys = 125 MHz (PLL_SYS) }
  { clk_peri = 125 MHz (clk_sys) }
  
  configured_freq[clk_ref] := 12000000;
  configured_freq[clk_sys] := 125000000;
  configured_freq[clk_peri] := 125000000;
  configured_freq[clk_usb] := 48000000;
  configured_freq[clk_adc] := 48000000;
  configured_freq[clk_rtc] := 46875;  { 46.875 kHz }
  
  { Note: Actual clock initialization is done in startup unit }
end;

function clock_get_hz(clk_index: LongWord): LongWord;
begin
  if clk_index < CLK_COUNT then
    Result := configured_freq[clk_index]
  else
    Result := 0;
end;

end.
