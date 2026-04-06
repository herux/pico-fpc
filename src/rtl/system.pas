{
  Minimal System Unit for ARM Embedded (RP2040)
  
  This is a bare-bones System unit required by Free Pascal
  for embedded targets where no OS is available.
}
unit system;

{$mode objfpc}
{$H-}
{$INLINE ON}
{$MODESWITCH ADVANCEDRECORDS}

interface

{ Basic types }
type
  DWord    = LongWord;
  Cardinal = LongWord;
  Integer  = SmallInt;
  
  PChar    = ^Char;
  PPChar   = ^PChar;
  
  PByte    = ^Byte;
  PWord    = ^Word;
  PLongWord = ^LongWord;
  PInteger = ^Integer;
  PSmallInt = ^SmallInt;
  PShortInt = ^ShortInt;
  PInt64   = ^Int64;
  PQWord   = ^QWord;
  PBoolean = ^Boolean;
  
  PtrInt   = LongInt;
  PtrUInt  = LongWord;
  SizeInt  = LongInt;
  SizeUInt = LongWord;
  
  ValReal  = Double;
  Real     = Double;

  TTypeKind = (tkUnknown, tkInteger, tkChar, tkEnumeration, tkFloat,
               tkSet, tkMethod, tkSString, tkLString, tkAString,
               tkWString, tkVariant, tkArray, tkRecord, tkInterface,
               tkClass, tkObject, tkWChar, tkBool, tkInt64, tkQWord,
               tkDynArray, tkInterfaceRaw, tkProcVar, tkUString,
               tkUChar, tkHelper, tkFile, tkClassRef, tkPointer);

{ String types }
type
  ShortString = String[255];

{ Exception handling - minimal }  
type
  TExceptAddr = Pointer;
  PExceptAddr = ^TExceptAddr;
  
  PJmp_buf = ^jmp_buf;
  jmp_buf = packed record
    r4, r5, r6, r7, r8, r9, r10, r11: LongWord;
    sp, lr: LongWord;
  end;

{ Runtime error codes }
const
  reNone          = 0;
  reOutOfMemory   = 1;
  reInvalidPtr    = 2;
  reDivByZero     = 3;
  reRangeError    = 4;
  reIntOverflow   = 5;
  reInvalidOp     = 6;
  reZeroDivide    = 7;
  reOverflow      = 8;
  reUnderflow     = 9;
  reInvalidCast   = 10;
  reAccessViolation = 11;
  reStackOverflow = 12;
  reControlBreak  = 13;

{ Exit code }
var
  ExitCode: LongInt; public name 'operatingsystem_result';
  ErrorAddr: Pointer;
  ErrorCode: Word;

{ Heap management }
var
  HeapStart: Pointer; external name '__heap_start__';
  HeapEnd: Pointer; external name '__heap_end__';
  
type
  PHeapBlock = ^THeapBlock;
  THeapBlock = record
    Size: PtrUInt;
    Next: PHeapBlock;
  end;

var
  FreeList: PHeapBlock;
  HeapPtr: Pointer;

{ Basic heap functions }
function GetMem(Size: PtrUInt): Pointer;
procedure FreeMem(P: Pointer);
function ReAllocMem(var P: Pointer; NewSize: PtrUInt): Pointer;

{ String functions - minimal }
function Length(const S: ShortString): Integer;
procedure SetLength(var S: ShortString; NewLen: Integer);

{ Move/Fill memory }
procedure Move(const Source; var Dest; Count: SizeInt);
procedure FillChar(var X; Count: SizeInt; Value: Byte);
procedure FillWord(var X; Count: SizeInt; Value: Word);
procedure FillDWord(var X; Count: SizeInt; Value: DWord);

{ Compare memory }
function CompareMem(P1, P2: Pointer; Length: PtrUInt): Boolean;

{ Runtime procedures }
procedure Halt(ErrNum: Integer = 0);

{ Division support }
function fpc_div_dword(n, z: DWord): DWord; compilerproc;
function fpc_mod_dword(n, z: DWord): DWord; compilerproc;
function fpc_div_longint(n, z: LongInt): LongInt; compilerproc;
function fpc_mod_longint(n, z: LongInt): LongInt; compilerproc;

implementation

{ Heap implementation - simple bump allocator }
procedure InitHeap;
begin
  HeapPtr := @HeapStart;
  FreeList := nil;
end;

function GetMem(Size: PtrUInt): Pointer;
var
  AlignedSize: PtrUInt;
begin
  { Align to 4 bytes }
  AlignedSize := (Size + 3) and not 3;
  
  if PtrUInt(HeapPtr) + AlignedSize > PtrUInt(@HeapEnd) then
  begin
    Result := nil;  { Out of memory }
    Exit;
  end;
  
  Result := HeapPtr;
  HeapPtr := Pointer(PtrUInt(HeapPtr) + AlignedSize);
end;

procedure FreeMem(P: Pointer);
begin
  { Simple allocator - memory not actually freed }
  { TODO: Implement proper free list }
end;

function ReAllocMem(var P: Pointer; NewSize: PtrUInt): Pointer;
var
  NewP: Pointer;
begin
  if NewSize = 0 then
  begin
    FreeMem(P);
    P := nil;
    Result := nil;
    Exit;
  end;
  
  NewP := GetMem(NewSize);
  if (P <> nil) and (NewP <> nil) then
  begin
    Move(P^, NewP^, NewSize);  { May copy more than needed }
    FreeMem(P);
  end;
  P := NewP;
  Result := NewP;
end;

{ String functions }
function Length(const S: ShortString): Integer;
begin
  Result := Ord(S[0]);
end;

procedure SetLength(var S: ShortString; NewLen: Integer);
begin
  if NewLen > 255 then NewLen := 255;
  if NewLen < 0 then NewLen := 0;
  S[0] := Chr(NewLen);
end;

{ Memory functions }
procedure Move(const Source; var Dest; Count: SizeInt);
var
  S, D: PByte;
  I: SizeInt;
begin
  if Count <= 0 then Exit;
  
  S := @Source;
  D := @Dest;
  
  if PtrUInt(D) > PtrUInt(S) then
  begin
    { Copy backwards }
    for I := Count - 1 downto 0 do
      D[I] := S[I];
  end
  else
  begin
    { Copy forwards }
    for I := 0 to Count - 1 do
      D[I] := S[I];
  end;
end;

procedure FillChar(var X; Count: SizeInt; Value: Byte);
var
  P: PByte;
  I: SizeInt;
begin
  P := @X;
  for I := 0 to Count - 1 do
    P[I] := Value;
end;

procedure FillWord(var X; Count: SizeInt; Value: Word);
var
  P: PWord;
  I: SizeInt;
begin
  P := @X;
  for I := 0 to Count - 1 do
    P[I] := Value;
end;

procedure FillDWord(var X; Count: SizeInt; Value: DWord);
var
  P: PLongWord;
  I: SizeInt;
begin
  P := @X;
  for I := 0 to Count - 1 do
    P[I] := Value;
end;

function CompareMem(P1, P2: Pointer; Length: PtrUInt): Boolean;
var
  I: PtrUInt;
begin
  for I := 0 to Length - 1 do
    if PByte(P1)[I] <> PByte(P2)[I] then
    begin
      Result := False;
      Exit;
    end;
  Result := True;
end;

{ Halt - infinite loop for embedded }
procedure Halt(ErrNum: Integer = 0);
begin
  ExitCode := ErrNum;
  while True do
    { Infinite loop };
end;

{ Software division - needed for Cortex-M0 (no hardware divide) }
function fpc_div_dword(n, z: DWord): DWord; compilerproc; [public, alias: 'FPC_DIV_DWORD'];
var
  q, r, bit: DWord;
begin
  if z = 0 then
  begin
    Result := 0;
    Exit;  { Division by zero }
  end;
  
  q := 0;
  r := 0;
  bit := 32;
  
  while bit > 0 do
  begin
    Dec(bit);
    r := r shl 1;
    if (n and (DWord(1) shl bit)) <> 0 then
      r := r or 1;
    if r >= z then
    begin
      r := r - z;
      q := q or (DWord(1) shl bit);
    end;
  end;
  
  Result := q;
end;

function fpc_mod_dword(n, z: DWord): DWord; compilerproc; [public, alias: 'FPC_MOD_DWORD'];
var
  q, r, bit: DWord;
begin
  if z = 0 then
  begin
    Result := 0;
    Exit;
  end;
  
  r := 0;
  bit := 32;
  
  while bit > 0 do
  begin
    Dec(bit);
    r := r shl 1;
    if (n and (DWord(1) shl bit)) <> 0 then
      r := r or 1;
    if r >= z then
      r := r - z;
  end;
  
  Result := r;
end;

function fpc_div_longint(n, z: LongInt): LongInt; compilerproc; [public, alias: 'FPC_DIV_LONGINT'];
var
  neg: Boolean;
  un, uz: DWord;
begin
  neg := (n < 0) xor (z < 0);
  if n < 0 then un := DWord(-n) else un := DWord(n);
  if z < 0 then uz := DWord(-z) else uz := DWord(z);
  
  Result := LongInt(fpc_div_dword(un, uz));
  if neg then Result := -Result;
end;

function fpc_mod_longint(n, z: LongInt): LongInt; compilerproc; [public, alias: 'FPC_MOD_LONGINT'];
var
  neg: Boolean;
  un, uz: DWord;
begin
  neg := n < 0;
  if n < 0 then un := DWord(-n) else un := DWord(n);
  if z < 0 then uz := DWord(-z) else uz := DWord(z);
  
  Result := LongInt(fpc_mod_dword(un, uz));
  if neg then Result := -Result;
end;

{ Initialization }
begin
  InitHeap;
  ExitCode := 0;
  ErrorAddr := nil;
  ErrorCode := 0;
end.
