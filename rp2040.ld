/* RP2040 Linker Script for Free Pascal
   
   Memory Layout:
   - Flash: 2MB starting at 0x10000000
   - SRAM: 264KB starting at 0x20000000
   
   For Pico W WiFi support, code runs from RAM
*/

MEMORY
{
    FLASH (rx)  : ORIGIN = 0x10000000, LENGTH = 2048K
    RAM   (rwx) : ORIGIN = 0x20000000, LENGTH = 264K
}

/* Entry point */
ENTRY(PASCALMAIN)

SECTIONS
{
    /* Code section - place in FLASH */
    .text : ALIGN(4)
    {
        _text_start = .;
        
        /* Vector table should be first */
        KEEP(*(.vectors))
        KEEP(*(.reset))
        
        /* FPC generated code sections */
        *(.text)
        *(.text.*)
        *(.text.n_*)
        
        /* Read-only data */
        *(.rodata)
        *(.rodata.*)
        
        . = ALIGN(4);
        _etext = .;
    } > FLASH

    /* Initialized data - stored in FLASH, copied to RAM at startup */
    .data : ALIGN(4)
    {
        _data = .;
        _data_start = .;
        
        *(.data)
        *(.data.*)
        
        . = ALIGN(4);
        _edata = .;
    } > RAM AT > FLASH
    
    _data_load = LOADADDR(.data);

    /* BSS section - uninitialized data in RAM */
    .bss : ALIGN(4)
    {
        _bss_start = .;
        
        *(.bss)
        *(.bss.*)
        *(COMMON)
        
        . = ALIGN(4);
        _bss_end = .;
    } > RAM

    /* Stack - grows downward from top of RAM */
    .stack (NOLOAD) : ALIGN(8)
    {
        . = . + 0x2000;  /* 8KB stack */
        _stack_top = .;
    } > RAM

    /* Heap - uses remaining RAM */
    .heap (NOLOAD) : ALIGN(4)
    {
        _heap_start = .;
        . = ORIGIN(RAM) + LENGTH(RAM) - 0x100;
        _heap_end = .;
    } > RAM

    _end = .;

    /* For compatibility with FPC */
    __fpc_ident = .;
    
    /* Discard unwanted sections */
    /DISCARD/ :
    {
        *(.ARM.exidx*)
        *(.ARM.extab*)
    }
}
