# Pico-FPC: Raspberry Pi Pico SDK for Free Pascal

Raspberry Pi Pico SDK conversion from C to Free Pascal for microcontroller RP2040/RP2350.

## Folder Structure

```
pico-fpc/
├── src/
│   ├── hardware/           # Hardware abstraction units
│   │   ├── rp2040.pas      # RP2040 register definitions
│   │   ├── gpio.pas        # GPIO functions
│   │   ├── resets.pas      # Reset controller
│   │   ├── clocks.pas      # Clock configuration
│   │   ├── timer.pas       # Hardware timer
│   │   └── uart.pas        # UART serial
│   ├── pico/               # Pico SDK abstraction
│   │   └── pico.pas        # Main SDK unit (timing, init)
│   ├── wifi/               # WiFi driver (Pico W)
│   │   ├── cyw43.pas       # CYW43 WiFi/BT driver bindings
│   │   └── cyw43_stub.c    # Minimal C stubs for testing
│   ├── startup_rp2040.S    # ARM Cortex-M0+ startup code
│   └── fpc_stubs.c         # FPC runtime stubs
├── examples/               # Example programs
│   └── blink/
│       ├── blink.pas       # LED blink with pico unit
├── build/                  # Build output (UF2, ELF, etc.)
├── linker/                 # Linker scripts
├── lib/                    # Compiled libraries
├── scripts/                # Build helper scripts
├── rp2040_flash.ld         # Linker script for flash
├── rp2040_ram.ld           # Linker script for RAM
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
make help           # Show available targets
make blink          # Build blink example
make upload blink   # Upload to Pico (BOOTSEL mode)
```

## Status

| Feature | Status |
|---------|--------|
| GPIO | ✅ Working |
| Timer | ✅ Working |
| Resets | ✅ Working |
| UART | 🔄 In progress |
| SPI | 📋 Planned |
| I2C | 📋 Planned |
| PWM | 📋 Planned |
| WiFi (CYW43) | 🔄 In progress |

## Based on

[Raspberry Pi Pico SDK](https://github.com/raspberrypi/pico-sdk)

## License

BSD-3-Clause (same as original Pico SDK)
