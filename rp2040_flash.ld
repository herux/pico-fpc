/* RP2040 Linker Script for Free Pascal - Proper Flash Boot
   
   This linker script creates a valid RP2040 executable that can be
   converted to UF2 format for flashing.
   
   Memory Layout:
   - FLASH: 2MB at 0x10000000 (XIP execute-in-place)
   - RAM:   264KB at 0x20000000
*/

MEMORY
{
    FLASH(rx)      : ORIGIN = 0x10000000, LENGTH = 2048k
    RAM(rwx)       : ORIGIN = 0x20000000, LENGTH = 256k
    SCRATCH_X(rwx) : ORIGIN = 0x20040000, LENGTH = 4k
    SCRATCH_Y(rwx) : ORIGIN = 0x20041000, LENGTH = 4k
}

/* Program headers for proper ELF executable */
PHDRS
{
    text_phdr PT_LOAD FLAGS(5);    /* PF_R | PF_X */
    data_phdr PT_LOAD FLAGS(6);    /* PF_R | PF_W */
}

ENTRY(PASCALMAIN)

SECTIONS
{
    /* Start of flash binary */
    .flash_begin : {
        __flash_binary_start = .;
    } > FLASH

    /* Boot2 bootloader (256 bytes with CRC32)
       Must be exactly 256 bytes at the start of flash */
    .boot2 : {
        __boot2_start__ = .;
        KEEP(*(.boot2))
        __boot2_end__ = .;
    } > FLASH :text_phdr
    
    ASSERT(__boot2_end__ - __boot2_start__ == 256, "ERROR: boot2 must be exactly 256 bytes")

    /* Code section */
    .text : ALIGN(4) {
        __logical_binary_start = .;
        _text_start = .;
        
        /* Vector table placeholder */
        KEEP(*(.vectors))
        KEEP(*(.reset))
        KEEP(*(.init .init.*))
        
        /* Code */
        *(.text .text.*)
        *(.text.n_*)
        
        /* Read-only data */
        *(.strings)
        *(.rodata .rodata.*)
        
        . = ALIGN(4);
        _etext = .;
        __etext = .;
    } > FLASH :text_phdr

    /* Initialized data - stored in FLASH, copied to RAM */
    .data : ALIGN(4) {
        __data_start__ = .;
        _data = .;
        
        *(.data .data.*)
        KEEP(*(.fpc .fpc.n_version .fpc.n_links))
        
        . = ALIGN(4);
        __data_end__ = .;
        _edata = .;
    } > RAM AT > FLASH :data_phdr
    
    /* BSS section - zeroed at startup */
    .bss (NOLOAD) : ALIGN(4) {
        __bss_start__ = .;
        _bss_start = .;
        
        *(.bss .bss.*)
        *(COMMON)
        
        . = ALIGN(4);
        __bss_end__ = .;
        _bss_end = .;
    } > RAM :data_phdr

    /* Stack */
    .stack (NOLOAD) : ALIGN(8) {
        __StackLimit = .;
        . = . + 0x2000;  /* 8KB stack */
        __StackTop = .;
        _stack_top = .;
    } > RAM

    /* Heap */
    .heap (NOLOAD) : {
        __HeapBase = .;
        . = ORIGIN(RAM) + LENGTH(RAM);
        __HeapLimit = .;
    } > RAM

    /* End markers */
    _end = .;
    __end__ = .;
    __flash_binary_end = .;

    /* Scratch areas for RP2040 */
    .scratch_x (NOLOAD) : {
        __scratch_x_start__ = .;
        . = . + LENGTH(SCRATCH_X);
        __scratch_x_end__ = .;
    } > SCRATCH_X
    __scratch_x_source__ = LOADADDR(.scratch_x);

    .scratch_y (NOLOAD) : {
        __scratch_y_start__ = .;
        . = . + LENGTH(SCRATCH_Y);
        __scratch_y_end__ = .;
    } > SCRATCH_Y
    __scratch_y_source__ = LOADADDR(.scratch_y);

    /* Discard debug sections */
    /DISCARD/ : {
        *(.ARM.exidx*)
        *(.ARM.extab*)
        *(.comment)
        *(.debug*)
    }
}

/* Provide symbols for C runtime compatibility */
PROVIDE(__stack = __StackTop);
PROVIDE(end = _end);
