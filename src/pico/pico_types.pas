{
  Pico Types and Common Definitions
  
  Based on Raspberry Pi Pico SDK
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause
  
  Converted to Free Pascal
}
unit pico_types;

{$mode objfpc}
{$H+}

interface

type
  { Unsigned integer types }
  uint = LongWord;
  uint8_t = Byte;
  uint16_t = Word;
  uint32_t = LongWord;
  uint64_t = QWord;
  
  { Signed integer types }
  int8_t = ShortInt;
  int16_t = SmallInt;
  int32_t = LongInt;
  int64_t = Int64;
  
  { Boolean type }
  bool = Boolean;
  
  { IO register types }
  io_rw_32 = LongWord;
  io_ro_32 = LongWord;
  io_wo_32 = LongWord;

const
  { Boolean constants (C-style) }
  false_ = False;
  true_ = True;
  
  { Bit manipulation macros converted to functions/constants }
  function BIT(n: LongWord): LongWord; inline;
  function BITS(hi, lo: LongWord): LongWord; inline;

implementation

function BIT(n: LongWord): LongWord; inline;
begin
  Result := 1 shl n;
end;

function BITS(hi, lo: LongWord): LongWord; inline;
var
  i: LongWord;
begin
  Result := 0;
  for i := lo to hi do
    Result := Result or (1 shl i);
end;

end.
