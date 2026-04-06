{
  Timer Unit for RP2040
  
  Based on Raspberry Pi Pico SDK - hardware/timer
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause
  
  Converted to Free Pascal
}
unit timer;

{$mode objfpc}
{$H+}

interface

uses
  rp2040;

type
  { Timer hardware structure }
  TTIMER_HW = packed record
    timehw: LongWord;
    timelw: LongWord;
    timehr: LongWord;
    timelr: LongWord;
    alarm: array[0..3] of LongWord;
    armed: LongWord;
    timerawh: LongWord;
    timerawl: LongWord;
    dbgpause: LongWord;
    pause: LongWord;
    intr: LongWord;
    inte: LongWord;
    intf: LongWord;
    ints: LongWord;
  end;
  PTIMER_HW = ^TTIMER_HW;

var
  timer_hw: PTIMER_HW absolute TIMER_BASE;

{ Get current time in microseconds (64-bit) }
function time_us_64: QWord;

{ Get current time in microseconds (32-bit, wraps) }
function time_us_32: LongWord;

{ Busy wait for specified microseconds }
procedure busy_wait_us(delay_us: LongWord);

{ Busy wait for specified microseconds (32-bit version) }
procedure busy_wait_us_32(delay_us: LongWord);

{ Busy wait until specified time }
procedure busy_wait_until(target: QWord);

{ Check if time has been reached }
function time_reached(target: QWord): Boolean;

implementation

function time_us_64: QWord;
var
  lo, hi: LongWord;
begin
  { Read time registers - lo first latches hi }
  repeat
    hi := timer_hw^.timerawh;
    lo := timer_hw^.timerawl;
  until timer_hw^.timerawh = hi;
  
  Result := (QWord(hi) shl 32) or lo;
end;

function time_us_32: LongWord;
begin
  Result := timer_hw^.timerawl;
end;

procedure busy_wait_us(delay_us: LongWord);
var
  target: QWord;
begin
  target := time_us_64 + delay_us;
  busy_wait_until(target);
end;

procedure busy_wait_us_32(delay_us: LongWord);
var
  start: LongWord;
begin
  start := time_us_32;
  while (time_us_32 - start) < delay_us do
    { busy wait };
end;

procedure busy_wait_until(target: QWord);
begin
  while time_us_64 < target do
    { busy wait };
end;

function time_reached(target: QWord): Boolean;
begin
  { Handle 64-bit comparison properly }
  Result := time_us_64 >= target;
end;

end.
