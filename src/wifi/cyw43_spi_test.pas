{
  CYW43 SPI Test - Read Test Register
  
  Uses correct gSPI byte swap format
  Expected: Read 0xFEEDBEAD from SPI_READ_TEST_REGISTER (0x0014)
}
unit cyw43_spi_test;

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

  // PAD register bits
  PAD_SCHMITT     = $02;  // bit 1 - Schmitt trigger enable
  PAD_PDE         = $04;  // bit 2 - Pull-down enable
  PAD_PUE         = $08;  // bit 3 - Pull-up enable
  PAD_IE          = $40;  // bit 6 - Input enable

  // CYW43 GPIO pins
  PIN_POWER = 23;  // WL_REG_ON
  PIN_DATA  = 24;  // SPI DATA
  PIN_CS    = 25;  // SPI CS
  PIN_CLK   = 29;  // SPI CLK

  // gSPI constants
  SPI_READ_TEST_REGISTER = $0014;
  TEST_PATTERN = $FEEDBEAD;
  
  BUS_FUNCTION = 0;

// Direct register access
procedure reg_write(addr, value: LongWord); inline;
begin
  PLongWord(addr)^ := value;
end;

function reg_read(addr: LongWord): LongWord; inline;
begin
  Result := PLongWord(addr)^;
end;

// GPIO functions
procedure gpio_set_function(gpio: LongWord; func: LongWord);
begin
  reg_write(IO_BANK0_BASE + (gpio * 8) + 4, func);
end;

procedure gpio_set_output(gpio: LongWord);
begin
  reg_write(SIO_BASE + SIO_GPIO_OE_SET, 1 shl gpio);
end;

procedure gpio_set_input(gpio: LongWord);
begin
  reg_write(SIO_BASE + SIO_GPIO_OE_CLR, 1 shl gpio);
end;

procedure gpio_set_high(gpio: LongWord);
begin
  reg_write(SIO_BASE + SIO_GPIO_OUT_SET, 1 shl gpio);
end;

procedure gpio_set_low(gpio: LongWord);
begin
  reg_write(SIO_BASE + SIO_GPIO_OUT_CLR, 1 shl gpio);
end;

function gpio_get(gpio: LongWord): Boolean;
begin
  Result := (reg_read(SIO_BASE + SIO_GPIO_IN) and (1 shl gpio)) <> 0;
end;

// SPI bit-bang
procedure spi_write_bit(bit: Boolean);
begin
  if bit then
    gpio_set_high(PIN_DATA)
  else
    gpio_set_low(PIN_DATA);
  
  gpio_set_high(PIN_CLK);
  asm nop; nop; nop; nop; nop; nop; nop; nop; end;
  gpio_set_low(PIN_CLK);
  asm nop; nop; nop; nop; end;
end;

function spi_read_bit: Boolean;
begin
  gpio_set_high(PIN_CLK);
  asm nop; nop; nop; nop; nop; nop; nop; nop; end;
  Result := gpio_get(PIN_DATA);
  gpio_set_low(PIN_CLK);
  asm nop; nop; nop; nop; end;
end;

procedure spi_write_byte(b: Byte);
var
  i: Integer;
begin
  gpio_set_output(PIN_DATA);
  for i := 7 downto 0 do
    spi_write_bit((b and (1 shl i)) <> 0);
end;

function spi_read_byte: Byte;
var
  i: Integer;
begin
  Result := 0;
  gpio_set_input(PIN_DATA);
  for i := 7 downto 0 do
  begin
    if spi_read_bit then
      Result := Result or (1 shl i);
  end;
end;

// Write 4 bytes in swap32 format: [byte1, byte0, byte3, byte2]
procedure spi_write_swap32(w: LongWord);
begin
  spi_write_byte((w shr 8) and $FF);   // byte 1
  spi_write_byte(w and $FF);            // byte 0
  spi_write_byte((w shr 24) and $FF);  // byte 3
  spi_write_byte((w shr 16) and $FF);  // byte 2
end;

// Read 4 bytes in swap32 format
function spi_read_swap32: LongWord;
var
  b0, b1, b2, b3: Byte;
begin
  b1 := spi_read_byte;  // received as byte 0 position
  b0 := spi_read_byte;  // received as byte 1 position  
  b3 := spi_read_byte;  // received as byte 2 position
  b2 := spi_read_byte;  // received as byte 3 position
  
  // Reconstruct: buf[1] | buf[0]<<8 | buf[3]<<16 | buf[2]<<24
  Result := LongWord(b0) or (LongWord(b1) shl 8) or 
            (LongWord(b2) shl 16) or (LongWord(b3) shl 24);
end;

// Build gSPI command
function pack_cmd(write_op: Boolean; incr: Boolean; fn: LongWord; 
                  addr: LongWord; sz: LongWord): LongWord;
var
  cmd: LongWord;
begin
  cmd := 0;
  if write_op then cmd := cmd or $80000000;  // bit 31
  if incr then cmd := cmd or $40000000;      // bit 30
  cmd := cmd or ((fn and 3) shl 28);         // bits 29-28
  cmd := cmd or ((addr and $1FFFF) shl 11);  // bits 27-11
  cmd := cmd or (sz and $7FF);               // bits 10-0
  Result := cmd;
end;

// Read register with swap32 format - Half-duplex SPI
// Phase 1: Write command (4 bytes), Phase 2: Read response (4 bytes)
// Returns raw bytes in rxbuf for debugging
// swap32 = rev16: swap bytes within each 16-bit half (0x12345678 -> 0x34127856)
function read_reg_u32_swap_debug(fn: LongWord; reg: LongWord; var raw: array of Byte): LongWord;
var
  cmd: LongWord;
  txbuf: array[0..3] of Byte;
  i, bit: Integer;
  tx_byte, rx_byte: Byte;
begin
  cmd := pack_cmd(False, True, fn, reg, 4);
  
  // rev16 swap: 0xAABBCCDD -> [BB, AA, DD, CC]
  txbuf[0] := (cmd shr 8) and $FF;   // byte 1 (BB)
  txbuf[1] := cmd and $FF;            // byte 0 (AA)
  txbuf[2] := (cmd shr 24) and $FF;  // byte 3 (DD)
  txbuf[3] := (cmd shr 16) and $FF;  // byte 2 (CC)
  
  gpio_set_low(PIN_CS);
  
  // Phase 1: Write command (4 bytes) - MSB first
  gpio_set_output(PIN_DATA);
  for i := 0 to 3 do
  begin
    tx_byte := txbuf[i];
    for bit := 7 downto 0 do  // MSB first
    begin
      if (tx_byte and (1 shl bit)) <> 0 then
        gpio_set_high(PIN_DATA)
      else
        gpio_set_low(PIN_DATA);
      
      asm nop; nop; nop; nop; end;
      gpio_set_high(PIN_CLK);
      asm nop; nop; nop; nop; nop; nop; nop; nop; end;
      gpio_set_low(PIN_CLK);
      asm nop; nop; nop; nop; end;
    end;
  end;
  
  // Phase 2: Read response - skip first 4 bytes (padding), then read 4 bytes
  // SDK does: send 4, receive 8, use bytes 4-7
  gpio_set_input(PIN_DATA);
  
  // Skip first 32 bits (4 bytes padding)
  for i := 0 to 31 do
  begin
    gpio_set_high(PIN_CLK);
    asm nop; nop; nop; nop; end;
    gpio_set_low(PIN_CLK);
    asm nop; nop; nop; nop; end;
  end;
  
  // Read actual 4 bytes - LSB first, sample on rising edge
  for i := 0 to 3 do
  begin
    rx_byte := 0;
    for bit := 0 to 7 do  // LSB first
    begin
      gpio_set_high(PIN_CLK);
      asm nop; nop; nop; nop; end;
      
      // Sample on rising edge
      if gpio_get(PIN_DATA) then
        rx_byte := rx_byte or (1 shl bit);
        
      asm nop; nop; nop; nop; end;
      gpio_set_low(PIN_CLK);
      asm nop; nop; nop; nop; end;
    end;
    raw[i] := rx_byte;
  end;
  
  gpio_set_high(PIN_CS);
  
  // Print all possible byte orders for debugging
  // As-is
  printf('    raw as-is:     [%02X %02X %02X %02X] = 0x%02X%02X%02X%02X' + #10,
    raw[0], raw[1], raw[2], raw[3], raw[0], raw[1], raw[2], raw[3]);
  // Reversed
  printf('    raw reversed:  [%02X %02X %02X %02X] = 0x%02X%02X%02X%02X' + #10,
    raw[3], raw[2], raw[1], raw[0], raw[3], raw[2], raw[1], raw[0]);
  // Big-endian
  printf('    big-endian:    0x%08X' + #10,
    (LongWord(raw[0]) shl 24) or (LongWord(raw[1]) shl 16) or (LongWord(raw[2]) shl 8) or LongWord(raw[3]));
  // Little-endian
  printf('    little-endian: 0x%08X' + #10,
    (LongWord(raw[3]) shl 24) or (LongWord(raw[2]) shl 16) or (LongWord(raw[1]) shl 8) or LongWord(raw[0]));
  // Swap16
  printf('    swap16:        0x%08X' + #10,
    (LongWord(raw[1]) shl 24) or (LongWord(raw[0]) shl 16) or (LongWord(raw[3]) shl 8) or LongWord(raw[2]));
  // Return as-is for now
  Result := (LongWord(raw[0]) shl 24) or (LongWord(raw[1]) shl 16) or (LongWord(raw[2]) shl 8) or LongWord(raw[3]);
end;

// Simpler version without debug
function read_reg_u32_swap(fn: LongWord; reg: LongWord): LongWord;
var
  raw: array[0..3] of Byte;
begin
  Result := read_reg_u32_swap_debug(fn, reg, raw);
end;

procedure init_gpio;
var
  pad_addr: LongWord;
begin
  // Power pin
  gpio_set_function(PIN_POWER, GPIO_FUNC_SIO);
  gpio_set_low(PIN_POWER);
  gpio_set_output(PIN_POWER);
  
  // CS pin (high = inactive)
  gpio_set_function(PIN_CS, GPIO_FUNC_SIO);
  gpio_set_high(PIN_CS);
  gpio_set_output(PIN_CS);
  
  // CLK pin
  gpio_set_function(PIN_CLK, GPIO_FUNC_SIO);
  gpio_set_low(PIN_CLK);
  gpio_set_output(PIN_CLK);
  
  // DATA pin - configure pad with schmitt trigger and pull-down
  gpio_set_function(PIN_DATA, GPIO_FUNC_SIO);
  gpio_set_low(PIN_DATA);
  gpio_set_output(PIN_DATA);
  
  // Configure data pin pad: schmitt + pull-down + input enable
  pad_addr := PADS_BANK0_BASE + 4 + (PIN_DATA * 4);  // +4 for VOLTAGE_SELECT
  reg_write(pad_addr, PAD_SCHMITT or PAD_PDE or PAD_IE or $30);  // $30 = drive strength 4mA
end;

procedure power_on;
begin
  // Proper reset sequence from pico-sdk
  gpio_set_low(PIN_POWER);     // Make sure off first
  picow_delay_ms(20);
  gpio_set_high(PIN_POWER);    // Power on
  picow_delay_ms(250);         // Wait 250ms for chip to stabilize
  // Don't touch data pin here - SPI transfer will manage it
end;

procedure power_off;
begin
  gpio_set_low(PIN_POWER);
  picow_delay_ms(10);
end;

procedure PASCALMAIN; cdecl; [public, alias: 'PASCALMAIN'];
var
  loop, attempt: Integer;
  val: LongWord;
  raw: array[0..3] of Byte;
begin
  printf('CYW43 SPI Test - Read Test Register' + #10);
  printf('Expected: 0x%08X (FEEDBEAD)' + #10 + #10, TEST_PATTERN);
  
  loop := 0;
  while True do
  begin
    Inc(loop);
    printf('=== Loop %d ===' + #10, loop);
    
    printf('Init GPIO...' + #10);
    init_gpio;
    
    printf('Power ON CYW43...' + #10);
    power_on;
    
    printf('Reading test register (0x%04X)...' + #10, SPI_READ_TEST_REGISTER);
    
    for attempt := 1 to 3 do
    begin
      val := read_reg_u32_swap_debug(BUS_FUNCTION, SPI_READ_TEST_REGISTER, raw);
      printf('  Attempt %d: raw=[%02X %02X %02X %02X] -> 0x%08X', 
             attempt, raw[0], raw[1], raw[2], raw[3], val);
      
      if val = TEST_PATTERN then
        printf(' - OK!' + #10)
      else
        printf(#10);
        
      picow_delay_ms(10);
    end;
    
    printf('Power OFF...' + #10 + #10);
    power_off;
    
    picow_delay_ms(3000);
  end;
end;

end.
