#!/bin/bash
#
# Build script for CYW43 WiFi library from pico-sdk
# This creates libcyw43.a for linking with Free Pascal programs
#
# Prerequisites:
#   - CMake
#   - ARM toolchain (arm-none-eabi-gcc)
#   - Git
#

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$PROJECT_DIR/build-wifi"
LIB_DIR="$PROJECT_DIR/lib"
SDK_DIR="$BUILD_DIR/pico-sdk"

echo "============================================"
echo "  Building CYW43 WiFi Library for Pico W"
echo "============================================"
echo ""
echo "Project dir: $PROJECT_DIR"
echo "Build dir:   $BUILD_DIR"
echo "Output:      $LIB_DIR"
echo ""

# Check prerequisites
check_tool() {
    if ! command -v "$1" &> /dev/null; then
        echo "ERROR: $1 not found. Please install it first."
        exit 1
    fi
    echo "  ✓ $1 found"
}

echo "Checking prerequisites..."
check_tool cmake
check_tool git
check_tool arm-none-eabi-gcc

# Create build directory
mkdir -p "$BUILD_DIR"
mkdir -p "$LIB_DIR"

# Clone pico-sdk if not exists
if [ ! -d "$SDK_DIR" ]; then
    echo ""
    echo "Cloning pico-sdk..."
    git clone --depth 1 https://github.com/raspberrypi/pico-sdk.git "$SDK_DIR"
    
    echo "Initializing submodules (cyw43-driver, lwip)..."
    cd "$SDK_DIR"
    git submodule update --init lib/cyw43-driver
    git submodule update --init lib/lwip
else
    echo ""
    echo "pico-sdk already exists at $SDK_DIR"
fi

# Create a minimal CMake project to build the WiFi library
echo ""
echo "Creating build configuration..."

cat > "$BUILD_DIR/CMakeLists.txt" << 'EOF'
cmake_minimum_required(VERSION 3.13)

# Set board to Pico W
set(PICO_BOARD pico_w)

# Include pico-sdk
include(pico-sdk/pico_sdk_init.cmake)

project(wifi_lib C CXX ASM)

# Initialize SDK
pico_sdk_init()

# Create a static library with WiFi components
add_library(cyw43_combined STATIC)

# Link all required WiFi libraries
target_link_libraries(cyw43_combined
    pico_cyw43_arch_lwip_poll
    pico_stdlib
)

# We need to extract objects from the SDK libraries
# This is a workaround to get all symbols into one .a file
EOF

# Build
echo ""
echo "Running CMake..."
cd "$BUILD_DIR"
cmake -DPICO_SDK_PATH="$SDK_DIR" .

echo ""
echo "Building..."
make -j$(nproc 2>/dev/null || sysctl -n hw.ncpu) 2>&1 | tail -20

# Find and copy the built libraries
echo ""
echo "Collecting libraries..."

# The WiFi-related static libraries
LIBS_TO_FIND=(
    "libpico_cyw43_arch.a"
    "libcyw43_driver.a"
    "liblwip.a"
    "libpico_lwip.a"
)

# Create a combined library using ar
echo "Creating combined library..."

# Find all .a files in build directory
find . -name "*.a" -type f | head -20

# For now, copy individual libraries
for lib in "${LIBS_TO_FIND[@]}"; do
    found=$(find . -name "$lib" -type f 2>/dev/null | head -1)
    if [ -n "$found" ]; then
        cp "$found" "$LIB_DIR/"
        echo "  Copied: $lib"
    fi
done

echo ""
echo "============================================"
echo "  Build Complete!"
echo "============================================"
echo ""
echo "Libraries in $LIB_DIR:"
ls -la "$LIB_DIR"/*.a 2>/dev/null || echo "  (no .a files yet - build may need adjustment)"
echo ""
echo "Next steps:"
echo "  1. Check if libraries were created in lib/"
echo "  2. Update Pascal code to link with these libraries"
echo ""
