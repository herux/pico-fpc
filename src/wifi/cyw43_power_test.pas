{
  CYW43 Power Test - Step 1 & 2
  
  Test:
  1. Init GPIO untuk CYW43
  2. Power ON CYW43 chip
  3. Baca Chip ID via SPI
  4. Indikasi hasil via serial (printf dari C)
  
  Catatan: LED Pico W butuh firmware, belum bisa dikontrol.
  Test ini memastikan power dan SPI communication berjalan.
}
unit cyw43_power_test;

{$mode objfpc}
{$H-}

interface

procedure PASCALMAIN; cdecl;

implementation

uses
  cyw43_ll;

// External C functions
procedure printf(fmt: PChar); cdecl; varargs; external;
procedure picow_delay_ms(ms: LongWord); cdecl; external;

procedure PASCALMAIN; cdecl; [public, alias: 'PASCALMAIN'];
var
  chip_id: LongWord;
  i, loop: Integer;
begin
  // Loop forever printing status
  loop := 0;
  while True do
  begin
    Inc(loop);
    printf('=== Loop %d ===' + #10, loop);
    printf('Step 1: Initialize GPIO...' + #10);
    
    // Initialize CYW43 GPIO pins
    cyw43_power_init;
    printf('  GPIO pins configured' + #10);
    
    printf('Step 2: Power ON CYW43...' + #10);
    cyw43_power_on;
    
    if cyw43_is_powered then
      printf('  CYW43 powered ON' + #10)
    else
      printf('  ERROR: Power check failed!' + #10);
    
    // Wait a bit for chip to stabilize
    picow_delay_ms(100);
    
    printf('Step 3: Reading Chip ID via SPI...' + #10);
    
    // Try to read chip ID
    for i := 1 to 3 do
    begin
      chip_id := cyw43_get_chip_id;
      printf('  Attempt %d: Chip ID = 0x%08X' + #10, i, chip_id);
      picow_delay_ms(50);
    end;
    
    printf('Waiting 5 seconds...' + #10 + #10);
    picow_delay_ms(5000);
    
    // Power off and restart
    cyw43_power_off;
    picow_delay_ms(100);
  end;
end;

end.
