{
  Minimal UART Unit for RP2040
  
  Based on Raspberry Pi Pico SDK - hardware/uart
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause
  
  Converted to Free Pascal
}
unit uart;

{$mode objfpc}
{$H+}

interface

uses
  rp2040, gpio, resets, clocks;

type
  { UART hardware structure }
  TUART_HW = record
    dr: LongWord;         { Data Register }
    rsr: LongWord;        { Receive Status Register }
    _pad0: array[0..3] of LongWord;
    fr: LongWord;         { Flag Register }
    _pad1: LongWord;
    ilpr: LongWord;       { IrDA Low-Power Counter Register }
    ibrd: LongWord;       { Integer Baud Rate Register }
    fbrd: LongWord;       { Fractional Baud Rate Register }
    lcr_h: LongWord;      { Line Control Register }
    cr: LongWord;         { Control Register }
    ifls: LongWord;       { Interrupt FIFO Level Select }
    imsc: LongWord;       { Interrupt Mask Set/Clear }
    ris: LongWord;        { Raw Interrupt Status }
    mis: LongWord;        { Masked Interrupt Status }
    icr: LongWord;        { Interrupt Clear Register }
    dmacr: LongWord;      { DMA Control Register }
  end;
  PUART_HW = ^TUART_HW;

const
  { UART Flag Register bits }
  UART_FR_TXFE = $80;  { Transmit FIFO empty }
  UART_FR_RXFF = $40;  { Receive FIFO full }
  UART_FR_TXFF = $20;  { Transmit FIFO full }
  UART_FR_RXFE = $10;  { Receive FIFO empty }
  UART_FR_BUSY = $08;  { UART busy }
  
  { UART LCR_H bits }
  UART_LCR_H_WLEN_5 = $00;
  UART_LCR_H_WLEN_6 = $20;
  UART_LCR_H_WLEN_7 = $40;
  UART_LCR_H_WLEN_8 = $60;
  UART_LCR_H_FEN    = $10;  { FIFO enable }
  UART_LCR_H_STP2   = $08;  { 2 stop bits }
  UART_LCR_H_EPS    = $04;  { Even parity select }
  UART_LCR_H_PEN    = $02;  { Parity enable }
  UART_LCR_H_BRK    = $01;  { Send break }
  
  { UART CR bits }
  UART_CR_RXE   = $200;  { Receive enable }
  UART_CR_TXE   = $100;  { Transmit enable }
  UART_CR_UARTEN = $01;  { UART enable }

var
  uart0_hw: PUART_HW = PUART_HW(UART0_BASE);
  uart1_hw: PUART_HW = PUART_HW(UART1_BASE);

{ Initialize UART }
function uart_init(uart: PUART_HW; baudrate: LongWord): LongWord;

{ Deinitialize UART }
procedure uart_deinit(uart: PUART_HW);

{ Set UART baudrate }
function uart_set_baudrate(uart: PUART_HW; baudrate: LongWord): LongWord;

{ Set UART format (data bits, stop bits, parity) }
procedure uart_set_format(uart: PUART_HW; data_bits, stop_bits: LongWord; parity: Boolean);

{ Check if UART is writable }
function uart_is_writable(uart: PUART_HW): Boolean;

{ Check if UART is readable }
function uart_is_readable(uart: PUART_HW): Boolean;

{ Write a character }
procedure uart_putc(uart: PUART_HW; c: Char);

{ Write a string }
procedure uart_puts(uart: PUART_HW; const s: string);

{ Read a character }
function uart_getc(uart: PUART_HW): Char;

{ Set UART pins }
procedure uart_set_pin(uart: PUART_HW; tx_pin, rx_pin: LongWord);

implementation

const
  UART_INIT_TIMEOUT = 1000000;

function uart_get_reset_bits(uart: PUART_HW): LongWord;
begin
  if uart = uart0_hw then
    Result := RESETS_RESET_UART0_BITS
  else
    Result := RESETS_RESET_UART1_BITS;
end;

function uart_get_index(uart: PUART_HW): LongWord;
begin
  if uart = uart0_hw then
    Result := 0
  else
    Result := 1;
end;

function uart_init(uart: PUART_HW; baudrate: LongWord): LongWord;
var
  reset_bits: LongWord;
  wait_count: LongWord;
begin
  reset_bits := uart_get_reset_bits(uart);

  { Release reset and wait for the peripheral to become ready. }
  unreset_block(reset_bits);

  wait_count := 0;
  while ((resets_hw^.reset_done and reset_bits) <> reset_bits) and (wait_count < UART_INIT_TIMEOUT) do
    Inc(wait_count);

  uart^.cr := 0;
  uart^.lcr_h := 0;
  uart^.imsc := 0;
  uart^.dmacr := 0;
  uart^.rsr := 0;

  { Clear pending interrupts before reconfiguration. }
  uart^.icr := $7FF;
  
  { Set baudrate }
  Result := uart_set_baudrate(uart, baudrate);
  
  { Set format: 8N1 with FIFO enabled. }
  uart^.lcr_h := UART_LCR_H_WLEN_8 or UART_LCR_H_FEN;

  { Enable UART, TX, and RX }
  uart^.cr := UART_CR_UARTEN or UART_CR_TXE or UART_CR_RXE;
end;

procedure uart_deinit(uart: PUART_HW);
var
  reset_bits: LongWord;
begin
  reset_bits := uart_get_reset_bits(uart);

  reset_block(reset_bits);
end;

function uart_set_baudrate(uart: PUART_HW; baudrate: LongWord): LongWord;
var
  baud_rate_div: LongWord;
  peri_freq: LongWord;
begin
  if baudrate = 0 then
    baudrate := 115200;

  { Get peripheral clock frequency }
  peri_freq := clock_get_hz(clk_peri);
  if peri_freq = 0 then
    peri_freq := 125000000;
  
  { Calculate baud rate divisor }
  { baud_rate_div = 64 * peri_freq / (16 * baudrate) = 4 * peri_freq / baudrate }
  baud_rate_div := (4 * peri_freq) div baudrate;
  if baud_rate_div = 0 then
    baud_rate_div := 1;
  
  { Set integer and fractional parts }
  uart^.ibrd := baud_rate_div shr 6;
  uart^.fbrd := baud_rate_div and $3F;
  
  { Dummy write to latch values }
  hw_set_bits(uart^.lcr_h, 0);
  
  Result := (4 * peri_freq) div baud_rate_div;
end;

procedure uart_set_format(uart: PUART_HW; data_bits, stop_bits: LongWord; parity: Boolean);
var
  lcr_h: LongWord;
begin
  lcr_h := 0;
  
  { Data bits }
  case data_bits of
    5: lcr_h := lcr_h or UART_LCR_H_WLEN_5;
    6: lcr_h := lcr_h or UART_LCR_H_WLEN_6;
    7: lcr_h := lcr_h or UART_LCR_H_WLEN_7;
    8: lcr_h := lcr_h or UART_LCR_H_WLEN_8;
  end;
  
  { Stop bits }
  if stop_bits = 2 then
    lcr_h := lcr_h or UART_LCR_H_STP2;
  
  { Parity }
  if parity then
    lcr_h := lcr_h or UART_LCR_H_PEN or UART_LCR_H_EPS;
  
  { FIFO enable (preserve) }
  lcr_h := lcr_h or (uart^.lcr_h and UART_LCR_H_FEN);
  
  uart^.lcr_h := lcr_h;
end;

function uart_is_writable(uart: PUART_HW): Boolean;
begin
  Result := (uart^.fr and UART_FR_TXFF) = 0;
end;

function uart_is_readable(uart: PUART_HW): Boolean;
begin
  Result := (uart^.fr and UART_FR_RXFE) = 0;
end;

procedure uart_putc(uart: PUART_HW; c: Char);
begin
  while not uart_is_writable(uart) do
    { wait };
  uart^.dr := Ord(c);
end;

procedure uart_puts(uart: PUART_HW; const s: string);
var
  i: Integer;
begin
  for i := 1 to Length(s) do
    uart_putc(uart, s[i]);
end;

function uart_getc(uart: PUART_HW): Char;
begin
  while not uart_is_readable(uart) do
    { wait };
  Result := Chr(uart^.dr and $FF);
end;

procedure uart_set_pin(uart: PUART_HW; tx_pin, rx_pin: LongWord);
begin
  { Set TX pin function to UART }
  if tx_pin < NUM_BANK0_GPIOS then
    gpio_set_function(tx_pin, gfUART);
  
  { Set RX pin function to UART }
  if rx_pin < NUM_BANK0_GPIOS then
  begin
    gpio_set_function(rx_pin, gfUART);
    gpio_set_input_enabled(rx_pin, True);
  end;
end;

end.
