{
  Minimal Test - No GPIO, just printf
  
  Verify Pascal + C runtime works before testing GPIO
}
unit minimal_test;

{$mode objfpc}
{$H-}

interface

procedure PASCALMAIN; cdecl;

implementation

// External C functions
procedure printf(fmt: PChar); cdecl; varargs; external;
procedure picow_delay_ms(ms: LongWord); cdecl; external;

procedure PASCALMAIN; cdecl; [public, alias: 'PASCALMAIN'];
var
  counter: Integer;
begin
  printf('Pascal PASCALMAIN started!' + #10);
  
  counter := 0;
  while True do
  begin
    Inc(counter);
    printf('Counter = %d' + #10, counter);
    picow_delay_ms(1000);
  end;
end;

end.
