	.file "cyw43_debug_test.pas"
# Begin asmlist al_begin

.section .debug_line
.Ldebug_linesection0:
.Ldebug_line0:

.section .debug_abbrev
.Ldebug_abbrevsection0:
.Ldebug_abbrev0:

.section .text.b_DEBUGSTART_$CYW43_DEBUG_TEST
.globl	DEBUGSTART_$CYW43_DEBUG_TEST
DEBUGSTART_$CYW43_DEBUG_TEST:
# End asmlist al_begin
# Begin asmlist al_procedures

.section .text.n_cyw43_debug_test_$$_reg_write$longword$longword
	.balign 4
.thumb_func 
CYW43_DEBUG_TEST_$$_REG_WRITE$LONGWORD$LONGWORD:
.Ll1:
# [cyw43_debug_test.pas]
# [42] begin
	push	{r14}
	sub	r13,r13,#40
# Var addr located in register r0
# Var value located in register r1
# Var addr located in register r0
# Var value located in register r1
.Ll2:
# [43] PLongWord(addr)^ := value;
	str	r1,[r0]
.Ll3:
# [44] end;
	add	r13,r13,#40
	pop	{r15}
.Lt2:
.Le0:
	.size	CYW43_DEBUG_TEST_$$_REG_WRITE$LONGWORD$LONGWORD, .Le0 - CYW43_DEBUG_TEST_$$_REG_WRITE$LONGWORD$LONGWORD
.Ll4:

.section .text.n_cyw43_debug_test_$$_reg_read$longword$$longword
	.balign 4
.thumb_func 
CYW43_DEBUG_TEST_$$_REG_READ$LONGWORD$$LONGWORD:
.Ll5:
# [47] begin
	push	{r14}
	sub	r13,r13,#40
# Var $result located in register r0
# Var addr located in register r0
# Var addr located in register r0
# Var $result located in register r0
.Ll6:
# [48] Result := PLongWord(addr)^;
	ldr	r0,[r0]
.Ll7:
# [49] end;
	add	r13,r13,#40
	pop	{r15}
.Lt3:
.Le1:
	.size	CYW43_DEBUG_TEST_$$_REG_READ$LONGWORD$$LONGWORD, .Le1 - CYW43_DEBUG_TEST_$$_REG_READ$LONGWORD$$LONGWORD
.Ll8:

.section .text.n_cyw43_debug_test_$$_pascalmain
	.balign 4
.thumb_func 
.globl	CYW43_DEBUG_TEST_$$_PASCALMAIN
CYW43_DEBUG_TEST_$$_PASCALMAIN:
.thumb_func 
.globl	PASCALMAIN
PASCALMAIN:
.Ll9:
# [55] begin
	push	{r4,r5,r14}
	sub	r13,r13,#40
# Var counter located in register r0
# Var val located in register r4
.Ll10:
# [56] printf('DEBUG: PASCALMAIN started' + #10);
	ldr	r0,.Lj9
	bl	printf
# Var counter located in register r5
.Ll11:
# [58] counter := 0;
	mov	r5,#0
.Ll12:
# [59] while True do
	bl	.Lj10
	.balign 4
.Lj10:
.Ll13:
# [61] Inc(counter);
	add	r5,#1
.Ll14:
# [62] printf('=== Loop %d ===' + #10, counter);
	mov	r1,r5
	ldr	r0,.Lj13
	bl	printf
.Ll15:
# [65] printf('  Reading SIO_GPIO_IN...' + #10);
	ldr	r0,.Lj14
	bl	printf
.Ll16:
# [66] val := reg_read(SIO_BASE + SIO_GPIO_IN);
	ldr	r0,.Lj15
	bl	CYW43_DEBUG_TEST_$$_REG_READ$LONGWORD$$LONGWORD
	mov	r4,r0
.Ll17:
# [67] printf('  GPIO_IN = 0x%08X' + #10, val);
	mov	r1,r4
	ldr	r0,.Lj16
	bl	printf
.Ll18:
# [70] printf('  Reading SIO_BASE...' + #10);
	ldr	r0,.Lj17
	bl	printf
.Ll19:
# [71] val := reg_read(SIO_BASE);
	ldr	r0,.Lj18
	bl	CYW43_DEBUG_TEST_$$_REG_READ$LONGWORD$$LONGWORD
	mov	r4,r0
.Ll20:
# [72] printf('  SIO_BASE[0] = 0x%08X' + #10, val);
	mov	r1,r4
	ldr	r0,.Lj19
	bl	printf
.Ll21:
# [75] printf('  Setting GPIO23 function to SIO...' + #10);
	ldr	r0,.Lj20
	bl	printf
.Ll22:
# [76] reg_write(IO_BANK0_BASE + (PIN_POWER * 8) + 4, GPIO_FUNC_SIO);
	ldr	r0,.Lj21
	mov	r1,#5
	bl	CYW43_DEBUG_TEST_$$_REG_WRITE$LONGWORD$LONGWORD
.Ll23:
# [77] printf('  Done!' + #10);
	ldr	r0,.Lj22
	bl	printf
.Ll24:
# [80] printf('  Setting GPIO23 low...' + #10);
	ldr	r0,.Lj23
	bl	printf
.Ll25:
# [81] reg_write(SIO_BASE + SIO_GPIO_OUT_CLR, 1 shl PIN_POWER);
	ldr	r0,.Lj24
	ldr	r1,.Lj25
	bl	CYW43_DEBUG_TEST_$$_REG_WRITE$LONGWORD$LONGWORD
.Ll26:
# [82] printf('  Done!' + #10);
	ldr	r0,.Lj22
	bl	printf
.Ll27:
# [85] printf('  Enabling GPIO23 output...' + #10);
	ldr	r0,.Lj27
	bl	printf
.Ll28:
# [86] reg_write(SIO_BASE + SIO_GPIO_OE_SET, 1 shl PIN_POWER);
	ldr	r0,.Lj28
	ldr	r1,.Lj25
	bl	CYW43_DEBUG_TEST_$$_REG_WRITE$LONGWORD$LONGWORD
.Ll29:
# [87] printf('  Done!' + #10);
	ldr	r0,.Lj22
	bl	printf
.Ll30:
# [90] printf('  Setting GPIO23 high (power on)...' + #10);
	ldr	r0,.Lj31
	bl	printf
.Ll31:
# [91] reg_write(SIO_BASE + SIO_GPIO_OUT_SET, 1 shl PIN_POWER);
	ldr	r0,.Lj32
	ldr	r1,.Lj25
	bl	CYW43_DEBUG_TEST_$$_REG_WRITE$LONGWORD$LONGWORD
.Ll32:
# [92] printf('  CYW43 should be powered now!' + #10);
	ldr	r0,.Lj34
	bl	printf
.Ll33:
# [94] printf('  Waiting 3 seconds...' + #10 + #10);
	ldr	r0,.Lj35
	bl	printf
.Ll34:
# [95] picow_delay_ms(3000);
	ldr	r0,.Lj36
	bl	picow_delay_ms
.Ll35:
	bl	.Lj10
.Ll36:
# [97] end;
	add	r13,r13,#40
	pop	{r4,r5,r15}
	.balign 4
.Lj9:
	.long	_$CYW43_DEBUG_TEST$_Ld1+1
.Lj13:
	.long	_$CYW43_DEBUG_TEST$_Ld2+1
.Lj14:
	.long	_$CYW43_DEBUG_TEST$_Ld3+1
.Lj15:
	.long	-805306364
.Lj16:
	.long	_$CYW43_DEBUG_TEST$_Ld4+1
.Lj17:
	.long	_$CYW43_DEBUG_TEST$_Ld5+1
.Lj18:
	.long	-805306368
.Lj19:
	.long	_$CYW43_DEBUG_TEST$_Ld6+1
.Lj20:
	.long	_$CYW43_DEBUG_TEST$_Ld7+1
.Lj21:
	.long	1073823932
.Lj22:
	.long	_$CYW43_DEBUG_TEST$_Ld8+1
.Lj23:
	.long	_$CYW43_DEBUG_TEST$_Ld9+1
.Lj24:
	.long	-805306344
.Lj25:
	.long	8388608
.Lj27:
	.long	_$CYW43_DEBUG_TEST$_Ld10+1
.Lj28:
	.long	-805306332
.Lj31:
	.long	_$CYW43_DEBUG_TEST$_Ld11+1
.Lj32:
	.long	-805306348
.Lj34:
	.long	_$CYW43_DEBUG_TEST$_Ld12+1
.Lj35:
	.long	_$CYW43_DEBUG_TEST$_Ld13+1
.Lj36:
	.long	3000
.Lt1:
.Le2:
	.size	CYW43_DEBUG_TEST_$$_PASCALMAIN, .Le2 - CYW43_DEBUG_TEST_$$_PASCALMAIN
.Ll37:
# End asmlist al_procedures
# Begin asmlist al_typedconsts

.section .rodata.n__$CYW43_DEBUG_TEST$_Ld1
	.balign 4
	.thumb_func	
.globl	_$CYW43_DEBUG_TEST$_Ld1
_$CYW43_DEBUG_TEST$_Ld1:
	.ascii	"\032DEBUG: PASCALMAIN started\012\000"
.Le3:
	.size	_$CYW43_DEBUG_TEST$_Ld1, .Le3 - _$CYW43_DEBUG_TEST$_Ld1

.section .rodata.n__$CYW43_DEBUG_TEST$_Ld2
	.balign 4
	.thumb_func	
.globl	_$CYW43_DEBUG_TEST$_Ld2
_$CYW43_DEBUG_TEST$_Ld2:
	.ascii	"\020=== Loop %d ===\012\000"
.Le4:
	.size	_$CYW43_DEBUG_TEST$_Ld2, .Le4 - _$CYW43_DEBUG_TEST$_Ld2

.section .rodata.n__$CYW43_DEBUG_TEST$_Ld3
	.balign 4
	.thumb_func	
.globl	_$CYW43_DEBUG_TEST$_Ld3
_$CYW43_DEBUG_TEST$_Ld3:
	.ascii	"\031  Reading SIO_GPIO_IN...\012\000"
.Le5:
	.size	_$CYW43_DEBUG_TEST$_Ld3, .Le5 - _$CYW43_DEBUG_TEST$_Ld3

.section .rodata.n__$CYW43_DEBUG_TEST$_Ld4
	.balign 4
	.thumb_func	
.globl	_$CYW43_DEBUG_TEST$_Ld4
_$CYW43_DEBUG_TEST$_Ld4:
	.ascii	"\023  GPIO_IN = 0x%08X\012\000"
.Le6:
	.size	_$CYW43_DEBUG_TEST$_Ld4, .Le6 - _$CYW43_DEBUG_TEST$_Ld4

.section .rodata.n__$CYW43_DEBUG_TEST$_Ld5
	.balign 4
	.thumb_func	
.globl	_$CYW43_DEBUG_TEST$_Ld5
_$CYW43_DEBUG_TEST$_Ld5:
	.ascii	"\026  Reading SIO_BASE...\012\000"
.Le7:
	.size	_$CYW43_DEBUG_TEST$_Ld5, .Le7 - _$CYW43_DEBUG_TEST$_Ld5

.section .rodata.n__$CYW43_DEBUG_TEST$_Ld6
	.balign 4
	.thumb_func	
.globl	_$CYW43_DEBUG_TEST$_Ld6
_$CYW43_DEBUG_TEST$_Ld6:
	.ascii	"\027  SIO_BASE[0] = 0x%08X\012\000"
.Le8:
	.size	_$CYW43_DEBUG_TEST$_Ld6, .Le8 - _$CYW43_DEBUG_TEST$_Ld6

.section .rodata.n__$CYW43_DEBUG_TEST$_Ld7
	.balign 4
	.thumb_func	
.globl	_$CYW43_DEBUG_TEST$_Ld7
_$CYW43_DEBUG_TEST$_Ld7:
	.ascii	"$  Setting GPIO23 function to SIO...\012\000"
.Le9:
	.size	_$CYW43_DEBUG_TEST$_Ld7, .Le9 - _$CYW43_DEBUG_TEST$_Ld7

.section .rodata.n__$CYW43_DEBUG_TEST$_Ld8
	.balign 4
	.thumb_func	
.globl	_$CYW43_DEBUG_TEST$_Ld8
_$CYW43_DEBUG_TEST$_Ld8:
	.ascii	"\010  Done!\012\000"
.Le10:
	.size	_$CYW43_DEBUG_TEST$_Ld8, .Le10 - _$CYW43_DEBUG_TEST$_Ld8

.section .rodata.n__$CYW43_DEBUG_TEST$_Ld9
	.balign 4
	.thumb_func	
.globl	_$CYW43_DEBUG_TEST$_Ld9
_$CYW43_DEBUG_TEST$_Ld9:
	.ascii	"\030  Setting GPIO23 low...\012\000"
.Le11:
	.size	_$CYW43_DEBUG_TEST$_Ld9, .Le11 - _$CYW43_DEBUG_TEST$_Ld9

.section .rodata.n__$CYW43_DEBUG_TEST$_Ld10
	.balign 4
	.thumb_func	
.globl	_$CYW43_DEBUG_TEST$_Ld10
_$CYW43_DEBUG_TEST$_Ld10:
	.ascii	"\034  Enabling GPIO23 output...\012\000"
.Le12:
	.size	_$CYW43_DEBUG_TEST$_Ld10, .Le12 - _$CYW43_DEBUG_TEST$_Ld10

.section .rodata.n__$CYW43_DEBUG_TEST$_Ld11
	.balign 4
	.thumb_func	
.globl	_$CYW43_DEBUG_TEST$_Ld11
_$CYW43_DEBUG_TEST$_Ld11:
	.ascii	"$  Setting GPIO23 high (power on)...\012\000"
.Le13:
	.size	_$CYW43_DEBUG_TEST$_Ld11, .Le13 - _$CYW43_DEBUG_TEST$_Ld11

.section .rodata.n__$CYW43_DEBUG_TEST$_Ld12
	.balign 4
	.thumb_func	
.globl	_$CYW43_DEBUG_TEST$_Ld12
_$CYW43_DEBUG_TEST$_Ld12:
	.ascii	"\037  CYW43 should be powered now!\012\000"
.Le14:
	.size	_$CYW43_DEBUG_TEST$_Ld12, .Le14 - _$CYW43_DEBUG_TEST$_Ld12

.section .rodata.n__$CYW43_DEBUG_TEST$_Ld13
	.balign 4
	.thumb_func	
.globl	_$CYW43_DEBUG_TEST$_Ld13
_$CYW43_DEBUG_TEST$_Ld13:
	.ascii	"\030  Waiting 3 seconds...\012\012\000"
.Le15:
	.size	_$CYW43_DEBUG_TEST$_Ld13, .Le15 - _$CYW43_DEBUG_TEST$_Ld13
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
# [18] procedure printf(fmt: PChar); cdecl; varargs; external;
	.ascii	"../src/wifi/cyw43_debug_test.pas\000"
	.ascii	"Free Pascal 3.2.2-r0d122c49 2026/04/06\000"
	.ascii	"/Users/herux/Documents/pico-fpc/build-wifi/\000"
	.byte	9
	.byte	3
	.long	.Ldebug_line0
	.long	DEBUGSTART_$CYW43_DEBUG_TEST
	.long	DEBUGEND_$CYW43_DEBUG_TEST
# Syms - Begin unit CYW43_DEBUG_TEST has index 0
# Symbol CYW43_DEBUG_TEST
# Symbol SYSTEM
# Symbol OBJPAS
# Symbol PASCALMAIN
# Syms - End unit CYW43_DEBUG_TEST has index 0
# Syms - Begin Staticsymtable
# Symbol CYW43_DEBUG_TEST_$$_init$
# Symbol PRINTF
# Symbol PICOW_DELAY_MS
# Symbol SIO_BASE
	.uleb128	2
	.ascii	"SIO_BASE\000"
	.long	_$CYW43_DEBUG_TEST$_Ld14
	.uleb128	-805306368
# Symbol IO_BANK0_BASE
	.uleb128	2
	.ascii	"IO_BANK0_BASE\000"
	.long	_$CYW43_DEBUG_TEST$_Ld16
	.uleb128	1073823744
# Symbol PADS_BANK0_BASE
	.uleb128	2
	.ascii	"PADS_BANK0_BASE\000"
	.long	_$CYW43_DEBUG_TEST$_Ld16
	.uleb128	1073856512
# Symbol GPIO_FUNC_SIO
	.uleb128	2
	.ascii	"GPIO_FUNC_SIO\000"
	.long	_$CYW43_DEBUG_TEST$_Ld18
	.uleb128	5
# Symbol SIO_GPIO_OUT_SET
	.uleb128	2
	.ascii	"SIO_GPIO_OUT_SET\000"
	.long	_$CYW43_DEBUG_TEST$_Ld18
	.uleb128	20
# Symbol SIO_GPIO_OUT_CLR
	.uleb128	2
	.ascii	"SIO_GPIO_OUT_CLR\000"
	.long	_$CYW43_DEBUG_TEST$_Ld18
	.uleb128	24
# Symbol SIO_GPIO_OE_SET
	.uleb128	2
	.ascii	"SIO_GPIO_OE_SET\000"
	.long	_$CYW43_DEBUG_TEST$_Ld18
	.uleb128	36
# Symbol SIO_GPIO_OE_CLR
	.uleb128	2
	.ascii	"SIO_GPIO_OE_CLR\000"
	.long	_$CYW43_DEBUG_TEST$_Ld18
	.uleb128	40
# Symbol SIO_GPIO_IN
	.uleb128	2
	.ascii	"SIO_GPIO_IN\000"
	.long	_$CYW43_DEBUG_TEST$_Ld18
	.uleb128	4
# Symbol PIN_POWER
	.uleb128	2
	.ascii	"PIN_POWER\000"
	.long	_$CYW43_DEBUG_TEST$_Ld18
	.uleb128	23
# Symbol REG_WRITE
# Symbol REG_READ
# Syms - End Staticsymtable
# Procdef PASCALMAIN; CDecl;
	.uleb128	3
	.ascii	"PASCALMAIN\000"
	.byte	1
	.byte	1
	.long	CYW43_DEBUG_TEST_$$_PASCALMAIN
	.long	.Lt1
# Symbol COUNTER
	.uleb128	4
	.ascii	"COUNTER\000"
	.byte	2
	.byte	144
	.uleb128	5
	.long	_$CYW43_DEBUG_TEST$_Ld16
# Symbol VAL
	.uleb128	4
	.ascii	"VAL\000"
	.byte	2
	.byte	144
	.uleb128	4
	.long	_$CYW43_DEBUG_TEST$_Ld14
	.byte	0
# Procdef reg_write(LongWord;LongWord);
	.uleb128	5
	.ascii	"REG_WRITE\000"
	.byte	1
	.long	CYW43_DEBUG_TEST_$$_REG_WRITE$LONGWORD$LONGWORD
	.long	.Lt2
# Symbol ADDR
	.uleb128	6
	.ascii	"ADDR\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_DEBUG_TEST$_Ld14
# Symbol VALUE
	.uleb128	6
	.ascii	"VALUE\000"
	.byte	2
	.byte	144
	.uleb128	1
	.long	_$CYW43_DEBUG_TEST$_Ld14
	.byte	0
# Procdef reg_read(LongWord):DWord;
	.uleb128	7
	.ascii	"REG_READ\000"
	.byte	1
	.long	_$CYW43_DEBUG_TEST$_Ld14
	.long	CYW43_DEBUG_TEST_$$_REG_READ$LONGWORD$$LONGWORD
	.long	.Lt3
# Symbol ADDR
	.uleb128	6
	.ascii	"ADDR\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_DEBUG_TEST$_Ld14
# Symbol result
	.uleb128	4
	.ascii	"result\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_DEBUG_TEST$_Ld14
# Symbol REG_READ
	.uleb128	4
	.ascii	"REG_READ\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_DEBUG_TEST$_Ld14
# Symbol RESULT
	.uleb128	4
	.ascii	"RESULT\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_DEBUG_TEST$_Ld14
	.byte	0
# Defs - Begin unit SYSTEM has index 1
# Definition ShortInt
.globl	_$CYW43_DEBUG_TEST$_Ld18
_$CYW43_DEBUG_TEST$_Ld18:
	.uleb128	8
	.ascii	"SHORTINT\000"
	.long	.La1
.La1:
	.uleb128	9
	.ascii	"SHORTINT\000"
	.byte	5
	.byte	1
.globl	_$CYW43_DEBUG_TEST$_Ld19
_$CYW43_DEBUG_TEST$_Ld19:
	.uleb128	10
	.long	_$CYW43_DEBUG_TEST$_Ld18
# Definition LongWord
.globl	_$CYW43_DEBUG_TEST$_Ld14
_$CYW43_DEBUG_TEST$_Ld14:
	.uleb128	8
	.ascii	"LONGWORD\000"
	.long	.La2
.La2:
	.uleb128	9
	.ascii	"LONGWORD\000"
	.byte	7
	.byte	4
.globl	_$CYW43_DEBUG_TEST$_Ld15
_$CYW43_DEBUG_TEST$_Ld15:
	.uleb128	10
	.long	_$CYW43_DEBUG_TEST$_Ld14
# Definition LongInt
.globl	_$CYW43_DEBUG_TEST$_Ld16
_$CYW43_DEBUG_TEST$_Ld16:
	.uleb128	8
	.ascii	"LONGINT\000"
	.long	.La3
.La3:
	.uleb128	9
	.ascii	"LONGINT\000"
	.byte	5
	.byte	4
.globl	_$CYW43_DEBUG_TEST$_Ld17
_$CYW43_DEBUG_TEST$_Ld17:
	.uleb128	10
	.long	_$CYW43_DEBUG_TEST$_Ld16
# Defs - End unit SYSTEM has index 1
# Defs - Begin unit OBJPAS has index 2
# Defs - End unit OBJPAS has index 2
# Defs - Begin unit CYW43_DEBUG_TEST has index 0
# Defs - End unit CYW43_DEBUG_TEST has index 0
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
	.uleb128	52
	.byte	0
	.uleb128	3
	.uleb128	8
	.uleb128	73
	.uleb128	16
	.uleb128	28
	.uleb128	15
	.byte	0
	.byte	0
# Abbrev 3
	.uleb128	3
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
# Abbrev 4
	.uleb128	4
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
# Abbrev 5
	.uleb128	5
	.uleb128	46
	.byte	1
	.uleb128	3
	.uleb128	8
	.uleb128	39
	.uleb128	12
	.uleb128	17
	.uleb128	1
	.uleb128	18
	.uleb128	1
	.byte	0
	.byte	0
# Abbrev 6
	.uleb128	6
	.uleb128	5
	.byte	0
	.uleb128	3
	.uleb128	8
	.uleb128	2
	.uleb128	10
	.uleb128	73
	.uleb128	16
	.byte	0
	.byte	0
# Abbrev 7
	.uleb128	7
	.uleb128	46
	.byte	1
	.uleb128	3
	.uleb128	8
	.uleb128	39
	.uleb128	12
	.uleb128	73
	.uleb128	16
	.uleb128	17
	.uleb128	1
	.uleb128	18
	.uleb128	1
	.byte	0
	.byte	0
# Abbrev 8
	.uleb128	8
	.uleb128	22
	.byte	0
	.uleb128	3
	.uleb128	8
	.uleb128	73
	.uleb128	16
	.byte	0
	.byte	0
# Abbrev 9
	.uleb128	9
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
# Abbrev 10
	.uleb128	10
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
# [100] 
	.ascii	"../src/wifi\000"
	.byte	0
# file_names
	.ascii	"cyw43_debug_test.pas\000"
	.uleb128	1
	.uleb128	0
	.uleb128	0
	.byte	0
.Lehdebug_line0:
# === header end ===
# function: CYW43_DEBUG_TEST_$$_REG_WRITE$LONGWORD$LONGWORD
# [42:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll1
	.byte	5
	.uleb128	1
	.byte	53
# [43:3]
	.byte	2
	.uleb128	.Ll2-.Ll1
	.byte	5
	.uleb128	3
	.byte	13
# [44:1]
	.byte	2
	.uleb128	.Ll3-.Ll2
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll4
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_DEBUG_TEST_$$_REG_READ$LONGWORD$$LONGWORD
# [47:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll5
	.byte	5
	.uleb128	1
	.byte	58
# [48:3]
	.byte	2
	.uleb128	.Ll6-.Ll5
	.byte	5
	.uleb128	3
	.byte	13
# [49:1]
	.byte	2
	.uleb128	.Ll7-.Ll6
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll8
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_DEBUG_TEST_$$_PASCALMAIN
# function: PASCALMAIN
# [55:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll9
	.byte	5
	.uleb128	1
	.byte	66
# [56:43]
	.byte	2
	.uleb128	.Ll10-.Ll9
	.byte	5
	.uleb128	43
	.byte	13
# [58:3]
	.byte	2
	.uleb128	.Ll11-.Ll10
	.byte	5
	.uleb128	3
	.byte	14
# [59:3]
	.byte	2
	.uleb128	.Ll12-.Ll11
	.byte	13
# [61:5]
	.byte	2
	.uleb128	.Ll13-.Ll12
	.byte	5
	.uleb128	5
	.byte	14
# [62:5]
	.byte	2
	.uleb128	.Ll14-.Ll13
	.byte	13
# [65:44]
	.byte	2
	.uleb128	.Ll15-.Ll14
	.byte	5
	.uleb128	44
	.byte	15
# [66:12]
	.byte	2
	.uleb128	.Ll16-.Ll15
	.byte	5
	.uleb128	12
	.byte	13
# [67:5]
	.byte	2
	.uleb128	.Ll17-.Ll16
	.byte	5
	.uleb128	5
	.byte	13
# [70:41]
	.byte	2
	.uleb128	.Ll18-.Ll17
	.byte	5
	.uleb128	41
	.byte	15
# [71:12]
	.byte	2
	.uleb128	.Ll19-.Ll18
	.byte	5
	.uleb128	12
	.byte	13
# [72:5]
	.byte	2
	.uleb128	.Ll20-.Ll19
	.byte	5
	.uleb128	5
	.byte	13
# [75:55]
	.byte	2
	.uleb128	.Ll21-.Ll20
	.byte	5
	.uleb128	55
	.byte	15
# [76:5]
	.byte	2
	.uleb128	.Ll22-.Ll21
	.byte	5
	.uleb128	5
	.byte	13
# [77:27]
	.byte	2
	.uleb128	.Ll23-.Ll22
	.byte	5
	.uleb128	27
	.byte	13
# [80:43]
	.byte	2
	.uleb128	.Ll24-.Ll23
	.byte	5
	.uleb128	43
	.byte	15
# [81:5]
	.byte	2
	.uleb128	.Ll25-.Ll24
	.byte	5
	.uleb128	5
	.byte	13
# [82:27]
	.byte	2
	.uleb128	.Ll26-.Ll25
	.byte	5
	.uleb128	27
	.byte	13
# [85:47]
	.byte	2
	.uleb128	.Ll27-.Ll26
	.byte	5
	.uleb128	47
	.byte	15
# [86:5]
	.byte	2
	.uleb128	.Ll28-.Ll27
	.byte	5
	.uleb128	5
	.byte	13
# [87:27]
	.byte	2
	.uleb128	.Ll29-.Ll28
	.byte	5
	.uleb128	27
	.byte	13
# [90:55]
	.byte	2
	.uleb128	.Ll30-.Ll29
	.byte	5
	.uleb128	55
	.byte	15
# [91:5]
	.byte	2
	.uleb128	.Ll31-.Ll30
	.byte	5
	.uleb128	5
	.byte	13
# [92:50]
	.byte	2
	.uleb128	.Ll32-.Ll31
	.byte	5
	.uleb128	50
	.byte	13
# [94:48]
	.byte	2
	.uleb128	.Ll33-.Ll32
	.byte	5
	.uleb128	48
	.byte	14
# [95:5]
	.byte	2
	.uleb128	.Ll34-.Ll33
	.byte	5
	.uleb128	5
	.byte	13
# [59:9]
	.byte	2
	.uleb128	.Ll35-.Ll34
	.byte	5
	.uleb128	9
	.byte	3
	.sleb128	-36
	.byte	1
# [97:1]
	.byte	2
	.uleb128	.Ll36-.Ll35
	.byte	5
	.uleb128	1
	.byte	50
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll37
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
	.long	CYW43_DEBUG_TEST_$$_PASCALMAIN
	.long	.Lt1-CYW43_DEBUG_TEST_$$_PASCALMAIN
	.long	CYW43_DEBUG_TEST_$$_REG_WRITE$LONGWORD$LONGWORD
	.long	.Lt2-CYW43_DEBUG_TEST_$$_REG_WRITE$LONGWORD$LONGWORD
	.long	CYW43_DEBUG_TEST_$$_REG_READ$LONGWORD$$LONGWORD
	.long	.Lt3-CYW43_DEBUG_TEST_$$_REG_READ$LONGWORD$$LONGWORD
	.long	0
	.long	0
.Learanges0:
# End asmlist al_dwarf_aranges
# Begin asmlist al_dwarf_ranges

.section .debug_ranges
# End asmlist al_dwarf_ranges
# Begin asmlist al_end

.section .text.z_DEBUGEND_$CYW43_DEBUG_TEST
.globl	DEBUGEND_$CYW43_DEBUG_TEST
DEBUGEND_$CYW43_DEBUG_TEST:
# End asmlist al_end

