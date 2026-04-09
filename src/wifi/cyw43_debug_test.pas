{
  CYW43 Debug Test - Print before each operation
  
  Find where it crashes
}
unit cyw43_debug_test;

{$mode objfpc}
{$H-}

interface

procedure PASCALMAIN; cdecl;

implementation

// External C functions
procedure printf(fmt: PChar); cdecl; varargs; external;
procedure picow_delay_ms(ms: LongWord); cdecl; external;

const
  // RP2040 Register bases
  SIO_BASE        = $D0000000;
  IO_BANK0_BASE   = $40014000;
  PADS_BANK0_BASE = $4001C000;
  
  // GPIO function
  GPIO_FUNC_SIO   = 5;
  
  // SIO offsets  
  SIO_GPIO_OUT_SET = $14;
  SIO_GPIO_OUT_CLR = $18;
  SIO_GPIO_OE_SET  = $24;
  SIO_GPIO_OE_CLR  = $28;
  SIO_GPIO_IN      = $04;

  // CYW43 GPIO pins
  PIN_POWER = 23;  // WL_REG_ON

// Direct register access
procedure reg_write(addr, value: LongWord);
begin
  PLongWord(addr)^ := value;
end;

function reg_read(addr: LongWord): LongWord;
begin
  Result := PLongWord(addr)^;
end;

procedure PASCALMAIN; cdecl; [public, alias: 'PASCALMAIN'];
var
  counter: Integer;
  val: LongWord;
begin
  printf('DEBUG: PASCALMAIN started' + #10);
  
  counter := 0;
  while True do
  begin
    Inc(counter);
    printf('=== Loop %d ===' + #10, counter);
    
    // Step 1: Read SIO_GPIO_IN (should be safe)
    printf('  Reading SIO_GPIO_IN...' + #10);
    val := reg_read(SIO_BASE + SIO_GPIO_IN);
    printf('  GPIO_IN = 0x%08X' + #10, val);
    
    // Step 2: Read SIO_GPIO_OUT (should be safe)
    printf('  Reading SIO_BASE...' + #10);
    val := reg_read(SIO_BASE);
    printf('  SIO_BASE[0] = 0x%08X' + #10, val);
    
    // Step 3: Set GPIO23 function
    printf('  Setting GPIO23 function to SIO...' + #10);
    reg_write(IO_BANK0_BASE + (PIN_POWER * 8) + 4, GPIO_FUNC_SIO);
    printf('  Done!' + #10);
    
    // Step 4: Set GPIO23 low
    printf('  Setting GPIO23 low...' + #10);
    reg_write(SIO_BASE + SIO_GPIO_OUT_CLR, 1 shl PIN_POWER);
    printf('  Done!' + #10);
    
    // Step 5: Enable GPIO23 output
    printf('  Enabling GPIO23 output...' + #10);
    reg_write(SIO_BASE + SIO_GPIO_OE_SET, 1 shl PIN_POWER);
    printf('  Done!' + #10);
    
    // Step 6: Set GPIO23 high (power on)
    printf('  Setting GPIO23 high (power on)...' + #10);
    reg_write(SIO_BASE + SIO_GPIO_OUT_SET, 1 shl PIN_POWER);
    printf('  CYW43 should be powered now!' + #10);
    
    printf('  Waiting 3 seconds...' + #10 + #10);
    picow_delay_ms(3000);
  end;
end;

end.
