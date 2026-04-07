{
  Resets Unit for RP2040
  
  Based on Raspberry Pi Pico SDK - hardware/resets
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause
  
  Converted to Free Pascal
}
unit resets;

{$mode objfpc}
{$H+}

interface

uses
  rp2040;

{ Reset specified hardware blocks }
procedure reset_block(bits: LongWord);

{ Remove reset from specified hardware blocks }
procedure unreset_block(bits: LongWord);

{ Remove reset and wait for completion }
procedure unreset_block_wait(bits: LongWord);

implementation

const
  RESETS_RESET = RESETS_BASE;        // offset 0
  RESETS_RESET_DONE = RESETS_BASE + $08; // offset 8

procedure reset_block(bits: LongWord);
begin
  { Set bits in reset register - put blocks into reset }
  PLongWord(RESETS_RESET)^ := PLongWord(RESETS_RESET)^ or bits;
end;

procedure unreset_block(bits: LongWord);
begin
  { Clear bits in reset register - take blocks out of reset }
  PLongWord(RESETS_RESET)^ := PLongWord(RESETS_RESET)^ and not bits;
end;

procedure unreset_block_wait(bits: LongWord);
begin
  { Clear bits to unreset - direct pointer access like blink_standalone }
  PLongWord(RESETS_RESET)^ := PLongWord(RESETS_RESET)^ and not bits;
  { Wait for reset done }
  while (PLongWord(RESETS_RESET_DONE)^ and bits) <> bits do
    { wait };
end;

end.
