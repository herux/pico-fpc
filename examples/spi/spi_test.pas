{
  SPI Loopback Test for Raspberry Pi Pico

  Connect GPIO19 (SPI0 TX/MOSI) to GPIO16 (SPI0 RX/MISO).
  LED on GPIO25 is ON when received bytes match the test pattern.
}
program spi_test;

{$mode objfpc}
{$H+}

uses
  pico,
  gpio,
  spi,
  platform;

const
  LED_PIN = PICO_DEFAULT_LED_PIN;
  PATTERN_LEN = 4;

var
  tx_buf: array[0..PATTERN_LEN - 1] of Byte = ($55, $AA, $0F, $F0);
  rx_buf: array[0..PATTERN_LEN - 1] of Byte;
  i: LongWord;
  ok: Boolean;

begin
  stdio_init_all;

  gpio_init(LED_PIN);
  gpio_set_dir(LED_PIN, gdOutput);

  spi_set_pin(
    spi0_hw,
    PICO_DEFAULT_SPI_SCK_PIN,
    PICO_DEFAULT_SPI_TX_PIN,
    PICO_DEFAULT_SPI_RX_PIN,
    PICO_DEFAULT_SPI_CSN_PIN
  );

  spi_init(spi0_hw, 1000000);
  spi_set_format(spi0_hw, 8, SPI_CPOL_0, SPI_CPHA_0, SPI_MSB_FIRST);

  while True do
  begin
    spi_write_read_blocking(spi0_hw, @tx_buf[0], @rx_buf[0], PATTERN_LEN);

    ok := True;
    for i := 0 to PATTERN_LEN - 1 do
      if rx_buf[i] <> tx_buf[i] then
        ok := False;

    gpio_put(LED_PIN, ok);
    if ok then
      sleep_ms(800)
    else
      sleep_ms(120);
    gpio_put(LED_PIN, False);
    sleep_ms(120);
  end;
end.
