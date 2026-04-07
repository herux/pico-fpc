# Makefile for Pico-FPC
#
# Free Pascal build system for Raspberry Pi Pico
#

# FPC Cross Compiler
FPC = /Users/herux/fpcupdeluxe/fpc/bin/aarch64-darwin/ppcarm

# ARM tools
OBJCOPY = /opt/homebrew/bin/arm-none-eabi-objcopy

# Directories
HARDWARE_DIR = src/hardware
PICO_DIR = src/pico
WIFI_DIR = src/wifi
EXAMPLES_DIR = examples
BUILD_DIR = build
LIB_DIR = lib

# FPC embedded RTL
FPC_RTL = /Users/herux/fpcupdeluxe/fpc/units/arm-embedded

# Unit search path
UNIT_PATH = -Fu$(FPC_RTL) -Fu$(HARDWARE_DIR) -Fu$(PICO_DIR) -Fu$(WIFI_DIR)

# Library path
LIB_PATH = -Fl$(LIB_DIR)

# Compiler flags for ARM embedded (RP2040)
FPC_FLAGS = -Tembedded \
            -Cparmv6m \
            -O2 \
            -XX \
            -CX \
            $(UNIT_PATH) \
            -FE$(BUILD_DIR) \
            -FU$(BUILD_DIR)

# Linker script (use RAM-only for testing)
LINKER_SCRIPT = rp2040_ram.ld

# ARM GNU Toolchain
ARM_TOOLCHAIN = /opt/arm-gnu-toolchain/bin

# WiFi build flags (uses minimal stub library)
FPC_WIFI_FLAGS = -Tembedded \
                 -Cparmv6m \
                 -O2 \
                 -FD$(ARM_TOOLCHAIN) \
                 $(UNIT_PATH) \
                 -FE$(BUILD_DIR) \
                 -FU$(BUILD_DIR) \
                 $(LIB_PATH) \
                 -k-T \
                 -k$(PWD)/$(LINKER_SCRIPT) \
                 -k-Llib \
                 -k-lcyw43_stub

.PHONY: all clean blink wifi_blink wifi_lib wifi_stub uf2 help

all: $(BUILD_DIR) blink wifi_stub wifi_blink

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Build blink example
blink: $(BUILD_DIR)
	@echo "Compiling blink..."
	$(FPC) $(FPC_FLAGS) $(EXAMPLES_DIR)/blink/blink.pas
	@echo "Done: $(BUILD_DIR)/blink.elf"
	@ls -la $(BUILD_DIR)/blink.*

# Build WiFi blink example (for Pico W)
wifi_blink: $(BUILD_DIR)
	@echo "Compiling wifi_blink (Pico W)..."
	$(FPC) $(FPC_WIFI_FLAGS) src/wifi_blink.pas
	@echo "Done: $(BUILD_DIR)/wifi_blink.elf"
	@ls -la $(BUILD_DIR)/wifi_blink.*

# Convert ELF to BIN
bin: blink
	$(OBJCOPY) -O binary $(BUILD_DIR)/blink.elf $(BUILD_DIR)/blink.bin
	@echo "Created: $(BUILD_DIR)/blink.bin"

# Build CYW43 stub library (minimal, for testing)
wifi_stub: $(BUILD_DIR)
	@echo "Building CYW43 stub library..."
	@mkdir -p $(LIB_DIR)
	$(ARM_TOOLCHAIN)/arm-none-eabi-gcc -c -mcpu=cortex-m0plus -mthumb -O2 -ffreestanding \
		$(WIFI_DIR)/cyw43_stub.c -o $(BUILD_DIR)/cyw43_stub.o
	$(ARM_TOOLCHAIN)/arm-none-eabi-ar rcs $(LIB_DIR)/libcyw43_stub.a $(BUILD_DIR)/cyw43_stub.o
	@echo "Created: $(LIB_DIR)/libcyw43_stub.a"

# Build full WiFi library from pico-sdk (requires cmake)
wifi_lib:
	@echo "Building full WiFi library from pico-sdk..."
	@./scripts/build-wifi-lib.sh
	@echo "Done. Library at $(LIB_DIR)/libpico_wifi.a"

clean:
	rm -rf $(BUILD_DIR)
	rm -f src/hardware/*.ppu src/hardware/*.o
	rm -f src/pico/*.ppu src/pico/*.o
	rm -f src/wifi/*.ppu src/wifi/*.o
	rm -f examples/blink/*.ppu examples/blink/*.o examples/blink/*.elf examples/blink/*.bin examples/blink/*.hex

clean-wifi:
	rm -rf build-wifi
	rm -f $(LIB_DIR)/libpico_wifi.a $(LIB_DIR)/libcyw43_stub.a

# Help target
help:
	@echo "============================================"
	@echo "  Pico-FPC Build System"
	@echo "============================================"
	@echo ""
	@echo "Targets:"
	@echo "  all        - Build all examples"
	@echo "  blink      - Build blink example (Pico)"
	@echo "  wifi_blink - Build WiFi blink example (Pico W)"
	@echo "  wifi_stub  - Build minimal CYW43 stub library"
	@echo "  wifi_lib   - Build full WiFi library from pico-sdk"
	@echo "  bin        - Convert to binary"
	@echo "  clean      - Remove build files"
	@echo "  clean-wifi - Remove WiFi build files"
	@echo ""
	@echo "FPC: $(FPC)"
	@echo "RTL: $(FPC_RTL)"
	@echo "ARM: $(ARM_TOOLCHAIN)"
