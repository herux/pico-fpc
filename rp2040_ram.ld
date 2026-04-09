/* RP2040 RAM-only Linker Script for Free Pascal Testing
   
   Puts everything in RAM for simpler testing.
   For production use, code should be in FLASH.
*/

MEMORY
{
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 264K
}

/* Entry point */
ENTRY(PASCALMAIN)

/* Program headers - required for UF2 conversion */
PHDRS
{
    ram_text PT_LOAD FLAGS(7);  /* RWX */
}

SECTIONS
{
    /* Code section */
    .text : ALIGN(4)
    {
        _text_start = .;
        
        KEEP(*(.vectors))
        KEEP(*(.reset))
        
        *(.text)
        *(.text.*)
        *(.text.n_*)
        
        *(.rodata)
        *(.rodata.*)
        
        . = ALIGN(4);
        _etext = .;
    } > RAM :ram_text

    /* Data section */
    .data : ALIGN(4)
    {
        _data = .;
        _data_start = .;
        
        *(.data)
        *(.data.*)
        
        . = ALIGN(4);
        _edata = .;
    } > RAM :ram_text

    /* BSS section */
    .bss : ALIGN(4)
    {
        _bss_start = .;
        
        *(.bss)
        *(.bss.*)
        *(COMMON)
        
        . = ALIGN(4);
        _bss_end = .;
    } > RAM :ram_text

    /* Stack */
    .stack (NOLOAD) : ALIGN(8)
    {
        . = . + 0x2000;
        _stack_top = .;
    } > RAM

    _end = .;
    __fpc_ident = .;
    
    /DISCARD/ :
    {
        *(.ARM.exidx*)
        *(.ARM.extab*)
    }
}
