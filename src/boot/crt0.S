/*
 * CRT0 Startup Code for Free Pascal on RP2040
 * 
 * Based on Raspberry Pi Pico SDK crt0.S
 * Simplified for FPC embedded use
 */

.cpu cortex-m0plus
.thumb

.section .vectors, "ax"
.align 2
.global __vectors

__vectors:
    .word __StackTop            /* 0x00: Initial Stack Pointer */
    .word _reset_handler        /* 0x04: Reset Handler */
    .word _nmi_handler          /* 0x08: NMI Handler */
    .word _hardfault_handler    /* 0x0C: Hard Fault Handler */
    .word 0                     /* 0x10: Reserved */
    .word 0                     /* 0x14: Reserved */
    .word 0                     /* 0x18: Reserved */
    .word 0                     /* 0x1C: Reserved */
    .word 0                     /* 0x20: Reserved */
    .word 0                     /* 0x24: Reserved */
    .word 0                     /* 0x28: Reserved */
    .word _svc_handler          /* 0x2C: SVCall Handler */
    .word 0                     /* 0x30: Reserved */
    .word 0                     /* 0x34: Reserved */
    .word _pendsv_handler       /* 0x38: PendSV Handler */
    .word _systick_handler      /* 0x3C: SysTick Handler */
    /* IRQ handlers 0-31 */
    .word _irq_handler          /* IRQ 0 */
    .word _irq_handler          /* IRQ 1 */
    .word _irq_handler          /* IRQ 2 */
    .word _irq_handler          /* IRQ 3 */
    .word _irq_handler          /* IRQ 4 */
    .word _irq_handler          /* IRQ 5 */
    .word _irq_handler          /* IRQ 6 */
    .word _irq_handler          /* IRQ 7 */
    .word _irq_handler          /* IRQ 8 */
    .word _irq_handler          /* IRQ 9 */
    .word _irq_handler          /* IRQ 10 */
    .word _irq_handler          /* IRQ 11 */
    .word _irq_handler          /* IRQ 12 */
    .word _irq_handler          /* IRQ 13 */
    .word _irq_handler          /* IRQ 14 */
    .word _irq_handler          /* IRQ 15 */
    .word _irq_handler          /* IRQ 16 */
    .word _irq_handler          /* IRQ 17 */
    .word _irq_handler          /* IRQ 18 */
    .word _irq_handler          /* IRQ 19 */
    .word _irq_handler          /* IRQ 20 */
    .word _irq_handler          /* IRQ 21 */
    .word _irq_handler          /* IRQ 22 */
    .word _irq_handler          /* IRQ 23 */
    .word _irq_handler          /* IRQ 24 */
    .word _irq_handler          /* IRQ 25 */
    .word _irq_handler          /* IRQ 26 */
    .word _irq_handler          /* IRQ 27 */
    .word _irq_handler          /* IRQ 28 */
    .word _irq_handler          /* IRQ 29 */
    .word _irq_handler          /* IRQ 30 */
    .word _irq_handler          /* IRQ 31 */

.section .text
.thumb_func
.global _reset_handler
.type _reset_handler, %function

_reset_handler:
    /* Only core 0 should run startup code */
    /* Core 1 waits in bootrom */
    ldr r0, =0xd0000000         /* SIO_BASE */
    ldr r0, [r0, #0]            /* CPUID */
    cmp r0, #0
    bne _hold_core1

    /* Copy .data section from flash to RAM */
    ldr r1, =__data_source      /* Source in flash */
    ldr r2, =__data_start       /* Destination in RAM */
    ldr r3, =__data_end
    b _copy_data_test
_copy_data_loop:
    ldm r1!, {r0}
    stm r2!, {r0}
_copy_data_test:
    cmp r2, r3
    blo _copy_data_loop

    /* Zero .bss section */
    ldr r1, =__bss_start
    ldr r2, =__bss_end
    movs r0, #0
    b _zero_bss_test
_zero_bss_loop:
    stm r1!, {r0}
_zero_bss_test:
    cmp r1, r2
    blo _zero_bss_loop

    /* Call FPC main */
    ldr r1, =PASCALMAIN
    blx r1

    /* If main returns, loop forever */
_halt:
    b _halt

_hold_core1:
    /* Core 1 waits here - could implement multicore later */
    wfi
    b _hold_core1

/* Default exception handlers - infinite loop */
.thumb_func
.weak _nmi_handler
_nmi_handler:
    b _nmi_handler

.thumb_func
.weak _hardfault_handler
_hardfault_handler:
    b _hardfault_handler

.thumb_func
.weak _svc_handler
_svc_handler:
    b _svc_handler

.thumb_func
.weak _pendsv_handler
_pendsv_handler:
    b _pendsv_handler

.thumb_func
.weak _systick_handler
_systick_handler:
    b _systick_handler

.thumb_func
.weak _irq_handler
_irq_handler:
    b _irq_handler

/* Provide _haltproc for FPC system unit */
.thumb_func
.global _haltproc
_haltproc:
    b _haltproc
