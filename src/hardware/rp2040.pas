{
  RP2040 Hardware Register Definitions for Free Pascal
  
  Based on Raspberry Pi Pico SDK
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause
  
  Converted to Free Pascal
}
unit rp2040;

{$mode objfpc}
{$H+}
{$PACKRECORDS C}
{$MODESWITCH ADVANCEDRECORDS}

interface

const
  { RP2040 Memory Map Base Addresses }
  ROM_BASE            = $00000000;
  XIP_BASE            = $10000000;
  XIP_MAIN_BASE       = $10000000;
  XIP_NOALLOC_BASE    = $11000000;
  XIP_NOCACHE_BASE    = $12000000;
  XIP_NOCACHE_NOALLOC_BASE = $13000000;
  XIP_CTRL_BASE       = $14000000;
  XIP_SRAM_BASE       = $15000000;
  XIP_SRAM_END        = $15004000;
  XIP_SSI_BASE        = $18000000;
  SRAM_BASE           = $20000000;
  SRAM_STRIPED_BASE   = $20000000;
  SRAM_STRIPED_END    = $20040000;
  SRAM4_BASE          = $20040000;
  SRAM5_BASE          = $20041000;
  SRAM_END            = $20042000;
  SRAM0_BASE          = $21000000;
  SRAM1_BASE          = $21010000;
  SRAM2_BASE          = $21020000;
  SRAM3_BASE          = $21030000;
  
  { APB Peripherals }
  SYSINFO_BASE        = $40000000;
  SYSCFG_BASE         = $40004000;
  CLOCKS_BASE         = $40008000;
  RESETS_BASE         = $4000C000;
  PSM_BASE            = $40010000;
  IO_BANK0_BASE       = $40014000;
  IO_QSPI_BASE        = $40018000;
  PADS_BANK0_BASE     = $4001C000;
  PADS_QSPI_BASE      = $40020000;
  XOSC_BASE           = $40024000;
  PLL_SYS_BASE        = $40028000;
  PLL_USB_BASE        = $4002C000;
  BUSCTRL_BASE        = $40030000;
  UART0_BASE          = $40034000;
  UART1_BASE          = $40038000;
  SPI0_BASE           = $4003C000;
  SPI1_BASE           = $40040000;
  I2C0_BASE           = $40044000;
  I2C1_BASE           = $40048000;
  ADC_BASE            = $4004C000;
  PWM_BASE            = $40050000;
  TIMER_BASE          = $40054000;
  WATCHDOG_BASE       = $40058000;
  RTC_BASE            = $4005C000;
  ROSC_BASE           = $40060000;
  VREG_AND_CHIP_RESET_BASE = $40064000;
  TBMAN_BASE          = $4006C000;
  
  { AHB-Lite Peripherals }
  DMA_BASE            = $50000000;
  USBCTRL_DPRAM_BASE  = $50100000;
  USBCTRL_BASE        = $50100000;
  USBCTRL_REGS_BASE   = $50110000;
  PIO0_BASE           = $50200000;
  PIO1_BASE           = $50300000;
  XIP_AUX_BASE        = $50400000;
  
  { Cortex-M0+ Internal Peripherals }
  SIO_BASE            = $D0000000;
  PPB_BASE            = $E0000000;
  
  { GPIO Constants }
  NUM_BANK0_GPIOS     = 30;
  
  { GPIO Function Select }
  GPIO_FUNC_XIP   = 0;
  GPIO_FUNC_SPI   = 1;
  GPIO_FUNC_UART  = 2;
  GPIO_FUNC_I2C   = 3;
  GPIO_FUNC_PWM   = 4;
  GPIO_FUNC_SIO   = 5;
  GPIO_FUNC_PIO0  = 6;
  GPIO_FUNC_PIO1  = 7;
  GPIO_FUNC_GPCK  = 8;
  GPIO_FUNC_USB   = 9;
  GPIO_FUNC_NULL  = $1F;
  
  { GPIO Direction }
  GPIO_IN  = 0;
  GPIO_OUT = 1;
  
  { Pico Board LED Pin }
  PICO_DEFAULT_LED_PIN = 25;

type
  { SIO (Single-cycle I/O) Hardware Structure }
  TSIO_HW = packed record
    cpuid: LongWord;
    gpio_in: LongWord;
    gpio_hi_in: LongWord;
    _pad0: LongWord;
    gpio_out: LongWord;
    gpio_out_set: LongWord;
    gpio_out_clr: LongWord;
    gpio_out_xor: LongWord;
    gpio_oe: LongWord;
    gpio_oe_set: LongWord;
    gpio_oe_clr: LongWord;
    gpio_oe_xor: LongWord;
    gpio_hi_out: LongWord;
    gpio_hi_out_set: LongWord;
    gpio_hi_out_clr: LongWord;
    gpio_hi_out_xor: LongWord;
    gpio_hi_oe: LongWord;
    gpio_hi_oe_set: LongWord;
    gpio_hi_oe_clr: LongWord;
    gpio_hi_oe_xor: LongWord;
    fifo_st: LongWord;
    fifo_wr: LongWord;
    fifo_rd: LongWord;
    spinlock_st: LongWord;
    div_udividend: LongWord;
    div_udivisor: LongWord;
    div_sdividend: LongWord;
    div_sdivisor: LongWord;
    div_quotient: LongWord;
    div_remainder: LongWord;
    div_csr: LongWord;
    _pad1: LongWord;
    interp: array[0..1] of array[0..7] of LongWord;
    spinlock: array[0..31] of LongWord;
  end;
  PSIO_HW = ^TSIO_HW;

  { IO Bank0 Status/Control for single GPIO }
  TIO_BANK0_GPIO = packed record
    status: LongWord;
    ctrl: LongWord;
  end;

  { IO Bank0 Hardware Structure }
  TIO_BANK0_HW = packed record
    gpio: array[0..NUM_BANK0_GPIOS-1] of TIO_BANK0_GPIO;
    intr: array[0..3] of LongWord;
    proc0_irq_ctrl: packed record
      inte: array[0..3] of LongWord;
      intf: array[0..3] of LongWord;
      ints: array[0..3] of LongWord;
    end;
    proc1_irq_ctrl: packed record
      inte: array[0..3] of LongWord;
      intf: array[0..3] of LongWord;
      ints: array[0..3] of LongWord;
    end;
    dormant_wake_irq_ctrl: packed record
      inte: array[0..3] of LongWord;
      intf: array[0..3] of LongWord;
      ints: array[0..3] of LongWord;
    end;
  end;
  PIO_BANK0_HW = ^TIO_BANK0_HW;

  { Pads Bank0 Hardware Structure }
  TPADS_BANK0_HW = packed record
    voltage_select: LongWord;
    io: array[0..NUM_BANK0_GPIOS-1] of LongWord;
  end;
  PPADS_BANK0_HW = ^TPADS_BANK0_HW;
  
  { Resets Hardware Structure }
  TRESETS_HW = packed record
    reset: LongWord;
    wdsel: LongWord;
    reset_done: LongWord;
  end;
  PRESETS_HW = ^TRESETS_HW;

const
  { Resets bit masks }
  RESETS_RESET_ADC_BITS        = $00000001;
  RESETS_RESET_BUSCTRL_BITS    = $00000002;
  RESETS_RESET_DMA_BITS        = $00000004;
  RESETS_RESET_I2C0_BITS       = $00000008;
  RESETS_RESET_I2C1_BITS       = $00000010;
  RESETS_RESET_IO_BANK0_BITS   = $00000020;
  RESETS_RESET_IO_QSPI_BITS    = $00000040;
  RESETS_RESET_JTAG_BITS       = $00000080;
  RESETS_RESET_PADS_BANK0_BITS = $00000100;
  RESETS_RESET_PADS_QSPI_BITS  = $00000200;
  RESETS_RESET_PIO0_BITS       = $00000400;
  RESETS_RESET_PIO1_BITS       = $00000800;
  RESETS_RESET_PLL_SYS_BITS    = $00001000;
  RESETS_RESET_PLL_USB_BITS    = $00002000;
  RESETS_RESET_PWM_BITS        = $00004000;
  RESETS_RESET_RTC_BITS        = $00008000;
  RESETS_RESET_SPI0_BITS       = $00010000;
  RESETS_RESET_SPI1_BITS       = $00020000;
  RESETS_RESET_SYSCFG_BITS     = $00040000;
  RESETS_RESET_SYSINFO_BITS    = $00080000;
  RESETS_RESET_TBMAN_BITS      = $00100000;
  RESETS_RESET_TIMER_BITS      = $00200000;
  RESETS_RESET_UART0_BITS      = $00400000;
  RESETS_RESET_UART1_BITS      = $00800000;
  RESETS_RESET_USBCTRL_BITS    = $01000000;
  
  { Pad control bits }
  PADS_BANK0_GPIO_OD_BITS      = $00000080;  { Output disable }
  PADS_BANK0_GPIO_IE_BITS      = $00000040;  { Input enable }
  PADS_BANK0_GPIO_DRIVE_BITS   = $00000030;  { Drive strength }
  PADS_BANK0_GPIO_PUE_BITS     = $00000008;  { Pull up enable }
  PADS_BANK0_GPIO_PDE_BITS     = $00000004;  { Pull down enable }
  PADS_BANK0_GPIO_SCHMITT_BITS = $00000002;  { Schmitt trigger }
  PADS_BANK0_GPIO_SLEWFAST_BITS= $00000001;  { Slew rate }
  
  { IO Bank0 control bits }
  IO_BANK0_GPIO_CTRL_FUNCSEL_BITS = $0000001F;
  IO_BANK0_GPIO_CTRL_FUNCSEL_LSB  = 0;

var
  { Hardware register pointers }
  sio_hw: PSIO_HW absolute SIO_BASE;
  io_bank0_hw: PIO_BANK0_HW absolute IO_BANK0_BASE;
  pads_bank0_hw: PPADS_BANK0_HW absolute PADS_BANK0_BASE;
  resets_hw: PRESETS_HW absolute RESETS_BASE;

{ Atomic register access helpers }
{ For RP2040, atomic set/clear/xor is done via address aliasing }
const
  REG_ALIAS_RW_BITS  = $0000;
  REG_ALIAS_XOR_BITS = $1000;
  REG_ALIAS_SET_BITS = $2000;
  REG_ALIAS_CLR_BITS = $3000;

procedure hw_set_bits(var reg: LongWord; mask: LongWord); inline;
procedure hw_clear_bits(var reg: LongWord; mask: LongWord); inline;
procedure hw_xor_bits(var reg: LongWord; mask: LongWord); inline;
procedure hw_write_masked(var reg: LongWord; values, mask: LongWord); inline;

implementation

procedure hw_set_bits(var reg: LongWord; mask: LongWord); inline;
var
  alias: PLongWord;
begin
  alias := PLongWord(PtrUInt(@reg) or REG_ALIAS_SET_BITS);
  alias^ := mask;
end;

procedure hw_clear_bits(var reg: LongWord; mask: LongWord); inline;
var
  alias: PLongWord;
begin
  alias := PLongWord(PtrUInt(@reg) or REG_ALIAS_CLR_BITS);
  alias^ := mask;
end;

procedure hw_xor_bits(var reg: LongWord; mask: LongWord); inline;
var
  alias: PLongWord;
begin
  alias := PLongWord(PtrUInt(@reg) or REG_ALIAS_XOR_BITS);
  alias^ := mask;
end;

procedure hw_write_masked(var reg: LongWord; values, mask: LongWord); inline;
begin
  hw_xor_bits(reg, (reg xor values) and mask);
end;

end.
