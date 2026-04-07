// RP2040 Startup for Free Pascal - bypasses FPC runtime
.syntax unified
.cpu cortex-m0plus
.thumb

.section .vectors, "ax"
.align 2
.global __vectors

__vectors:
    .word __StackTop           // 0: Initial Stack Pointer
    .word _start               // 1: Reset Handler
    .word _hang                // 2: NMI Handler
    .word _hang                // 3: Hard Fault Handler
    .word 0, 0, 0, 0, 0, 0, 0  // 4-10: Reserved
    .word _hang                // 11: SVCall
    .word 0, 0                 // 12-13: Reserved
    .word _hang                // 14: PendSV
    .word _hang                // 15: SysTick
    // IRQs 0-31
    .word _hang, _hang, _hang, _hang, _hang, _hang, _hang, _hang
    .word _hang, _hang, _hang, _hang, _hang, _hang, _hang, _hang
    .word _hang, _hang, _hang, _hang, _hang, _hang, _hang, _hang
    .word _hang, _hang, _hang, _hang, _hang, _hang, _hang, _hang

.section .reset, "ax"
.align 2
.thumb_func
.global _start
_start:
    // Set stack pointer
    ldr r0, =__StackTop
    mov sp, r0
    
    // Call Pascal main directly (bypassing fpc_initializeunits)
    ldr r0, =PASCALMAIN
    bx r0

.thumb_func
.global _hang
_hang:
    b .

// Provide _haltproc for FPC runtime
.thumb_func
.global _haltproc
_haltproc:
    b .
