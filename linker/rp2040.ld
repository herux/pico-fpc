/* 
 * RP2040 Linker Script for Free Pascal
 *
 * Based on Raspberry Pi Pico SDK
 * Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
 * SPDX-License-Identifier: BSD-3-Clause
 */

MEMORY
{
    FLASH(rx)      : ORIGIN = 0x10000000, LENGTH = 2M
    RAM(rwx)       : ORIGIN = 0x20000000, LENGTH = 256K
    SCRATCH_X(rwx) : ORIGIN = 0x20040000, LENGTH = 4K
    SCRATCH_Y(rwx) : ORIGIN = 0x20041000, LENGTH = 4K
}

ENTRY(_boot2_entry)

SECTIONS
{
    /* Boot2 stage - must be first 256 bytes */
    .boot2 : {
        __boot2_start__ = .;
        KEEP (*(.boot2))
        __boot2_end__ = .;
    } > FLASH

    ASSERT(__boot2_end__ - __boot2_start__ == 256, "boot2 must be 256 bytes")

    /* Main program */
    .text : {
        __logical_binary_start = .;
        KEEP (*(.vectors))
        KEEP (*(.binary_info_header))
        __binary_info_header_end = .;
        KEEP (*(.reset))
        *(.text*)
        *(.rodata*)
        . = ALIGN(4);
        __etext = .;
    } > FLASH

    /* Initialized data - copied from FLASH to RAM */
    .data : {
        __data_start__ = .;
        *(.data*)
        . = ALIGN(4);
        __data_end__ = .;
    } > RAM AT> FLASH

    __data_load_start__ = LOADADDR(.data);

    /* Uninitialized data */
    .bss (NOLOAD) : {
        __bss_start__ = .;
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        __bss_end__ = .;
    } > RAM

    /* Heap */
    .heap (NOLOAD) : {
        __heap_start__ = .;
        . = . + 0x10000; /* 64K heap */
        __heap_end__ = .;
    } > RAM

    /* Stack */
    .stack (NOLOAD) : {
        __stack_bottom__ = .;
        . = . + 0x4000; /* 16K stack */
        __stack_top__ = .;
    } > RAM

    /* Scratch memory */
    .scratch_x : {
        *(.scratch_x*)
    } > SCRATCH_X

    .scratch_y : {
        *(.scratch_y*)
    } > SCRATCH_Y

    /* Symbols for runtime */
    __flash_start__ = ORIGIN(FLASH);
    __flash_end__ = ORIGIN(FLASH) + LENGTH(FLASH);
    __ram_start__ = ORIGIN(RAM);
    __ram_end__ = ORIGIN(RAM) + LENGTH(RAM);
}
