{
  Pico Platform Definitions
  
  Based on Raspberry Pi Pico SDK
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause
  
  Converted to Free Pascal
}
unit platform;

{$mode objfpc}
{$H+}

interface

const
  { Board type }
  PICO_BOARD = 'pico';
  
  { Default UART for stdio }
  PICO_DEFAULT_UART = 0;
  PICO_DEFAULT_UART_TX_PIN = 0;
  PICO_DEFAULT_UART_RX_PIN = 1;
  PICO_DEFAULT_UART_BAUD_RATE = 115200;
  
  { Default LED pin }
  PICO_DEFAULT_LED_PIN = 25;
  
  { Default I2C }
  PICO_DEFAULT_I2C = 0;
  PICO_DEFAULT_I2C_SDA_PIN = 4;
  PICO_DEFAULT_I2C_SCL_PIN = 5;
  
  { Default SPI }
  PICO_DEFAULT_SPI = 0;
  PICO_DEFAULT_SPI_SCK_PIN = 18;
  PICO_DEFAULT_SPI_TX_PIN = 19;
  PICO_DEFAULT_SPI_RX_PIN = 16;
  PICO_DEFAULT_SPI_CSN_PIN = 17;
  
  { Flash size }
  PICO_FLASH_SIZE_BYTES = 2 * 1024 * 1024;  { 2MB }
  
  { RP2040 specific }
  RP2040_SRAM_SIZE = 264 * 1024;  { 264KB }
  RP2040_NUM_CORES = 2;
  RP2040_NUM_GPIOS = 30;
  RP2040_NUM_PWM_SLICES = 8;
  RP2040_NUM_DMA_CHANNELS = 12;
  RP2040_NUM_PIO = 2;
  RP2040_NUM_PIO_STATE_MACHINES = 4;
  RP2040_NUM_TIMERS = 4;

implementation

end.
