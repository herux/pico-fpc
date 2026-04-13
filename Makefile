# Makefile for Pico-FPC
#
# Free Pascal build system for Raspberry Pi Pico
#

# FPC Cross Compiler
FPC = /Users/herux/fpcupdeluxe/fpc/bin/aarch64-darwin/ppcarm

# ARM tools
OBJCOPY = /opt/homebrew/bin/arm-none-eabi-objcopy
AS = /opt/homebrew/bin/arm-none-eabi-as

# Directories
HARDWARE_DIR = src/hardware
PICO_DIR = src/pico
WIFI_DIR = src/wifi
BOOT_DIR = src/boot
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

# Converting elf to uf2
PICOTOOL = /opt/homebrew/bin/picotool

.PHONY: all clean blink blink_flash pwm_test pwm_test_flash uart_test uart_test_flash uart_echo uart_echo_flash spi_test spi_test_flash wifi_blink wifi_lib wifi_stub uf2 help upload

all: $(BUILD_DIR) blink pwm_test uart_test uart_echo spi_test wifi_stub wifi_blink

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Build blink example (RAM mode - for testing)
# Uses custom memory script and --noinhibit-exec to handle FPC system unit relocations
blink: $(BUILD_DIR)
	@echo "Compiling blink (RAM mode)..."
	$(FPC) $(FPC_FLAGS) -k"--script=rp2040_memory.ld" -k"--noinhibit-exec" $(EXAMPLES_DIR)/blink/blink.pas
	@echo "Converting to UF2..."
	$(PICOTOOL) uf2 convert $(BUILD_DIR)/blink.elf $(BUILD_DIR)/blink.uf2 --family rp2040
	@echo "Done:"
	@ls -la $(BUILD_DIR)/blink.*

# Build blink example (FLASH mode - persistent)
blink_flash: $(BUILD_DIR) $(BUILD_DIR)/boot2.o $(BUILD_DIR)/crt0.o
	@echo "Compiling blink (FLASH mode)..."
	$(FPC) $(FPC_FLAGS) \
		-k"-T rp2040_flash.ld" \
		-k"$(BUILD_DIR)/boot2.o" \
		-k"$(BUILD_DIR)/crt0.o" \
		-k"--allow-multiple-definition" \
		-k"--noinhibit-exec" \
		$(EXAMPLES_DIR)/blink/blink.pas
	@echo "Converting to UF2..."
	$(PICOTOOL) uf2 convert $(BUILD_DIR)/blink.elf $(BUILD_DIR)/blink.uf2 --family rp2040
	@echo "Done (FLASH mode - will persist after power cycle):"
	@ls -la $(BUILD_DIR)/blink.*

# Build PWM test example (RAM mode)
pwm_test: $(BUILD_DIR)
	@echo "Compiling pwm_test (RAM mode)..."
	$(FPC) $(FPC_FLAGS) -k"--script=rp2040_memory.ld" -k"--noinhibit-exec" $(EXAMPLES_DIR)/pwm/pwm_test.pas
	@echo "Converting to UF2..."
	$(PICOTOOL) uf2 convert $(BUILD_DIR)/pwm_test.elf $(BUILD_DIR)/pwm_test.uf2 --family rp2040
	@echo "Done:"
	@ls -la $(BUILD_DIR)/pwm_test.*

# Build PWM test example (FLASH mode - persistent)
pwm_test_flash: $(BUILD_DIR) $(BUILD_DIR)/boot2.o $(BUILD_DIR)/crt0.o
	@echo "Compiling pwm_test (FLASH mode)..."
	$(FPC) $(FPC_FLAGS) \
		-k"-T rp2040_flash.ld" \
		-k"$(BUILD_DIR)/boot2.o" \
		-k"$(BUILD_DIR)/crt0.o" \
		-k"--allow-multiple-definition" \
		-k"--noinhibit-exec" \
		$(EXAMPLES_DIR)/pwm/pwm_test.pas
	@echo "Converting to UF2..."
	$(PICOTOOL) uf2 convert $(BUILD_DIR)/pwm_test.elf $(BUILD_DIR)/pwm_test.uf2 --family rp2040
	@echo "Done (FLASH mode - will persist after power cycle):"
	@ls -la $(BUILD_DIR)/pwm_test.*

# Build UART test example (RAM mode)
uart_test: $(BUILD_DIR)
	@echo "Compiling uart_test (RAM mode)..."
	$(FPC) $(FPC_FLAGS) -k"--script=rp2040_memory.ld" -k"--noinhibit-exec" $(EXAMPLES_DIR)/uart/uart_test.pas
	@echo "Converting to UF2..."
	$(PICOTOOL) uf2 convert $(BUILD_DIR)/uart_test.elf $(BUILD_DIR)/uart_test.uf2 --family rp2040
	@echo "Done:"
	@ls -la $(BUILD_DIR)/uart_test.*

# Build UART test example (FLASH mode - persistent)
uart_test_flash: $(BUILD_DIR) $(BUILD_DIR)/boot2.o $(BUILD_DIR)/crt0.o
	@echo "Compiling uart_test (FLASH mode)..."
	$(FPC) $(FPC_FLAGS) \
		-k"-T rp2040_flash.ld" \
		-k"$(BUILD_DIR)/boot2.o" \
		-k"$(BUILD_DIR)/crt0.o" \
		-k"--allow-multiple-definition" \
		-k"--noinhibit-exec" \
		$(EXAMPLES_DIR)/uart/uart_test.pas
	@echo "Converting to UF2..."
	$(PICOTOOL) uf2 convert $(BUILD_DIR)/uart_test.elf $(BUILD_DIR)/uart_test.uf2 --family rp2040
	@echo "Done (FLASH mode - will persist after power cycle):"
	@ls -la $(BUILD_DIR)/uart_test.*

# Build UART echo example (RAM mode)
uart_echo: $(BUILD_DIR)
	@echo "Compiling uart_echo (RAM mode)..."
	$(FPC) $(FPC_FLAGS) -k"--script=rp2040_memory.ld" -k"--noinhibit-exec" $(EXAMPLES_DIR)/uart/uart_echo.pas
	@echo "Converting to UF2..."
	$(PICOTOOL) uf2 convert $(BUILD_DIR)/uart_echo.elf $(BUILD_DIR)/uart_echo.uf2 --family rp2040
	@echo "Done:"
	@ls -la $(BUILD_DIR)/uart_echo.*

# Build UART echo example (FLASH mode - persistent)
uart_echo_flash: $(BUILD_DIR) $(BUILD_DIR)/boot2.o $(BUILD_DIR)/crt0.o
	@echo "Compiling uart_echo (FLASH mode)..."
	$(FPC) $(FPC_FLAGS) \
		-k"-T rp2040_flash.ld" \
		-k"$(BUILD_DIR)/boot2.o" \
		-k"$(BUILD_DIR)/crt0.o" \
		-k"--allow-multiple-definition" \
		-k"--noinhibit-exec" \
		$(EXAMPLES_DIR)/uart/uart_echo.pas
	@echo "Converting to UF2..."
	$(PICOTOOL) uf2 convert $(BUILD_DIR)/uart_echo.elf $(BUILD_DIR)/uart_echo.uf2 --family rp2040
	@echo "Done (FLASH mode - will persist after power cycle):"
	@ls -la $(BUILD_DIR)/uart_echo.*

# Build SPI test example (RAM mode)
spi_test: $(BUILD_DIR)
	@echo "Compiling spi_test (RAM mode)..."
	$(FPC) $(FPC_FLAGS) -k"--script=rp2040_memory.ld" -k"--noinhibit-exec" $(EXAMPLES_DIR)/spi/spi_test.pas
	@echo "Converting to UF2..."
	$(PICOTOOL) uf2 convert $(BUILD_DIR)/spi_test.elf $(BUILD_DIR)/spi_test.uf2 --family rp2040
	@echo "Done:"
	@ls -la $(BUILD_DIR)/spi_test.*

# Build SPI test example (FLASH mode - persistent)
spi_test_flash: $(BUILD_DIR) $(BUILD_DIR)/boot2.o $(BUILD_DIR)/crt0.o
	@echo "Compiling spi_test (FLASH mode)..."
	$(FPC) $(FPC_FLAGS) \
		-k"-T rp2040_flash.ld" \
		-k"$(BUILD_DIR)/boot2.o" \
		-k"$(BUILD_DIR)/crt0.o" \
		-k"--allow-multiple-definition" \
		-k"--noinhibit-exec" \
		$(EXAMPLES_DIR)/spi/spi_test.pas
	@echo "Converting to UF2..."
	$(PICOTOOL) uf2 convert $(BUILD_DIR)/spi_test.elf $(BUILD_DIR)/spi_test.uf2 --family rp2040
	@echo "Done (FLASH mode - will persist after power cycle):"
	@ls -la $(BUILD_DIR)/spi_test.*


# Assemble boot2 (XIP setup)
$(BUILD_DIR)/boot2.o: $(BOOT_DIR)/boot2.S
	@echo "Assembling boot2..."
	$(AS) -mcpu=cortex-m0plus -mthumb -o $@ $<

# Assemble crt0 (startup code for flash)
$(BUILD_DIR)/crt0.o: $(BOOT_DIR)/crt0.S
	@echo "Assembling crt0..."
	$(AS) -mcpu=cortex-m0plus -mthumb -o $@ $<

# Assemble crt0_ram (minimal startup for RAM mode)
$(BUILD_DIR)/crt0_ram.o: $(BOOT_DIR)/crt0_ram.S
	@echo "Assembling crt0_ram..."
	$(AS) -mcpu=cortex-m0plus -mthumb -o $@ $<

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
	rm -f examples/pwm/*.ppu examples/pwm/*.o examples/pwm/*.elf examples/pwm/*.bin examples/pwm/*.hex
	rm -f examples/uart/*.ppu examples/uart/*.o examples/uart/*.elf examples/uart/*.bin examples/uart/*.hex
	rm -f examples/spi/*.ppu examples/spi/*.o examples/spi/*.elf examples/spi/*.bin examples/spi/*.hex

clean-wifi:
	rm -rf build-wifi
	rm -f $(LIB_DIR)/libpico_wifi.a $(LIB_DIR)/libcyw43_stub.a

# Upload to Pico (must be in BOOTSEL mode)
# Usage: make upload <name>  (e.g., make upload blink)
PICO_MOUNT = /Volumes/RPI-RP2

upload:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Usage: make upload <name>"; \
		echo "Example: make upload blink"; \
		exit 1; \
	fi
	@TARGET="$(filter-out $@,$(MAKECMDGOALS))"; \
	UF2_TARGET="$$TARGET"; \
	case "$$UF2_TARGET" in \
		*_flash) UF2_TARGET="$${UF2_TARGET%_flash}" ;; \
	esac; \
	if [ -n "$$TARGET" ]; then \
		$(MAKE) --no-print-directory $$TARGET; \
	fi; \
	UF2="$(BUILD_DIR)/$$UF2_TARGET.uf2"; \
	if [ ! -f "$$UF2" ]; then \
		echo "Error: $$UF2 not found. Build it first."; \
		exit 1; \
	fi; \
	if [ -d "$(PICO_MOUNT)" ]; then \
		echo "Uploading $$UF2_TARGET.uf2 to Pico..."; \
		cp "$$UF2" "$(PICO_MOUNT)/"; \
		echo "Done! Pico will reboot."; \
	else \
		echo "Error: Pico not found. Hold BOOTSEL and connect USB."; \
		exit 1; \
	fi

# Catch-all to prevent "No rule to make target" error for upload arguments
ifneq ($(filter upload,$(MAKECMDGOALS)),)
%:
	@:
endif

# Help target
help:
	@echo "============================================"
	@echo "  Pico-FPC Build System"
	@echo "============================================"
	@echo ""
	@echo "Build Targets:"
	@echo "  all        - Build all examples"
	@echo "  blink      - Build blink example (Pico)"
	@echo "  blink_flash- Build blink example in FLASH mode (persistent)"
	@echo "  pwm_test   - Build PWM test example (Pico)"
	@echo "  pwm_test_flash - Build PWM test in FLASH mode (persistent)"
	@echo "  uart_test  - Build UART test example (Pico)"
	@echo "  uart_test_flash - Build UART test in FLASH mode (persistent)"
	@echo "  uart_echo  - Build UART echo example (Pico)"
	@echo "  uart_echo_flash - Build UART echo in FLASH mode (persistent)"
	@echo "  spi_test   - Build SPI loopback test example (Pico)"
	@echo "  spi_test_flash - Build SPI loopback test in FLASH mode (persistent)"
	@echo "  wifi_blink - Build WiFi blink example (Pico W)"
	@echo "  wifi_stub  - Build minimal CYW43 stub library"
	@echo "  wifi_lib   - Build full WiFi library from pico-sdk"
	@echo "  bin        - Convert to binary"
	@echo ""
	@echo "Upload (Pico must be in BOOTSEL mode):"
	@echo "  make upload <name>  - Upload <name>.uf2 to Pico"
	@echo "  Example: make upload blink"
	@echo ""
	@echo "Clean Targets:"
	@echo "  clean      - Remove build files"
	@echo "  clean-wifi - Remove WiFi build files"
	@echo ""
	@echo "FPC: $(FPC)"
	@echo "RTL: $(FPC_RTL)"
	@echo "ARM: $(ARM_TOOLCHAIN)"
