{
  CYW43 Low-Level Driver for Pico W - Step 1
  
  Tahap pertama: Power ON chip CYW43 via GPIO23
  
  Pico W Pinout:
    GPIO23 = WL_REG_ON (power enable)
    GPIO24 = SPI DATA (MOSI/MISO shared)  
    GPIO25 = SPI CS (active low)
    GPIO29 = SPI CLK
}
unit cyw43_ll;

{$mode objfpc}
{$H-}

interface

const
  // CYW43 GPIO pins on RP2040
  CYW43_PIN_WL_REG_ON = 23;  // Power enable
  CYW43_PIN_WL_DATA   = 24;  // SPI data (bidirectional)
  CYW43_PIN_WL_CS     = 25;  // SPI chip select
  CYW43_PIN_WL_CLK    = 29;  // SPI clock

  // RP2040 Register bases
  SIO_BASE        = $D0000000;
  IO_BANK0_BASE   = $40014000;
  PADS_BANK0_BASE = $4001C000;
  RESETS_BASE     = $4000C000;

  // GPIO function
  GPIO_FUNC_SIO   = 5;
  GPIO_FUNC_NULL  = 31;

  // SIO offsets  
  SIO_GPIO_OUT_SET = $14;
  SIO_GPIO_OUT_CLR = $18;
  SIO_GPIO_OE_SET  = $24;
  SIO_GPIO_OE_CLR  = $28;
  SIO_GPIO_IN      = $04;

// Initialize CYW43 power
procedure cyw43_power_init;

// Power ON CYW43 chip
procedure cyw43_power_on;

// Power OFF CYW43 chip
procedure cyw43_power_off;

// Check if CYW43 is powered
function cyw43_is_powered: Boolean;

// Simple delay (busy wait)
procedure cyw43_delay_us(us: LongWord);
procedure cyw43_delay_ms(ms: LongWord);

// SPI functions
procedure spi_cs_low;
procedure spi_cs_high;
procedure spi_write_byte(b: Byte);
function spi_read_byte: Byte;

// CYW43 register access
function cyw43_read_reg(addr: LongWord): LongWord;
procedure cyw43_write_reg(addr: LongWord; value: LongWord);

// Get chip ID (expected: $43430 or similar)
function cyw43_get_chip_id: LongWord;

implementation

// Direct register access (avoid FPC STRB issue)
procedure reg_write(addr, value: LongWord); inline;
begin
  PLongWord(addr)^ := value;
end;

function reg_read(addr: LongWord): LongWord; inline;
begin
  Result := PLongWord(addr)^;
end;

// Set GPIO function
procedure gpio_set_function(gpio: LongWord; func: LongWord);
var
  ctrl_addr: LongWord;
begin
  ctrl_addr := IO_BANK0_BASE + (gpio * 8) + 4;
  reg_write(ctrl_addr, func);
end;

// Enable GPIO output
procedure gpio_set_output(gpio: LongWord);
begin
  reg_write(SIO_BASE + SIO_GPIO_OE_SET, 1 shl gpio);
end;

// Disable GPIO output (input mode)
procedure gpio_set_input(gpio: LongWord);
begin
  reg_write(SIO_BASE + SIO_GPIO_OE_CLR, 1 shl gpio);
end;

// Set GPIO high
procedure gpio_set_high(gpio: LongWord);
begin
  reg_write(SIO_BASE + SIO_GPIO_OUT_SET, 1 shl gpio);
end;

// Set GPIO low
procedure gpio_set_low(gpio: LongWord);
begin
  reg_write(SIO_BASE + SIO_GPIO_OUT_CLR, 1 shl gpio);
end;

// Read GPIO
function gpio_get(gpio: LongWord): Boolean;
begin
  Result := (reg_read(SIO_BASE + SIO_GPIO_IN) and (1 shl gpio)) <> 0;
end;

// Simple delay - busy wait
procedure cyw43_delay_us(us: LongWord);
var
  i: LongWord;
begin
  // ~10 cycles per iteration at 125MHz ≈ 0.08us
  // So multiply by ~12 for 1us
  for i := 1 to us * 12 do
    asm nop end;
end;

procedure cyw43_delay_ms(ms: LongWord);
var
  i: LongWord;
begin
  for i := 1 to ms do
    cyw43_delay_us(1000);
end;

// Initialize GPIO for CYW43 power control
procedure cyw43_power_init;
begin
  // Set GPIO23 (WL_REG_ON) as output, initially low
  gpio_set_function(CYW43_PIN_WL_REG_ON, GPIO_FUNC_SIO);
  gpio_set_low(CYW43_PIN_WL_REG_ON);
  gpio_set_output(CYW43_PIN_WL_REG_ON);
  
  // Set CS high (inactive) initially
  gpio_set_function(CYW43_PIN_WL_CS, GPIO_FUNC_SIO);
  gpio_set_high(CYW43_PIN_WL_CS);
  gpio_set_output(CYW43_PIN_WL_CS);
  
  // Set CLK low initially  
  gpio_set_function(CYW43_PIN_WL_CLK, GPIO_FUNC_SIO);
  gpio_set_low(CYW43_PIN_WL_CLK);
  gpio_set_output(CYW43_PIN_WL_CLK);
  
  // Data pin as output initially
  gpio_set_function(CYW43_PIN_WL_DATA, GPIO_FUNC_SIO);
  gpio_set_low(CYW43_PIN_WL_DATA);
  gpio_set_output(CYW43_PIN_WL_DATA);
end;

// Power ON CYW43 - bring WL_REG_ON high
procedure cyw43_power_on;
begin
  gpio_set_high(CYW43_PIN_WL_REG_ON);
  // Wait for chip to power up (datasheet says 2ms minimum)
  cyw43_delay_ms(5);
end;

// Power OFF CYW43
procedure cyw43_power_off;
begin
  gpio_set_low(CYW43_PIN_WL_REG_ON);
  cyw43_delay_ms(1);
end;

// Check power status
function cyw43_is_powered: Boolean;
begin
  // Read back the output state
  Result := gpio_get(CYW43_PIN_WL_REG_ON);
end;

// ============================================================
// SPI Bit-Bang (Step 2)
// ============================================================

// Assert CS (active low)
procedure spi_cs_low;
begin
  gpio_set_low(CYW43_PIN_WL_CS);
end;

// Deassert CS
procedure spi_cs_high;
begin
  gpio_set_high(CYW43_PIN_WL_CS);
end;

// Set data pin as output
procedure spi_data_output;
begin
  gpio_set_output(CYW43_PIN_WL_DATA);
end;

// Set data pin as input  
procedure spi_data_input;
begin
  gpio_set_input(CYW43_PIN_WL_DATA);
end;

// Write one bit (MSB first, mode 0)
procedure spi_write_bit(bit: Boolean);
begin
  // Set data
  if bit then
    gpio_set_high(CYW43_PIN_WL_DATA)
  else
    gpio_set_low(CYW43_PIN_WL_DATA);
  
  // Clock high
  gpio_set_high(CYW43_PIN_WL_CLK);
  // Small delay
  asm nop; nop; nop; nop; end;
  // Clock low
  gpio_set_low(CYW43_PIN_WL_CLK);
  asm nop; nop; nop; nop; end;
end;

// Read one bit
function spi_read_bit: Boolean;
begin
  // Clock high - data sampled by us
  gpio_set_high(CYW43_PIN_WL_CLK);
  asm nop; nop; nop; nop; end;
  // Read data
  Result := gpio_get(CYW43_PIN_WL_DATA);
  // Clock low
  gpio_set_low(CYW43_PIN_WL_CLK);
  asm nop; nop; nop; nop; end;
end;

// Write byte (MSB first)
procedure spi_write_byte(b: Byte);
var
  i: Integer;
begin
  spi_data_output;
  for i := 7 downto 0 do
    spi_write_bit((b and (1 shl i)) <> 0);
end;

// Read byte (MSB first)
function spi_read_byte: Byte;
var
  i: Integer;
begin
  Result := 0;
  spi_data_input;
  for i := 7 downto 0 do
  begin
    if spi_read_bit then
      Result := Result or (1 shl i);
  end;
end;

// Write 32-bit word (MSB first)
procedure spi_write_word(w: LongWord);
begin
  spi_write_byte((w shr 24) and $FF);
  spi_write_byte((w shr 16) and $FF);
  spi_write_byte((w shr 8) and $FF);
  spi_write_byte(w and $FF);
end;

// Read 32-bit word  
function spi_read_word: LongWord;
begin
  Result := LongWord(spi_read_byte) shl 24;
  Result := Result or (LongWord(spi_read_byte) shl 16);
  Result := Result or (LongWord(spi_read_byte) shl 8);
  Result := Result or spi_read_byte;
end;

// ============================================================
// CYW43 SPI Protocol (gSPI)
// ============================================================

const
  // gSPI command format:
  // Bit 31: Write=1, Read=0
  // Bit 30: Increment address
  // Bit 29-28: Function (0=backplane, 1=WLAN, 2=BT)
  // Bit 27-17: Address
  // Bit 16-0: Size
  
  GSPI_CMD_WRITE      = $80000000;
  GSPI_CMD_READ       = $00000000;
  GSPI_CMD_INCR_ADDR  = $40000000;
  GSPI_FUNC_BUS       = 0 shl 28;  // Backplane function
  GSPI_FUNC_WLAN      = 1 shl 28;
  GSPI_FUNC_BT        = 2 shl 28;

// Read from bus (backplane) register
function cyw43_read_reg(addr: LongWord): LongWord;
var
  cmd: LongWord;
begin
  cmd := GSPI_CMD_READ or GSPI_FUNC_BUS or ((addr and $1FFFF) shl 11) or 4;
  
  spi_cs_low;
  spi_write_word(cmd);
  // Turnaround - switch to input
  spi_data_input;
  // Read response
  Result := spi_read_word;
  spi_cs_high;
end;

// Write to bus register
procedure cyw43_write_reg(addr: LongWord; value: LongWord);
var
  cmd: LongWord;
begin
  cmd := GSPI_CMD_WRITE or GSPI_FUNC_BUS or ((addr and $1FFFF) shl 11) or 4;
  
  spi_cs_low;
  spi_write_word(cmd);
  spi_write_word(value);
  spi_cs_high;
end;

// Read chip ID (test communication)
function cyw43_get_chip_id: LongWord;
const
  CHIPID_ADDR = $14;  // Chip ID register in backplane
begin
  Result := cyw43_read_reg(CHIPID_ADDR);
end;

end.
