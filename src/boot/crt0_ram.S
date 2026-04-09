/*
 * Minimal startup code for Free Pascal RAM-only execution
 * Only provides _haltproc for FPC system unit
 */

.cpu cortex-m0plus
.thumb

/* Put _haltproc after .text so PASCALMAIN stays at entry point */
.section .text.zzz_haltproc, "ax"

/* Provide _haltproc for FPC system unit */
.thumb_func
.global _haltproc
_haltproc:
    b _haltproc
