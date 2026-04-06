# Building Pico-FPC

This guide explains how to set up the Free Pascal cross-compiler for RP2040 (Raspberry Pi Pico).

## Prerequisites

- macOS (Apple Silicon or Intel) or Linux
- Free Pascal Compiler (native)
- ARM embedded toolchain

## Quick Start (macOS)

The cross-compiler is already set up at:
```
FPC: /Users/herux/fpcupdeluxe/fpc/bin/aarch64-darwin/ppcarm
RTL: /Users/herux/fpcupdeluxe/fpc/units/arm-embedded
```

To build:
```bash
cd /Users/herux/Documents/pico-fpc
make all
```

---

## Full Installation Guide

### Option 1: Build from FPC Source (Recommended)

#### 1. Install Native FPC

```bash
# macOS (with Homebrew)
brew install fpc

# Or download from https://www.freepascal.org/download.html
```

#### 2. Install ARM Toolchain

```bash
# macOS
brew install arm-none-eabi-gcc arm-none-eabi-binutils

# Linux (Debian/Ubuntu)
sudo apt install gcc-arm-none-eabi binutils-arm-none-eabi
```

#### 3. Build FPC Cross-Compiler

```bash
# Clone FPC source
git clone --depth 1 --branch release_3_2_2 https://gitlab.com/freepascal.org/fpc/source.git ~/fpc-source

# Build cross-compiler
cd ~/fpc-source/compiler
make cycle CPU_TARGET=arm OS_TARGET=embedded SUBARCH=armv6m \
  PP=/path/to/native/fpc \
  OPT="-XR$(xcrun --sdk macosx --show-sdk-path)"

# Copy cross-compiler
cp ppcrossarm /path/to/fpc/bin/
ln -sf ppcrossarm /path/to/fpc/bin/ppcarm

# Build embedded RTL
cd ~/fpc-source/rtl/embedded
fpcmake -Tall Makefile.fpc
make all CPU_TARGET=arm OS_TARGET=embedded SUBARCH=armv6m \
  PP=/path/to/ppcrossarm \
  CROSSBINDIR=/opt/homebrew/bin

# Copy RTL units
mkdir -p /path/to/fpc/units/arm-embedded
cp -r ~/fpc-source/rtl/units/arm-embedded/* /path/to/fpc/units/arm-embedded/
```

#### 4. Create Toolchain Symlinks

FPC looks for `arm-embedded-*` tools:
```bash
cd /opt/homebrew/bin
for tool in as ld ar objcopy objdump nm strip ranlib; do
  sudo ln -sf arm-none-eabi-$tool arm-embedded-$tool
done
```

#### 5. Verify Installation

```bash
ppcarm -iV          # Should show: 3.2.2
ppcarm -Tembedded -Cparmv6m -iTO  # Should show: embedded
```

---

### Option 2: Using fpcupdeluxe

#### 1. Download fpcupdeluxe

Download from: https://github.com/LongDirtyAnimAlf/fpcupdeluxe/releases

#### 2. Install FPC Only (Command Line)

```bash
./fpcupdeluxe --installdir=~/fpc --fpcversion=3.2.2 --only=fpc

# Install cross-compiler
./fpcupdeluxe --installdir=~/fpc --fpcversion=3.2.2 --only=fpc \
    --cputarget=arm --ostarget=embedded --subarch=armv6m
```

#### 3. Add to PATH

```bash
export PATH="$HOME/fpc/fpc/bin:$PATH"
```

---

## Building the Project

### Using Makefile

```bash
cd /Users/herux/Documents/pico-fpc
make all      # Build everything
make blink    # Build blink example
make clean    # Clean build files
```

### Manual Compilation

```bash
ppcarm \
  -Tembedded \
  -Cparmv6m \
  -O2 \
  -Fu/path/to/fpc/units/arm-embedded \
  -Fusrc/hardware \
  -Fusrc/pico \
  -FEbuild \
  examples/blink/blink.pas
```

---

## Compiler Flags Reference

| Flag | Description |
|------|-------------|
| `-Tembedded` | Target OS: embedded (bare metal) |
| `-Cparmv6m` | CPU architecture: ARMv6-M |
| `-O2` | Optimization level 2 |
| `-XX` | Smart linking (remove unused code) |
| `-CX` | Create smartlinkable units |
| `-Fu<path>` | Unit search path |
| `-FE<path>` | Output directory for executables |
| `-FU<path>` | Output directory for units |

---

## Converting ELF to UF2

To upload to Pico, convert ELF to UF2 format:

```bash
# Install elf2uf2 (from pico-sdk)
git clone https://github.com/raspberrypi/pico-sdk.git
cd pico-sdk/tools/elf2uf2
mkdir build && cd build
cmake .. && make
sudo cp elf2uf2 /usr/local/bin/

# Or use uf2conv.py
pip install uf2conv

# Convert
elf2uf2 build/blink.elf build/blink.uf2
# or
uf2conv build/blink.elf -o build/blink.uf2 -f 0xe48bff56
```

**Upload:** Copy the `.uf2` file to Pico while in BOOTSEL mode (hold BOOTSEL button while plugging USB).

---

## Troubleshooting

### Error: "Assembler arm-embedded-as not found"
Create symlinks for ARM tools:
```bash
cd /opt/homebrew/bin
sudo ln -sf arm-none-eabi-as arm-embedded-as
sudo ln -sf arm-none-eabi-ld arm-embedded-ld
```

### Error: "Can't find unit system"
Make sure the embedded RTL path is included:
```bash
-Fu/path/to/fpc/units/arm-embedded
```

### Error: "memory region 'ram' not declared"
This is a linker warning. A custom linker script for RP2040 memory layout is needed for proper linking.

### Error: "library 'c' not found" (macOS)
Set the SDK root when building:
```bash
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
```
