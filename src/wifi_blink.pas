{
  WiFi Blink Example for Pico W
  
  This example demonstrates using the CYW43 driver to blink the onboard LED
  on the Pico W. Unlike regular Pico, the LED on Pico W is connected to 
  the CYW43 WiFi chip's GPIO, not the RP2040.
}
program wifi_blink;

{$mode objfpc}
{$H+}

uses
  cyw43;

var
  led_on: Boolean;
  i: Integer;

// Simple delay loop
procedure delay_ms(ms: LongWord);
var
  j: LongWord;
begin
  for j := 0 to ms * 1000 do
    asm nop end;
end;

begin
  // Initialize CYW43 driver
  if cyw43_arch_init <> 0 then
  begin
    // Initialization failed
    while True do ;
  end;
  
  led_on := False;
  
  // Blink LED forever
  while True do
  begin
    led_on := not led_on;
    cyw43_arch_gpio_put(0, led_on);  // GPIO 0 = LED on Pico W
    
    // Wait
    for i := 0 to 500000 do
      cyw43_arch_poll;  // Keep polling for WiFi background tasks
  end;
end.
