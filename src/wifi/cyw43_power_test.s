	.file "cyw43_power_test.pas"
# Begin asmlist al_begin

.section .debug_line
.Ldebug_linesection0:
.Ldebug_line0:

.section .debug_abbrev
.Ldebug_abbrevsection0:
.Ldebug_abbrev0:

.section .text.b_DEBUGSTART_$CYW43_POWER_TEST
.globl	DEBUGSTART_$CYW43_POWER_TEST
DEBUGSTART_$CYW43_POWER_TEST:
# End asmlist al_begin
# Begin asmlist al_procedures

.section .text.n_cyw43_power_test_$$_pascalmain
	.balign 4
.thumb_func 
.globl	CYW43_POWER_TEST_$$_PASCALMAIN
CYW43_POWER_TEST_$$_PASCALMAIN:
.thumb_func 
.globl	PASCALMAIN
PASCALMAIN:
.Ll1:
# [cyw43_power_test.pas]
# [35] begin
	push	{r4,r5,r6,r14}
	sub	r13,r13,#48
# Var chip_id located in register r5
# Var i located in register r4
# Var loop located in register r0
# Var loop located in register r6
.Ll2:
# [37] loop := 0;
	mov	r6,#0
.Ll3:
# [38] while True do
	bl	.Lj5
	.balign 4
.Lj5:
.Ll4:
# [40] Inc(loop);
	add	r6,#1
.Ll5:
# [41] printf('=== Loop %d ===' + #10, loop);
	mov	r1,r6
	ldr	r0,.Lj8
	bl	printf
.Ll6:
# [42] printf('Step 1: Initialize GPIO...' + #10);
	ldr	r0,.Lj9
	bl	printf
.Ll7:
# [45] cyw43_power_init;
	bl	CYW43_LL_$$_CYW43_POWER_INIT
.Ll8:
# [46] printf('  GPIO pins configured' + #10);
	ldr	r0,.Lj10
	bl	printf
.Ll9:
# [48] printf('Step 2: Power ON CYW43...' + #10);
	ldr	r0,.Lj11
	bl	printf
.Ll10:
# [49] cyw43_power_on;
	bl	CYW43_LL_$$_CYW43_POWER_ON
.Ll11:
# [51] if cyw43_is_powered then
	bl	CYW43_LL_$$_CYW43_IS_POWERED$$BOOLEAN
	cmp	r0,#0
	beq	.Lj14
	bl	.Lj12
.Lj14:
	bl	.Lj13
.Lj12:
.Ll12:
# [52] printf('  CYW43 powered ON' + #10)
	ldr	r0,.Lj15
	bl	printf
	bl	.Lj16
.Lj13:
.Ll13:
# [54] printf('  ERROR: Power check failed!' + #10);
	ldr	r0,.Lj17
	bl	printf
.Lj16:
.Ll14:
# [57] picow_delay_ms(100);
	mov	r0,#100
	bl	picow_delay_ms
.Ll15:
# [59] printf('Step 3: Reading Chip ID via SPI...' + #10);
	ldr	r0,.Lj18
	bl	printf
.Ll16:
# [62] for i := 1 to 3 do
	mov	r4,#0
	.balign 4
.Lj19:
	mov	r0,r4
	add	r0,#1
	mov	r4,r0
.Ll17:
# [64] chip_id := cyw43_get_chip_id;
	bl	CYW43_LL_$$_CYW43_GET_CHIP_ID$$LONGWORD
	mov	r5,r0
.Ll18:
# [65] printf('  Attempt %d: Chip ID = 0x%08X' + #10, i, chip_id);
	mov	r2,r5
	mov	r1,r4
	ldr	r0,.Lj22
	bl	printf
.Ll19:
# [66] picow_delay_ms(50);
	mov	r0,#50
	bl	picow_delay_ms
.Ll20:
	cmp	r4,#3
	blt	.Lj23
	bl	.Lj21
.Lj23:
	bl	.Lj19
.Lj21:
.Ll21:
# [69] printf('Waiting 5 seconds...' + #10 + #10);
	ldr	r0,.Lj24
	bl	printf
.Ll22:
# [70] picow_delay_ms(5000);
	ldr	r0,.Lj25
	bl	picow_delay_ms
.Ll23:
# [73] cyw43_power_off;
	bl	CYW43_LL_$$_CYW43_POWER_OFF
.Ll24:
# [74] picow_delay_ms(100);
	mov	r0,#100
	bl	picow_delay_ms
.Ll25:
	bl	.Lj5
.Ll26:
# [76] end;
	add	r13,r13,#48
	pop	{r4,r5,r6,r15}
	.balign 4
.Lj8:
	.long	_$CYW43_POWER_TEST$_Ld1+1
.Lj9:
	.long	_$CYW43_POWER_TEST$_Ld2+1
.Lj10:
	.long	_$CYW43_POWER_TEST$_Ld3+1
.Lj11:
	.long	_$CYW43_POWER_TEST$_Ld4+1
.Lj15:
	.long	_$CYW43_POWER_TEST$_Ld5+1
.Lj17:
	.long	_$CYW43_POWER_TEST$_Ld6+1
.Lj18:
	.long	_$CYW43_POWER_TEST$_Ld7+1
.Lj22:
	.long	_$CYW43_POWER_TEST$_Ld8+1
.Lj24:
	.long	_$CYW43_POWER_TEST$_Ld9+1
.Lj25:
	.long	5000
.Lt1:
.Le0:
	.size	CYW43_POWER_TEST_$$_PASCALMAIN, .Le0 - CYW43_POWER_TEST_$$_PASCALMAIN
.Ll27:
# End asmlist al_procedures
# Begin asmlist al_typedconsts

.section .rodata.n__$CYW43_POWER_TEST$_Ld1
	.balign 4
	.thumb_func	
.globl	_$CYW43_POWER_TEST$_Ld1
_$CYW43_POWER_TEST$_Ld1:
	.ascii	"\020=== Loop %d ===\012\000"
.Le1:
	.size	_$CYW43_POWER_TEST$_Ld1, .Le1 - _$CYW43_POWER_TEST$_Ld1

.section .rodata.n__$CYW43_POWER_TEST$_Ld2
	.balign 4
	.thumb_func	
.globl	_$CYW43_POWER_TEST$_Ld2
_$CYW43_POWER_TEST$_Ld2:
	.ascii	"\033Step 1: Initialize GPIO...\012\000"
.Le2:
	.size	_$CYW43_POWER_TEST$_Ld2, .Le2 - _$CYW43_POWER_TEST$_Ld2

.section .rodata.n__$CYW43_POWER_TEST$_Ld3
	.balign 4
	.thumb_func	
.globl	_$CYW43_POWER_TEST$_Ld3
_$CYW43_POWER_TEST$_Ld3:
	.ascii	"\027  GPIO pins configured\012\000"
.Le3:
	.size	_$CYW43_POWER_TEST$_Ld3, .Le3 - _$CYW43_POWER_TEST$_Ld3

.section .rodata.n__$CYW43_POWER_TEST$_Ld4
	.balign 4
	.thumb_func	
.globl	_$CYW43_POWER_TEST$_Ld4
_$CYW43_POWER_TEST$_Ld4:
	.ascii	"\032Step 2: Power ON CYW43...\012\000"
.Le4:
	.size	_$CYW43_POWER_TEST$_Ld4, .Le4 - _$CYW43_POWER_TEST$_Ld4

.section .rodata.n__$CYW43_POWER_TEST$_Ld5
	.balign 4
	.thumb_func	
.globl	_$CYW43_POWER_TEST$_Ld5
_$CYW43_POWER_TEST$_Ld5:
	.ascii	"\023  CYW43 powered ON\012\000"
.Le5:
	.size	_$CYW43_POWER_TEST$_Ld5, .Le5 - _$CYW43_POWER_TEST$_Ld5

.section .rodata.n__$CYW43_POWER_TEST$_Ld6
	.balign 4
	.thumb_func	
.globl	_$CYW43_POWER_TEST$_Ld6
_$CYW43_POWER_TEST$_Ld6:
	.ascii	"\035  ERROR: Power check failed!\012\000"
.Le6:
	.size	_$CYW43_POWER_TEST$_Ld6, .Le6 - _$CYW43_POWER_TEST$_Ld6

.section .rodata.n__$CYW43_POWER_TEST$_Ld7
	.balign 4
	.thumb_func	
.globl	_$CYW43_POWER_TEST$_Ld7
_$CYW43_POWER_TEST$_Ld7:
	.ascii	"#Step 3: Reading Chip ID via SPI...\012\000"
.Le7:
	.size	_$CYW43_POWER_TEST$_Ld7, .Le7 - _$CYW43_POWER_TEST$_Ld7

.section .rodata.n__$CYW43_POWER_TEST$_Ld8
	.balign 4
	.thumb_func	
.globl	_$CYW43_POWER_TEST$_Ld8
_$CYW43_POWER_TEST$_Ld8:
	.ascii	"\037  Attempt %d: Chip ID = 0x%08X\012\000"
.Le8:
	.size	_$CYW43_POWER_TEST$_Ld8, .Le8 - _$CYW43_POWER_TEST$_Ld8

.section .rodata.n__$CYW43_POWER_TEST$_Ld9
	.balign 4
	.thumb_func	
.globl	_$CYW43_POWER_TEST$_Ld9
_$CYW43_POWER_TEST$_Ld9:
	.ascii	"\026Waiting 5 seconds...\012\012\000"
.Le9:
	.size	_$CYW43_POWER_TEST$_Ld9, .Le9 - _$CYW43_POWER_TEST$_Ld9
# End asmlist al_typedconsts
# Begin asmlist al_dwarf_info

.section .debug_info
.Ldebug_info0:
	.long	.Ledebug_info0-.Lf2
.Lf2:
	.short	2
	.long	.Ldebug_abbrev0
	.byte	4
	.uleb128	1
# [28] procedure printf(fmt: PChar); cdecl; varargs; external;
	.ascii	"../src/wifi/cyw43_power_test.pas\000"
	.ascii	"Free Pascal 3.2.2-r0d122c49 2026/04/06\000"
	.ascii	"/Users/herux/Documents/pico-fpc/build-wifi/\000"
	.byte	9
	.byte	3
	.long	.Ldebug_line0
	.long	DEBUGSTART_$CYW43_POWER_TEST
	.long	DEBUGEND_$CYW43_POWER_TEST
# Syms - Begin unit CYW43_POWER_TEST has index 0
# Symbol CYW43_POWER_TEST
# Symbol SYSTEM
# Symbol OBJPAS
# Symbol PASCALMAIN
# Syms - End unit CYW43_POWER_TEST has index 0
# Syms - Begin Staticsymtable
# Symbol CYW43_LL
# Symbol CYW43_POWER_TEST_$$_init$
# Symbol PRINTF
# Symbol PICOW_DELAY_MS
# Syms - End Staticsymtable
# Procdef PASCALMAIN; CDecl;
	.uleb128	2
	.ascii	"PASCALMAIN\000"
	.byte	1
	.byte	1
	.long	CYW43_POWER_TEST_$$_PASCALMAIN
	.long	.Lt1
# Symbol CHIP_ID
	.uleb128	3
	.ascii	"CHIP_ID\000"
	.byte	2
	.byte	144
	.uleb128	5
	.long	_$CYW43_POWER_TEST$_Ld10
# Symbol I
	.uleb128	3
	.ascii	"I\000"
	.byte	2
	.byte	144
	.uleb128	4
	.long	_$CYW43_POWER_TEST$_Ld12
# Symbol LOOP
	.uleb128	3
	.ascii	"LOOP\000"
	.byte	2
	.byte	144
	.uleb128	6
	.long	_$CYW43_POWER_TEST$_Ld12
	.byte	0
# Defs - Begin unit SYSTEM has index 1
# Definition LongWord
.globl	_$CYW43_POWER_TEST$_Ld10
_$CYW43_POWER_TEST$_Ld10:
	.uleb128	4
	.ascii	"LONGWORD\000"
	.long	.La1
.La1:
	.uleb128	5
	.ascii	"LONGWORD\000"
	.byte	7
	.byte	4
.globl	_$CYW43_POWER_TEST$_Ld11
_$CYW43_POWER_TEST$_Ld11:
	.uleb128	6
	.long	_$CYW43_POWER_TEST$_Ld10
# Definition LongInt
.globl	_$CYW43_POWER_TEST$_Ld12
_$CYW43_POWER_TEST$_Ld12:
	.uleb128	4
	.ascii	"LONGINT\000"
	.long	.La2
.La2:
	.uleb128	5
	.ascii	"LONGINT\000"
	.byte	5
	.byte	4
.globl	_$CYW43_POWER_TEST$_Ld13
_$CYW43_POWER_TEST$_Ld13:
	.uleb128	6
	.long	_$CYW43_POWER_TEST$_Ld12
# Defs - End unit SYSTEM has index 1
# Defs - Begin unit OBJPAS has index 2
# Defs - End unit OBJPAS has index 2
# Defs - Begin unit CYW43_LL has index 3
# Defs - End unit CYW43_LL has index 3
# Defs - Begin unit CYW43_POWER_TEST has index 0
# Defs - End unit CYW43_POWER_TEST has index 0
# Defs - Begin Staticsymtable
# Defs - End Staticsymtable
	.byte	0
.Ledebug_info0:
# End asmlist al_dwarf_info
# Begin asmlist al_dwarf_abbrev

.section .debug_abbrev
# Abbrev 1
	.uleb128	1
	.uleb128	17
	.byte	1
	.uleb128	3
	.uleb128	8
	.uleb128	37
	.uleb128	8
	.uleb128	27
	.uleb128	8
	.uleb128	19
	.uleb128	11
	.uleb128	66
	.uleb128	11
	.uleb128	16
	.uleb128	6
	.uleb128	17
	.uleb128	1
	.uleb128	18
	.uleb128	1
	.byte	0
	.byte	0
# Abbrev 2
	.uleb128	2
	.uleb128	46
	.byte	1
	.uleb128	3
	.uleb128	8
	.uleb128	39
	.uleb128	12
	.uleb128	63
	.uleb128	12
	.uleb128	17
	.uleb128	1
	.uleb128	18
	.uleb128	1
	.byte	0
	.byte	0
# Abbrev 3
	.uleb128	3
	.uleb128	52
	.byte	0
	.uleb128	3
	.uleb128	8
	.uleb128	2
	.uleb128	10
	.uleb128	73
	.uleb128	16
	.byte	0
	.byte	0
# Abbrev 4
	.uleb128	4
	.uleb128	22
	.byte	0
	.uleb128	3
	.uleb128	8
	.uleb128	73
	.uleb128	16
	.byte	0
	.byte	0
# Abbrev 5
	.uleb128	5
	.uleb128	36
	.byte	0
	.uleb128	3
	.uleb128	8
	.uleb128	62
	.uleb128	11
	.uleb128	11
	.uleb128	11
	.byte	0
	.byte	0
# Abbrev 6
	.uleb128	6
	.uleb128	16
	.byte	0
	.uleb128	73
	.uleb128	16
	.byte	0
	.byte	0
	.byte	0
# End asmlist al_dwarf_abbrev
# Begin asmlist al_dwarf_line

.section .debug_line
# === header start ===
	.long	.Ledebug_line0-.Lf3
.Lf3:
	.short	2
	.long	.Lehdebug_line0-.Lf4
.Lf4:
	.byte	1
	.byte	1
	.byte	1
	.byte	255
	.byte	13
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	1
# include_directories
# [79] 
	.ascii	"../src/wifi\000"
	.byte	0
# file_names
	.ascii	"cyw43_power_test.pas\000"
	.uleb128	1
	.uleb128	0
	.uleb128	0
	.byte	0
.Lehdebug_line0:
# === header end ===
# function: CYW43_POWER_TEST_$$_PASCALMAIN
# function: PASCALMAIN
# [35:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll1
	.byte	5
	.uleb128	1
	.byte	46
# [37:3]
	.byte	2
	.uleb128	.Ll2-.Ll1
	.byte	5
	.uleb128	3
	.byte	14
# [38:3]
	.byte	2
	.uleb128	.Ll3-.Ll2
	.byte	13
# [40:5]
	.byte	2
	.uleb128	.Ll4-.Ll3
	.byte	5
	.uleb128	5
	.byte	14
# [41:5]
	.byte	2
	.uleb128	.Ll5-.Ll4
	.byte	13
# [42:46]
	.byte	2
	.uleb128	.Ll6-.Ll5
	.byte	5
	.uleb128	46
	.byte	13
# [45:5]
	.byte	2
	.uleb128	.Ll7-.Ll6
	.byte	5
	.uleb128	5
	.byte	15
# [46:42]
	.byte	2
	.uleb128	.Ll8-.Ll7
	.byte	5
	.uleb128	42
	.byte	13
# [48:45]
	.byte	2
	.uleb128	.Ll9-.Ll8
	.byte	5
	.uleb128	45
	.byte	14
# [49:5]
	.byte	2
	.uleb128	.Ll10-.Ll9
	.byte	5
	.uleb128	5
	.byte	13
# [51:8]
	.byte	2
	.uleb128	.Ll11-.Ll10
	.byte	5
	.uleb128	8
	.byte	14
# [52:40]
	.byte	2
	.uleb128	.Ll12-.Ll11
	.byte	5
	.uleb128	40
	.byte	13
# [54:50]
	.byte	2
	.uleb128	.Ll13-.Ll12
	.byte	5
	.uleb128	50
	.byte	14
# [57:5]
	.byte	2
	.uleb128	.Ll14-.Ll13
	.byte	5
	.uleb128	5
	.byte	15
# [59:54]
	.byte	2
	.uleb128	.Ll15-.Ll14
	.byte	5
	.uleb128	54
	.byte	14
# [62:5]
	.byte	2
	.uleb128	.Ll16-.Ll15
	.byte	5
	.uleb128	5
	.byte	15
# [64:18]
	.byte	2
	.uleb128	.Ll17-.Ll16
	.byte	5
	.uleb128	18
	.byte	14
# [65:7]
	.byte	2
	.uleb128	.Ll18-.Ll17
	.byte	5
	.uleb128	7
	.byte	13
# [66:7]
	.byte	2
	.uleb128	.Ll19-.Ll18
	.byte	13
# [62:5]
	.byte	2
	.uleb128	.Ll20-.Ll19
	.byte	5
	.uleb128	5
	.byte	3
	.sleb128	-4
	.byte	1
# [69:46]
	.byte	2
	.uleb128	.Ll21-.Ll20
	.byte	5
	.uleb128	46
	.byte	19
# [70:5]
	.byte	2
	.uleb128	.Ll22-.Ll21
	.byte	5
	.uleb128	5
	.byte	13
# [73:5]
	.byte	2
	.uleb128	.Ll23-.Ll22
	.byte	15
# [74:5]
	.byte	2
	.uleb128	.Ll24-.Ll23
	.byte	13
# [38:9]
	.byte	2
	.uleb128	.Ll25-.Ll24
	.byte	5
	.uleb128	9
	.byte	3
	.sleb128	-36
	.byte	1
# [76:1]
	.byte	2
	.uleb128	.Ll26-.Ll25
	.byte	5
	.uleb128	1
	.byte	50
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll27
	.byte	0
	.byte	1
	.byte	1
# ###################
.Ledebug_line0:
# End asmlist al_dwarf_line
# Begin asmlist al_dwarf_aranges

.section .debug_aranges
	.long	.Learanges0-.Lf1
.Lf1:
	.short	2
	.long	.Ldebug_info0
	.byte	4
	.byte	0
	.long	0
	.long	CYW43_POWER_TEST_$$_PASCALMAIN
	.long	.Lt1-CYW43_POWER_TEST_$$_PASCALMAIN
	.long	0
	.long	0
.Learanges0:
# End asmlist al_dwarf_aranges
# Begin asmlist al_dwarf_ranges

.section .debug_ranges
# End asmlist al_dwarf_ranges
# Begin asmlist al_end

.section .text.z_DEBUGEND_$CYW43_POWER_TEST
.globl	DEBUGEND_$CYW43_POWER_TEST
DEBUGEND_$CYW43_POWER_TEST:
# End asmlist al_end

