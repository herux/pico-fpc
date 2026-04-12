{
  UART Echo Example for Raspberry Pi Pico

  Reads bytes from UART0 and echoes them back.
  Serial config: 115200 8N1
}
program uart_echo;

{$mode objfpc}
{$H+}

uses
  pico,
  uart,
  platform;

var
  c: Char;

begin
  stdio_init_all;
  uart_set_pin(uart0_hw, PICO_DEFAULT_UART_TX_PIN, PICO_DEFAULT_UART_RX_PIN);
  uart_init(uart0_hw, PICO_DEFAULT_UART_BAUD_RATE);
  uart_puts(uart0_hw, 'uart_echo ready'#13#10);

  while True do
  begin
    if uart_is_readable(uart0_hw) then
    begin
      c := uart_getc(uart0_hw);
      uart_putc(uart0_hw, c);
    end;
  end;
end.
