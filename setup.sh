#!/bin/bash
#
# Quick Setup Script for Pico-FPC
# This script helps install the required toolchain on macOS
#

set -e

echo "========================================"
echo "  Pico-FPC Setup Script"
echo "========================================"
echo ""

# Detect OS
OS=$(uname -s)
ARCH=$(uname -m)

echo "Detected: $OS ($ARCH)"
echo ""

# Check Homebrew on macOS
if [ "$OS" = "Darwin" ]; then
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    echo "Step 1: Installing ARM toolchain..."
    brew install arm-none-eabi-gcc arm-none-eabi-binutils 2>/dev/null || true
    
    echo ""
    echo "Step 2: Installing Free Pascal (native)..."
    brew install fpc 2>/dev/null || true
    
    echo ""
    echo "Step 3: Free Pascal cross-compiler needs to be built from source."
    echo ""
    echo "Run these commands:"
    echo ""
    echo "  # Clone FPC source"
    echo "  git clone https://gitlab.com/freepascal.org/fpc/source.git ~/fpc-source"
    echo "  cd ~/fpc-source"
    echo "  git checkout release_3_2_2"
    echo ""
    echo "  # Build cross-compiler"
    echo "  make all CPU_TARGET=arm OS_TARGET=embedded SUBARCH=armv6m"
    echo ""
    echo "  # Install"
    echo "  sudo make crossinstall CPU_TARGET=arm OS_TARGET=embedded SUBARCH=armv6m INSTALL_PREFIX=/usr/local"
    echo ""

elif [ "$OS" = "Linux" ]; then
    echo "Step 1: Installing ARM toolchain..."
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y gcc-arm-none-eabi binutils-arm-none-eabi libnewlib-arm-none-eabi
        sudo apt install -y fpc
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y arm-none-eabi-gcc arm-none-eabi-binutils arm-none-eabi-newlib
        sudo dnf install -y fpc
    elif command -v pacman &> /dev/null; then
        sudo pacman -S arm-none-eabi-gcc arm-none-eabi-binutils arm-none-eabi-newlib
        sudo pacman -S fpc
    fi
    
    echo ""
    echo "Step 2: Build FPC cross-compiler from source (same as macOS above)"
fi

echo ""
echo "========================================"
echo "  Verification"
echo "========================================"

echo -n "ARM GCC: "
arm-none-eabi-gcc --version 2>/dev/null | head -1 || echo "NOT FOUND"

echo -n "ARM LD: "
arm-none-eabi-ld --version 2>/dev/null | head -1 || echo "NOT FOUND"

echo -n "FPC: "
fpc -iV 2>/dev/null || echo "NOT FOUND"

echo -n "ppcrossarm: "
if command -v ppcrossarm &> /dev/null; then
    ppcrossarm -iV 2>/dev/null || echo "found but error"
else
    echo "NOT FOUND (needs to be built)"
fi

echo ""
echo "========================================"
echo ""
echo "After installing ppcrossarm, run:"
echo "  cd $(pwd)"
echo "  make blink"
echo ""
