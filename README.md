# Pico-FPC: Raspberry Pi Pico SDK for Free Pascal

Raspberry Pi Pico SDK conversion from C to Free Pascal for mikrokontroler RP2040/RP2350.

## Struktur Proyek

```
pico-fpc/
├── src/
│   ├── hardware/          # Hardware abstraction units
│   │   ├── rp2040.pas     # RP2040 register definitions
│   │   └── gpio.pas       # GPIO functions
│   ├── pico/              # Pico SDK abstraction
│   │   └── pico.pas       # Main SDK unit
│   └── startup/           # Startup code
│       └── startup.pas    # Startup/runtime
├── examples/              # Example programs
│   └── blink/
│       └── blink.pas      # Simple LED blink
├── linker/                # Linker scripts
│   └── rp2040.ld          # RP2040 linker script
└── Makefile               # Build system
```

## Requirements

- Free Pascal Compiler (FPC) with ARM cross-compilation support
- ARM embedded toolchain for linking

## Target Hardware

- Raspberry Pi Pico (RP2040)
- Raspberry Pi Pico 2 (RP2350) - planned

## Building

```bash
make
```

## Based on

[Raspberry Pi Pico SDK](https://github.com/raspberrypi/pico-sdk)

## License

BSD-3-Clause (same as original Pico SDK)
