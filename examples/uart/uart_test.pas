{
  UART Test Example for Raspberry Pi Pico

  Sends a heartbeat message on UART0 (GPIO0 TX) every second.
  Serial config: 115200 8N1
}
program uart_test;

{$mode objfpc}
{$H+}

uses
  pico,
  uart;

begin
  stdio_init_all;

  while True do
  begin
    uart_puts(uart0_hw, 'uart_test: hello from FreePascal'#13#10);
    sleep_ms(1000);
  end;
end.
