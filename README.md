![WIP](https://img.shields.io/badge/status-work%20in%20progress-yellow?style=for-the-badge)

# Pico-FPC: Raspberry Pi Pico SDK for Free Pascal

Raspberry Pi Pico SDK conversion from C to Free Pascal for microcontroller RP2040/RP2350.

## Folder Structure

```
pico-fpc/
├── src/
│   ├── boot/               # Boot/startup assembly sources
│   │   ├── boot2.S         # RP2040 boot2 (XIP flash init)
│   │   ├── crt0.S          # Flash-mode reset/vector startup
│   │   └── crt0_ram.S      # RAM-mode minimal startup
│   ├── hardware/           # Hardware abstraction units
│   │   ├── clocks.pas
│   │   ├── gpio.pas
│   │   ├── pwm.pas
│   │   ├── resets.pas
│   │   ├── rp2040.pas
│   │   ├── spi.pas
│   │   ├── timer.pas
│   │   └── uart.pas
│   ├── pico/               # Pico SDK abstraction layer
│   │   ├── pico.pas        # Main SDK unit (timing, init)
│   │   ├── pico_types.pas  # Common types
│   │   └── platform.pas    # Platform helpers
│   ├── rtl/                # Custom RTL overrides (experimental)
│   │   └── system.pas
│   ├── startup/
│   │   └── startup.pas
│   ├── wifi/               # CYW43 / Pico W work-in-progress
│   │   ├── cyw43.pas
│   │   ├── cyw43_ll.pas
│   │   ├── cyw43_spi_test.pas
│   │   └── cyw43_stub.c
│   ├── fpc_stubs.c         # FPC runtime stubs
│   ├── startup_rp2040.S    # Legacy startup source
│   └── wifi_blink.pas      # Pico W blink example entry
├── examples/               # Example programs
│   ├── blink/
│   │   └── blink.pas       # LED blink with pico unit
│   ├── pwm/
│   │   └── pwm_test.pas    # LED brightness sweep via PWM
│   ├── spi/
│   │   └── spi_test.pas    # SPI0 MOSI/MISO loopback test
│   └── uart/
│       ├── uart_test.pas   # UART heartbeat transmit
│       └── uart_echo.pas   # UART echo server
├── build/                  # Build output (UF2, ELF, etc.)
├── build-wifi/             # pico-sdk/cmake WiFi build artifacts
├── linker/                 # Linker scripts
│   └── rp2040.ld
├── lib/                    # Compiled libraries
│   ├── libcyw43_stub.a
│   ├── libpico_wifi.a
│   └── libpicow_led.a
├── scripts/                # Build helper scripts
│   └── build-wifi-lib.sh
├── rp2040.ld               # Generic RP2040 linker script
├── rp2040_flash.ld         # Flash/XIP linker script
├── rp2040_memory.ld        # RAM build MEMORY definition
├── rp2040_ram.ld           # RAM linker script
└── Makefile                # Build system
```

## Requirements

- Free Pascal Compiler (FPC) 3.2.2+ with ARM cross-compilation
- ARM GNU Toolchain (arm-none-eabi)
- picotool (for UF2 conversion)

## Target Hardware

- Raspberry Pi Pico (RP2040) ✅
- Raspberry Pi Pico W (RP2040 + CYW43) - in progress
- Raspberry Pi Pico 2 (RP2350) - planned

## Building

```bash
make help              # Show available targets
make blink             # Build blink example (RAM)
make blink_flash       # Build blink example (FLASH)
make pwm_test_flash    # Build PWM example (FLASH)
make spi_test_flash    # Build SPI loopback example (FLASH)
make uart_echo_flash   # Build UART echo example (FLASH)
```

## Status

| Feature | Status |
|---------|--------|
| GPIO | ✅ Working |
| Timer | ✅ Working |
| Resets | ✅ Working |
| Clock init (XOSC + WATCHDOG_TICK) | ✅ Working |
| PWM | ✅ Working |
| UART | 🔄 Testing |
| SPI | 🔄 Testing |
| I2C | ✅ Working |
| WiFi (CYW43) | 🔄 In progress |

## Based on

[Raspberry Pi Pico SDK](https://github.com/raspberrypi/pico-sdk)

## License

BSD-3-Clause (same as original Pico SDK)
