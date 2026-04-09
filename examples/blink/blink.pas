{
  Blink Example for Raspberry Pi Pico
  
  Based on Raspberry Pi Pico SDK
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause
  
  Converted to Free Pascal
  
  This example blinks the on-board LED (GPIO 25 on Pico)
}
program blink;

{$mode objfpc}
{$H+}

uses
  rp2040,
  gpio,
  pico;

const
  LED_PIN = PICO_DEFAULT_LED_PIN;  { GPIO 25 on Raspberry Pi Pico }
  DELAY_MS = 100;

begin
  { Initialize stdio (unresets IO_BANK0 and PADS_BANK0) }
  stdio_init_all;
  
  { Initialize LED pin }
  gpio_init(LED_PIN);
  gpio_set_dir(LED_PIN, gdOutput);
  
  { Main loop - blink forever }
  while True do
  begin
    gpio_put(LED_PIN, True);
    sleep_ms(DELAY_MS);
    
    gpio_put(LED_PIN, False);
    sleep_ms(DELAY_MS);
  end;
end.
