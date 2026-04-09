/* RP2040 Memory definition for FPC
   This file provides the MEMORY block that FPC's embedded ARM linker needs.
   It should be used together with FPC's generated linker script.
*/

MEMORY
{
    /* RP2040 has 264KB of SRAM starting at 0x20000000 */
    ram (rwx) : ORIGIN = 0x20000000, LENGTH = 264K
}

/* Entry point */
ENTRY(PASCALMAIN)
