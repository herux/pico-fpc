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

end.
