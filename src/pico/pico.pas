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

const
  TIMER_TIME_LR = TIMER_BASE + $28;
  TIMER_TIME_HR = TIMER_BASE + $2C;

function time_us_64: QWord;
var
  lo, hi: LongWord;
  pTimeLR: PLongWord absolute TIMER_TIME_LR;
  pTimeHR: PLongWord absolute TIMER_TIME_HR;
begin
  { Read hi first, then lo, then hi again to check for rollover }
  repeat
    hi := pTimeHR^;
    lo := pTimeLR^;
  until pTimeHR^ = hi;
  
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
begin
  hw_set_bits(resets_hw^.reset, bits);
end;

procedure unreset_block(bits: LongWord);
begin
  hw_clear_bits(resets_hw^.reset, bits);
end;

procedure unreset_block_wait(bits: LongWord);
begin
  hw_clear_bits(resets_hw^.reset, bits);
  while (resets_hw^.reset_done and bits) <> bits do
    { wait for reset done };
end;

procedure stdio_init_all;
begin
  { TODO: Initialize stdio (UART/USB) }
  { For now this is a stub }
  
  { Unreset IO_BANK0 and PADS_BANK0 }
  unreset_block_wait(RESETS_RESET_IO_BANK0_BITS or RESETS_RESET_PADS_BANK0_BITS);
end;

end.
