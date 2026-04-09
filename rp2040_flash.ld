/* RP2040 Linker Script for Free Pascal - Flash Boot
 *
 * Memory layout for XIP (execute in place) from flash
 * with data/bss in RAM
 */

MEMORY
{
    FLASH (rx)  : ORIGIN = 0x10000000, LENGTH = 2M
    RAM   (rwx) : ORIGIN = 0x20000000, LENGTH = 264K
}

ENTRY(_reset_handler)

SECTIONS
{
    /* Boot stage 2 - must be first 256 bytes */
    .boot2 : {
        __boot2_start = .;
        KEEP(*(.boot2))
        __boot2_end = .;
    } > FLASH

    ASSERT(__boot2_end - __boot2_start == 256, "Boot2 must be exactly 256 bytes")

    /* Vector table and code */
    .text : ALIGN(4) {
        __text_start = .;
        KEEP(*(.vectors))
        KEEP(*(.init .init.*))
        *(.text)
        *(.text.*)
        *(.text.n_*)
        *(.rodata)
        *(.rodata.*)
        . = ALIGN(4);
        __text_end = .;
    } > FLASH

    /* Data section - stored in flash, copied to RAM at startup */
    .data : ALIGN(4) {
        __data_start = .;
        *(.data)
        *(.data.*)
        KEEP(*(.fpc .fpc.n_version .fpc.n_links))
        . = ALIGN(4);
        __data_end = .;
    } > RAM AT> FLASH

    /* Source address of .data in flash (for copy) */
    __data_source = LOADADDR(.data);

    /* BSS section - zero initialized in RAM */
    .bss (NOLOAD) : ALIGN(4) {
        __bss_start = .;
        *(.bss)
        *(.bss.*)
        *(COMMON)
        . = ALIGN(4);
        __bss_end = .;
    } > RAM

    /* Stack at end of RAM */
    .stack (NOLOAD) : {
        . = ALIGN(8);
        __StackBottom = .;
        . = . + 4K;
        __StackTop = .;
    } > RAM

    _end = .;
}
