{
  Minimal SPI Unit for RP2040

  Based on Raspberry Pi Pico SDK - hardware/spi
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause

  Converted to Free Pascal
}
unit spi;

{$mode objfpc}
{$H+}

interface

uses
  rp2040, gpio, resets, clocks;

type
  TSPI_CPOL = (SPI_CPOL_0 = 0, SPI_CPOL_1 = 1);
  TSPI_CPHA = (SPI_CPHA_0 = 0, SPI_CPHA_1 = 1);
  TSPI_Order = (SPI_MSB_FIRST = 0, SPI_LSB_FIRST = 1);

  TSPI_HW = packed record
    cr0: LongWord;
    cr1: LongWord;
    dr: LongWord;
    sr: LongWord;
    cpsr: LongWord;
    imsc: LongWord;
    ris: LongWord;
    mis: LongWord;
    icr: LongWord;
    dmacr: LongWord;
  end;
  PSPI_HW = ^TSPI_HW;

var
  spi0_hw: PSPI_HW absolute SPI0_BASE;
  spi1_hw: PSPI_HW absolute SPI1_BASE;

function spi_init(spi: PSPI_HW; baudrate: LongWord): LongWord;
procedure spi_deinit(spi: PSPI_HW);

function spi_set_baudrate(spi: PSPI_HW; baudrate: LongWord): LongWord;
procedure spi_set_format(spi: PSPI_HW; data_bits: LongWord; cpol: TSPI_CPOL; cpha: TSPI_CPHA; order: TSPI_Order);

function spi_is_readable(spi: PSPI_HW): Boolean;
function spi_is_writable(spi: PSPI_HW): Boolean;
function spi_is_busy(spi: PSPI_HW): Boolean;

function spi_write_read_blocking(spi: PSPI_HW; txbuf, rxbuf: PByte; len: LongWord): LongWord;
function spi_write_blocking(spi: PSPI_HW; src: PByte; len: LongWord): LongWord;
function spi_read_blocking(spi: PSPI_HW; repeated_tx_data: Byte; dst: PByte; len: LongWord): LongWord;

procedure spi_set_pin(spi: PSPI_HW; sck_pin, tx_pin, rx_pin, csn_pin: LongWord);

implementation

const
  SPI_SSPCR0_DSS_BITS = $0000000F;
  SPI_SSPCR0_FRF_BITS = $00000030;
  SPI_SSPCR0_SPO_BITS = $00000040;
  SPI_SSPCR0_SPH_BITS = $00000080;
  SPI_SSPCR0_SCR_BITS = $0000FF00;

  SPI_SSPCR1_LBM_BITS = $00000001;
  SPI_SSPCR1_SSE_BITS = $00000002;
  SPI_SSPCR1_MS_BITS  = $00000004;

  SPI_SSPSR_TFE_BITS = $00000001;
  SPI_SSPSR_TNF_BITS = $00000002;
  SPI_SSPSR_RNE_BITS = $00000004;
  SPI_SSPSR_RFF_BITS = $00000008;
  SPI_SSPSR_BSY_BITS = $00000010;

function spi_get_index(spi: PSPI_HW): LongWord;
begin
  if spi = spi0_hw then
    Result := 0
  else
    Result := 1;
end;

function spi_set_baudrate(spi: PSPI_HW; baudrate: LongWord): LongWord;
var
  freq_in: LongWord;
  prescale: LongWord;
  postdiv: LongWord;
  actual_baudrate: LongWord;
begin
  if baudrate = 0 then
    baudrate := 1;

  freq_in := clock_get_hz(clk_peri);

  prescale := 2;
  while (prescale <= 254) and ((freq_in div (prescale * 256)) > baudrate) do
    Inc(prescale, 2);

  if prescale > 254 then
    prescale := 254;

  postdiv := (freq_in + (prescale * baudrate) - 1) div (prescale * baudrate);
  if postdiv < 1 then
    postdiv := 1;
  if postdiv > 256 then
    postdiv := 256;

  hw_clear_bits(spi^.cr1, SPI_SSPCR1_SSE_BITS);
  spi^.cpsr := prescale;
  hw_write_masked(spi^.cr0, (postdiv - 1) shl 8, SPI_SSPCR0_SCR_BITS);
  hw_set_bits(spi^.cr1, SPI_SSPCR1_SSE_BITS);

  actual_baudrate := freq_in div (prescale * postdiv);
  Result := actual_baudrate;
end;

procedure spi_set_format(spi: PSPI_HW; data_bits: LongWord; cpol: TSPI_CPOL; cpha: TSPI_CPHA; order: TSPI_Order);
var
  cr0: LongWord;
begin
  if data_bits < 4 then
    data_bits := 4;
  if data_bits > 16 then
    data_bits := 16;

  cr0 := 0;
  cr0 := cr0 or ((data_bits - 1) and SPI_SSPCR0_DSS_BITS);
  cr0 := cr0 or ((LongWord(cpol) shl 6) and SPI_SSPCR0_SPO_BITS);
  cr0 := cr0 or ((LongWord(cpha) shl 7) and SPI_SSPCR0_SPH_BITS);

  hw_clear_bits(spi^.cr1, SPI_SSPCR1_SSE_BITS);
  hw_write_masked(spi^.cr1, LongWord(order) shl 7, $00000080);
  hw_write_masked(spi^.cr0, cr0, SPI_SSPCR0_DSS_BITS or SPI_SSPCR0_FRF_BITS or SPI_SSPCR0_SPO_BITS or SPI_SSPCR0_SPH_BITS);
  hw_set_bits(spi^.cr1, SPI_SSPCR1_SSE_BITS);
end;

function spi_init(spi: PSPI_HW; baudrate: LongWord): LongWord;
var
  reset_bits: LongWord;
begin
  if spi = spi0_hw then
    reset_bits := RESETS_RESET_SPI0_BITS
  else
    reset_bits := RESETS_RESET_SPI1_BITS;

  reset_block(reset_bits);
  unreset_block_wait(reset_bits);

  spi^.cr1 := 0;
  spi^.cr0 := 0;

  spi_set_format(spi, 8, SPI_CPOL_0, SPI_CPHA_0, SPI_MSB_FIRST);
  hw_clear_bits(spi^.cr1, SPI_SSPCR1_MS_BITS or SPI_SSPCR1_LBM_BITS);
  Result := spi_set_baudrate(spi, baudrate);
end;

procedure spi_deinit(spi: PSPI_HW);
var
  reset_bits: LongWord;
begin
  if spi = spi0_hw then
    reset_bits := RESETS_RESET_SPI0_BITS
  else
    reset_bits := RESETS_RESET_SPI1_BITS;

  reset_block(reset_bits);
end;

function spi_is_readable(spi: PSPI_HW): Boolean;
begin
  Result := (spi^.sr and SPI_SSPSR_RNE_BITS) <> 0;
end;

function spi_is_writable(spi: PSPI_HW): Boolean;
begin
  Result := (spi^.sr and SPI_SSPSR_TNF_BITS) <> 0;
end;

function spi_is_busy(spi: PSPI_HW): Boolean;
begin
  Result := (spi^.sr and SPI_SSPSR_BSY_BITS) <> 0;
end;

function spi_write_read_blocking(spi: PSPI_HW; txbuf, rxbuf: PByte; len: LongWord): LongWord;
var
  i: LongWord;
  txbyte: Byte;
begin
  for i := 0 to len - 1 do
  begin
    if txbuf <> nil then
    begin
      txbyte := txbuf^;
      Inc(txbuf);
    end
    else
      txbyte := 0;

    while not spi_is_writable(spi) do
      { wait };
    spi^.dr := txbyte;

    while not spi_is_readable(spi) do
      { wait };

    if rxbuf <> nil then
    begin
      rxbuf^ := Byte(spi^.dr and $FF);
      Inc(rxbuf);
    end
    else
      txbyte := Byte(spi^.dr and $FF);
  end;

  Result := len;
end;

function spi_write_blocking(spi: PSPI_HW; src: PByte; len: LongWord): LongWord;
begin
  Result := spi_write_read_blocking(spi, src, nil, len);
end;

function spi_read_blocking(spi: PSPI_HW; repeated_tx_data: Byte; dst: PByte; len: LongWord): LongWord;
var
  i: LongWord;
begin
  for i := 0 to len - 1 do
  begin
    while not spi_is_writable(spi) do
      { wait };
    spi^.dr := repeated_tx_data;

    while not spi_is_readable(spi) do
      { wait };

    if dst <> nil then
    begin
      dst^ := Byte(spi^.dr and $FF);
      Inc(dst);
    end;
  end;

  Result := len;
end;

procedure spi_set_pin(spi: PSPI_HW; sck_pin, tx_pin, rx_pin, csn_pin: LongWord);
begin
  if sck_pin < NUM_BANK0_GPIOS then
    gpio_set_function(sck_pin, gfSPI);
  if tx_pin < NUM_BANK0_GPIOS then
    gpio_set_function(tx_pin, gfSPI);
  if rx_pin < NUM_BANK0_GPIOS then
    gpio_set_function(rx_pin, gfSPI);
  if csn_pin < NUM_BANK0_GPIOS then
    gpio_set_function(csn_pin, gfSPI);
end;

end.
