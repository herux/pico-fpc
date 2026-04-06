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
EXAMPLES_DIR = examples
BUILD_DIR = build

# FPC embedded RTL
FPC_RTL = /Users/herux/fpcupdeluxe/fpc/units/arm-embedded

# Unit search path
UNIT_PATH = -Fu$(FPC_RTL) -Fu$(HARDWARE_DIR) -Fu$(PICO_DIR)

# Compiler flags for ARM embedded (RP2040)
FPC_FLAGS = -Tembedded \
            -Cparmv6m \
            -O2 \
            -XX \
            -CX \
            $(UNIT_PATH) \
            -FE$(BUILD_DIR) \
            -FU$(BUILD_DIR)

.PHONY: all clean blink uf2 help

all: $(BUILD_DIR) blink

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Build blink example
blink: $(BUILD_DIR)
	@echo "Compiling blink..."
	$(FPC) $(FPC_FLAGS) $(EXAMPLES_DIR)/blink/blink.pas
	@echo "Done: $(BUILD_DIR)/blink.elf"
	@ls -la $(BUILD_DIR)/blink.*

# Convert ELF to BIN
bin: blink
	$(OBJCOPY) -O binary $(BUILD_DIR)/blink.elf $(BUILD_DIR)/blink.bin
	@echo "Created: $(BUILD_DIR)/blink.bin"

clean:
	rm -rf $(BUILD_DIR)
	rm -f src/hardware/*.ppu src/hardware/*.o
	rm -f src/pico/*.ppu src/pico/*.o
	rm -f examples/blink/*.ppu examples/blink/*.o examples/blink/*.elf examples/blink/*.bin examples/blink/*.hex

# Help target
help:
	@echo "============================================"
	@echo "  Pico-FPC Build System"
	@echo "============================================"
	@echo ""
	@echo "Targets:"
	@echo "  all        - Build all examples"
	@echo "  blink      - Build blink example"
	@echo "  bin        - Convert to binary"
	@echo "  clean      - Remove build files"
	@echo ""
	@echo "FPC: $(FPC)"
	@echo "RTL: $(FPC_RTL)"
