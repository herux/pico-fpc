	.file "cyw43_ll.pas"
# Begin asmlist al_begin

.section .debug_line
.Ldebug_linesection0:
.Ldebug_line0:

.section .debug_abbrev
.Ldebug_abbrevsection0:
.Ldebug_abbrev0:

.section .text.b_DEBUGSTART_$CYW43_LL
.globl	DEBUGSTART_$CYW43_LL
DEBUGSTART_$CYW43_LL:
# End asmlist al_begin
# Begin asmlist al_procedures

.section .text.n_cyw43_ll_$$_reg_write$longword$longword
	.balign 4
.thumb_func 
CYW43_LL_$$_REG_WRITE$LONGWORD$LONGWORD:
.Ll1:
# [cyw43_ll.pas]
# [76] begin
	push	{r14}
	sub	r13,r13,#40
# Var addr located in register r0
# Var value located in register r1
# Var addr located in register r0
# Var value located in register r1
.Ll2:
# [77] PLongWord(addr)^ := value;
	str	r1,[r0]
.Ll3:
# [78] end;
	add	r13,r13,#40
	pop	{r15}
.Lt14:
.Le0:
	.size	CYW43_LL_$$_REG_WRITE$LONGWORD$LONGWORD, .Le0 - CYW43_LL_$$_REG_WRITE$LONGWORD$LONGWORD
.Ll4:

.section .text.n_cyw43_ll_$$_reg_read$longword$$longword
	.balign 4
.thumb_func 
CYW43_LL_$$_REG_READ$LONGWORD$$LONGWORD:
.Ll5:
# [81] begin
	push	{r14}
	sub	r13,r13,#40
# Var $result located in register r0
# Var addr located in register r0
# Var addr located in register r0
# Var $result located in register r0
.Ll6:
# [82] Result := PLongWord(addr)^;
	ldr	r0,[r0]
.Ll7:
# [83] end;
	add	r13,r13,#40
	pop	{r15}
.Lt15:
.Le1:
	.size	CYW43_LL_$$_REG_READ$LONGWORD$$LONGWORD, .Le1 - CYW43_LL_$$_REG_READ$LONGWORD$$LONGWORD
.Ll8:

.section .text.n_cyw43_ll_$$_gpio_set_function$longword$longword
	.balign 4
.thumb_func 
CYW43_LL_$$_GPIO_SET_FUNCTION$LONGWORD$LONGWORD:
.Ll9:
# [89] begin
	push	{r14}
	sub	r13,r13,#48
# Var ctrl_addr located in register r0
# Var gpio located in register r0
# Var func located in register r1
.Ll10:
# [90] ctrl_addr := IO_BANK0_BASE + (gpio * 8) + 4;
	lsl	r0,r0,#3
	ldr	r2,.Lj9
	add	r0,r2
	add	r0,#4
# Var ctrl_addr located in register r0
# Var ctrl_addr located in register r0
# Var func located in register r1
.Ll11:
# [91] reg_write(ctrl_addr, func);
	str	r1,[r0]
.Ll12:
# [92] end;
	add	r13,r13,#48
	pop	{r15}
	.balign 4
.Lj9:
	.long	1073823744
.Lt16:
.Le2:
	.size	CYW43_LL_$$_GPIO_SET_FUNCTION$LONGWORD$LONGWORD, .Le2 - CYW43_LL_$$_GPIO_SET_FUNCTION$LONGWORD$LONGWORD
.Ll13:

.section .text.n_cyw43_ll_$$_gpio_set_output$longword
	.balign 4
.thumb_func 
CYW43_LL_$$_GPIO_SET_OUTPUT$LONGWORD:
.Ll14:
# [96] begin
	push	{r14}
	sub	r13,r13,#48
# Var gpio located in register r0
.Ll15:
# [97] reg_write(SIO_BASE + SIO_GPIO_OE_SET, 1 shl gpio);
	mov	r2,#1
	lsl	r2,r0
	ldr	r1,.Lj12
	mov	r0,r2
	str	r0,[r1]
.Ll16:
# [98] end;
	add	r13,r13,#48
	pop	{r15}
	.balign 4
.Lj12:
	.long	-805306332
.Lt17:
.Le3:
	.size	CYW43_LL_$$_GPIO_SET_OUTPUT$LONGWORD, .Le3 - CYW43_LL_$$_GPIO_SET_OUTPUT$LONGWORD
.Ll17:

.section .text.n_cyw43_ll_$$_gpio_set_input$longword
	.balign 4
.thumb_func 
CYW43_LL_$$_GPIO_SET_INPUT$LONGWORD:
.Ll18:
# [102] begin
	push	{r14}
	sub	r13,r13,#48
# Var gpio located in register r0
.Ll19:
# [103] reg_write(SIO_BASE + SIO_GPIO_OE_CLR, 1 shl gpio);
	mov	r2,#1
	lsl	r2,r0
	ldr	r1,.Lj15
	mov	r0,r2
	str	r0,[r1]
.Ll20:
# [104] end;
	add	r13,r13,#48
	pop	{r15}
	.balign 4
.Lj15:
	.long	-805306328
.Lt18:
.Le4:
	.size	CYW43_LL_$$_GPIO_SET_INPUT$LONGWORD, .Le4 - CYW43_LL_$$_GPIO_SET_INPUT$LONGWORD
.Ll21:

.section .text.n_cyw43_ll_$$_gpio_set_high$longword
	.balign 4
.thumb_func 
CYW43_LL_$$_GPIO_SET_HIGH$LONGWORD:
.Ll22:
# [108] begin
	push	{r14}
	sub	r13,r13,#48
# Var gpio located in register r0
.Ll23:
# [109] reg_write(SIO_BASE + SIO_GPIO_OUT_SET, 1 shl gpio);
	mov	r2,#1
	lsl	r2,r0
	ldr	r1,.Lj18
	mov	r0,r2
	str	r0,[r1]
.Ll24:
# [110] end;
	add	r13,r13,#48
	pop	{r15}
	.balign 4
.Lj18:
	.long	-805306348
.Lt19:
.Le5:
	.size	CYW43_LL_$$_GPIO_SET_HIGH$LONGWORD, .Le5 - CYW43_LL_$$_GPIO_SET_HIGH$LONGWORD
.Ll25:

.section .text.n_cyw43_ll_$$_gpio_set_low$longword
	.balign 4
.thumb_func 
CYW43_LL_$$_GPIO_SET_LOW$LONGWORD:
.Ll26:
# [114] begin
	push	{r14}
	sub	r13,r13,#48
# Var gpio located in register r0
.Ll27:
# [115] reg_write(SIO_BASE + SIO_GPIO_OUT_CLR, 1 shl gpio);
	mov	r2,#1
	lsl	r2,r0
	ldr	r1,.Lj21
	mov	r0,r2
	str	r0,[r1]
.Ll28:
# [116] end;
	add	r13,r13,#48
	pop	{r15}
	.balign 4
.Lj21:
	.long	-805306344
.Lt20:
.Le6:
	.size	CYW43_LL_$$_GPIO_SET_LOW$LONGWORD, .Le6 - CYW43_LL_$$_GPIO_SET_LOW$LONGWORD
.Ll29:

.section .text.n_cyw43_ll_$$_gpio_get$longword$$boolean
	.balign 4
.thumb_func 
CYW43_LL_$$_GPIO_GET$LONGWORD$$BOOLEAN:
.Ll30:
# [120] begin
	push	{r14}
	sub	r13,r13,#48
# Var $result located in register r0
# Var gpio located in register r0
.Ll31:
# [121] Result := (reg_read(SIO_BASE + SIO_GPIO_IN) and (1 shl gpio)) <> 0;
	ldr	r1,.Lj24
	ldr	r1,[r1]
	mov	r2,#1
	lsl	r2,r0
	and	r2,r1
	cmp	r2,#0
# Var $result located in register r0
	bne	.Lj25
	mov	r0,#0
	b	.Lj26
.Lj25:
	mov	r0,#1
.Lj26:
.Ll32:
# [122] end;
	add	r13,r13,#48
	pop	{r15}
	.balign 4
.Lj24:
	.long	-805306364
.Lt21:
.Le7:
	.size	CYW43_LL_$$_GPIO_GET$LONGWORD$$BOOLEAN, .Le7 - CYW43_LL_$$_GPIO_GET$LONGWORD$$BOOLEAN
.Ll33:

.section .text.n_cyw43_ll_$$_cyw43_delay_us$longword
	.balign 4
.thumb_func 
.globl	CYW43_LL_$$_CYW43_DELAY_US$LONGWORD
CYW43_LL_$$_CYW43_DELAY_US$LONGWORD:
.Ll34:
# [128] begin
	push	{r4,r14}
	sub	r13,r13,#48
# Var us located at r13+0, size=OS_32
# Var i located at r13+4, size=OS_32
	str	r0,[r13]
.Ll35:
# [131] for i := 1 to us * 12 do
	mov	r1,#12
	mul	r0,r1
	mov	r4,r0
	cmp	r4,#1
	bcc	.Lj31
	bl	.Lj29
.Lj31:
	bl	.Lj30
.Lj29:
	mov	r0,#0
	str	r0,[r13, #4]
	.balign 4
.Lj32:
	ldr	r0,[r13, #4]
	add	r0,#1
	str	r0,[r13, #4]
#  CPU ARMV6M
.Ll36:
# [132] asm nop end;
	nop
#  CPU ARMV6M
.Ll37:
	ldr	r0,[r13, #4]
	cmp	r0,r4
	bcc	.Lj35
	bl	.Lj34
.Lj35:
	bl	.Lj32
.Lj34:
.Lj30:
.Ll38:
# [133] end;
	add	r13,r13,#48
	pop	{r4,r15}
.Lt5:
.Le8:
	.size	CYW43_LL_$$_CYW43_DELAY_US$LONGWORD, .Le8 - CYW43_LL_$$_CYW43_DELAY_US$LONGWORD
.Ll39:

.section .text.n_cyw43_ll_$$_cyw43_delay_ms$longword
	.balign 4
.thumb_func 
.globl	CYW43_LL_$$_CYW43_DELAY_MS$LONGWORD
CYW43_LL_$$_CYW43_DELAY_MS$LONGWORD:
.Ll40:
# [138] begin
	push	{r4,r5,r14}
	sub	r13,r13,#48
# Var i located in register r4
# Var ms located in register r0
# Var ms located in register r0
.Ll41:
# [139] for i := 1 to ms do
	mov	r5,r0
	cmp	r5,#1
	bcc	.Lj40
	bl	.Lj38
.Lj40:
	bl	.Lj39
.Lj38:
	mov	r4,#0
	.balign 4
.Lj41:
	mov	r0,r4
	add	r0,#1
	mov	r4,r0
.Ll42:
# [140] cyw43_delay_us(1000);
	ldr	r0,.Lj44
	bl	CYW43_LL_$$_CYW43_DELAY_US$LONGWORD
.Ll43:
	cmp	r4,r5
	bcc	.Lj45
	bl	.Lj43
.Lj45:
	bl	.Lj41
.Lj43:
.Lj39:
.Ll44:
# [141] end;
	add	r13,r13,#48
	pop	{r4,r5,r15}
	.balign 4
.Lj44:
	.long	1000
.Lt6:
.Le9:
	.size	CYW43_LL_$$_CYW43_DELAY_MS$LONGWORD, .Le9 - CYW43_LL_$$_CYW43_DELAY_MS$LONGWORD
.Ll45:

.section .text.n_cyw43_ll_$$_cyw43_power_init
	.balign 4
.thumb_func 
.globl	CYW43_LL_$$_CYW43_POWER_INIT
CYW43_LL_$$_CYW43_POWER_INIT:
.Ll46:
# [145] begin
	push	{r14}
	sub	r13,r13,#32
.Ll47:
# [147] gpio_set_function(CYW43_PIN_WL_REG_ON, GPIO_FUNC_SIO);
	mov	r1,#5
	mov	r0,#23
	bl	CYW43_LL_$$_GPIO_SET_FUNCTION$LONGWORD$LONGWORD
.Ll48:
# [148] gpio_set_low(CYW43_PIN_WL_REG_ON);
	mov	r0,#23
	bl	CYW43_LL_$$_GPIO_SET_LOW$LONGWORD
.Ll49:
# [149] gpio_set_output(CYW43_PIN_WL_REG_ON);
	mov	r0,#23
	bl	CYW43_LL_$$_GPIO_SET_OUTPUT$LONGWORD
.Ll50:
# [152] gpio_set_function(CYW43_PIN_WL_CS, GPIO_FUNC_SIO);
	mov	r1,#5
	mov	r0,#25
	bl	CYW43_LL_$$_GPIO_SET_FUNCTION$LONGWORD$LONGWORD
.Ll51:
# [153] gpio_set_high(CYW43_PIN_WL_CS);
	mov	r0,#25
	bl	CYW43_LL_$$_GPIO_SET_HIGH$LONGWORD
.Ll52:
# [154] gpio_set_output(CYW43_PIN_WL_CS);
	mov	r0,#25
	bl	CYW43_LL_$$_GPIO_SET_OUTPUT$LONGWORD
.Ll53:
# [157] gpio_set_function(CYW43_PIN_WL_CLK, GPIO_FUNC_SIO);
	mov	r1,#5
	mov	r0,#29
	bl	CYW43_LL_$$_GPIO_SET_FUNCTION$LONGWORD$LONGWORD
.Ll54:
# [158] gpio_set_low(CYW43_PIN_WL_CLK);
	mov	r0,#29
	bl	CYW43_LL_$$_GPIO_SET_LOW$LONGWORD
.Ll55:
# [159] gpio_set_output(CYW43_PIN_WL_CLK);
	mov	r0,#29
	bl	CYW43_LL_$$_GPIO_SET_OUTPUT$LONGWORD
.Ll56:
# [162] gpio_set_function(CYW43_PIN_WL_DATA, GPIO_FUNC_SIO);
	mov	r1,#5
	mov	r0,#24
	bl	CYW43_LL_$$_GPIO_SET_FUNCTION$LONGWORD$LONGWORD
.Ll57:
# [163] gpio_set_low(CYW43_PIN_WL_DATA);
	mov	r0,#24
	bl	CYW43_LL_$$_GPIO_SET_LOW$LONGWORD
.Ll58:
# [164] gpio_set_output(CYW43_PIN_WL_DATA);
	mov	r0,#24
	bl	CYW43_LL_$$_GPIO_SET_OUTPUT$LONGWORD
.Ll59:
# [165] end;
	add	r13,r13,#32
	pop	{r15}
.Lt1:
.Le10:
	.size	CYW43_LL_$$_CYW43_POWER_INIT, .Le10 - CYW43_LL_$$_CYW43_POWER_INIT
.Ll60:

.section .text.n_cyw43_ll_$$_cyw43_power_on
	.balign 4
.thumb_func 
.globl	CYW43_LL_$$_CYW43_POWER_ON
CYW43_LL_$$_CYW43_POWER_ON:
.Ll61:
# [169] begin
	push	{r14}
	sub	r13,r13,#32
.Ll62:
# [170] gpio_set_high(CYW43_PIN_WL_REG_ON);
	mov	r0,#23
	bl	CYW43_LL_$$_GPIO_SET_HIGH$LONGWORD
.Ll63:
# [172] cyw43_delay_ms(5);
	mov	r0,#5
	bl	CYW43_LL_$$_CYW43_DELAY_MS$LONGWORD
.Ll64:
# [173] end;
	add	r13,r13,#32
	pop	{r15}
.Lt2:
.Le11:
	.size	CYW43_LL_$$_CYW43_POWER_ON, .Le11 - CYW43_LL_$$_CYW43_POWER_ON
.Ll65:

.section .text.n_cyw43_ll_$$_cyw43_power_off
	.balign 4
.thumb_func 
.globl	CYW43_LL_$$_CYW43_POWER_OFF
CYW43_LL_$$_CYW43_POWER_OFF:
.Ll66:
# [177] begin
	push	{r14}
	sub	r13,r13,#32
.Ll67:
# [178] gpio_set_low(CYW43_PIN_WL_REG_ON);
	mov	r0,#23
	bl	CYW43_LL_$$_GPIO_SET_LOW$LONGWORD
.Ll68:
# [179] cyw43_delay_ms(1);
	mov	r0,#1
	bl	CYW43_LL_$$_CYW43_DELAY_MS$LONGWORD
.Ll69:
# [180] end;
	add	r13,r13,#32
	pop	{r15}
.Lt3:
.Le12:
	.size	CYW43_LL_$$_CYW43_POWER_OFF, .Le12 - CYW43_LL_$$_CYW43_POWER_OFF
.Ll70:

.section .text.n_cyw43_ll_$$_cyw43_is_powered$$boolean
	.balign 4
.thumb_func 
.globl	CYW43_LL_$$_CYW43_IS_POWERED$$BOOLEAN
CYW43_LL_$$_CYW43_IS_POWERED$$BOOLEAN:
.Ll71:
# [184] begin
	push	{r14}
	sub	r13,r13,#40
# Var $result located in register r0
.Ll72:
# [186] Result := gpio_get(CYW43_PIN_WL_REG_ON);
	mov	r0,#23
	bl	CYW43_LL_$$_GPIO_GET$LONGWORD$$BOOLEAN
# Var $result located in register r0
.Ll73:
# [187] end;
	add	r13,r13,#40
	pop	{r15}
.Lt4:
.Le13:
	.size	CYW43_LL_$$_CYW43_IS_POWERED$$BOOLEAN, .Le13 - CYW43_LL_$$_CYW43_IS_POWERED$$BOOLEAN
.Ll74:

.section .text.n_cyw43_ll_$$_spi_cs_low
	.balign 4
.thumb_func 
.globl	CYW43_LL_$$_SPI_CS_LOW
CYW43_LL_$$_SPI_CS_LOW:
.Ll75:
# [195] begin
	push	{r14}
	sub	r13,r13,#32
.Ll76:
# [196] gpio_set_low(CYW43_PIN_WL_CS);
	mov	r0,#25
	bl	CYW43_LL_$$_GPIO_SET_LOW$LONGWORD
.Ll77:
# [197] end;
	add	r13,r13,#32
	pop	{r15}
.Lt7:
.Le14:
	.size	CYW43_LL_$$_SPI_CS_LOW, .Le14 - CYW43_LL_$$_SPI_CS_LOW
.Ll78:

.section .text.n_cyw43_ll_$$_spi_cs_high
	.balign 4
.thumb_func 
.globl	CYW43_LL_$$_SPI_CS_HIGH
CYW43_LL_$$_SPI_CS_HIGH:
.Ll79:
# [201] begin
	push	{r14}
	sub	r13,r13,#32
.Ll80:
# [202] gpio_set_high(CYW43_PIN_WL_CS);
	mov	r0,#25
	bl	CYW43_LL_$$_GPIO_SET_HIGH$LONGWORD
.Ll81:
# [203] end;
	add	r13,r13,#32
	pop	{r15}
.Lt8:
.Le15:
	.size	CYW43_LL_$$_SPI_CS_HIGH, .Le15 - CYW43_LL_$$_SPI_CS_HIGH
.Ll82:

.section .text.n_cyw43_ll_$$_spi_data_output
	.balign 4
.thumb_func 
CYW43_LL_$$_SPI_DATA_OUTPUT:
.Ll83:
# [207] begin
	push	{r14}
	sub	r13,r13,#32
.Ll84:
# [208] gpio_set_output(CYW43_PIN_WL_DATA);
	mov	r0,#24
	bl	CYW43_LL_$$_GPIO_SET_OUTPUT$LONGWORD
.Ll85:
# [209] end;
	add	r13,r13,#32
	pop	{r15}
.Lt22:
.Le16:
	.size	CYW43_LL_$$_SPI_DATA_OUTPUT, .Le16 - CYW43_LL_$$_SPI_DATA_OUTPUT
.Ll86:

.section .text.n_cyw43_ll_$$_spi_data_input
	.balign 4
.thumb_func 
CYW43_LL_$$_SPI_DATA_INPUT:
.Ll87:
# [213] begin
	push	{r14}
	sub	r13,r13,#32
.Ll88:
# [214] gpio_set_input(CYW43_PIN_WL_DATA);
	mov	r0,#24
	bl	CYW43_LL_$$_GPIO_SET_INPUT$LONGWORD
.Ll89:
# [215] end;
	add	r13,r13,#32
	pop	{r15}
.Lt23:
.Le17:
	.size	CYW43_LL_$$_SPI_DATA_INPUT, .Le17 - CYW43_LL_$$_SPI_DATA_INPUT
.Ll90:

.section .text.n_cyw43_ll_$$_spi_write_bit$boolean
	.balign 4
.thumb_func 
CYW43_LL_$$_SPI_WRITE_BIT$BOOLEAN:
.Ll91:
# [219] begin
	push	{r14}
	sub	r13,r13,#40
# Var bit located at r13+0, size=OS_8
	mov	r1,r13
	strb	r0,[r1]
.Ll92:
# [221] if bit then
	mov	r0,r13
	ldrb	r0,[r0]
	cmp	r0,#0
	beq	.Lj66
	bl	.Lj64
.Lj66:
	bl	.Lj65
.Lj64:
.Ll93:
# [222] gpio_set_high(CYW43_PIN_WL_DATA)
	mov	r0,#24
	bl	CYW43_LL_$$_GPIO_SET_HIGH$LONGWORD
	bl	.Lj67
.Lj65:
.Ll94:
# [224] gpio_set_low(CYW43_PIN_WL_DATA);
	mov	r0,#24
	bl	CYW43_LL_$$_GPIO_SET_LOW$LONGWORD
.Lj67:
.Ll95:
# [227] gpio_set_high(CYW43_PIN_WL_CLK);
	mov	r0,#29
	bl	CYW43_LL_$$_GPIO_SET_HIGH$LONGWORD
#  CPU ARMV6M
.Ll96:
# [229] asm nop; nop; nop; nop; end;
	nop
	nop
	nop
	nop
#  CPU ARMV6M
.Ll97:
# [231] gpio_set_low(CYW43_PIN_WL_CLK);
	mov	r0,#29
	bl	CYW43_LL_$$_GPIO_SET_LOW$LONGWORD
#  CPU ARMV6M
.Ll98:
# [232] asm nop; nop; nop; nop; end;
	nop
	nop
	nop
	nop
#  CPU ARMV6M
.Ll99:
# [233] end;
	add	r13,r13,#40
	pop	{r15}
.Lt24:
.Le18:
	.size	CYW43_LL_$$_SPI_WRITE_BIT$BOOLEAN, .Le18 - CYW43_LL_$$_SPI_WRITE_BIT$BOOLEAN
.Ll100:

.section .text.n_cyw43_ll_$$_spi_read_bit$$boolean
	.balign 4
.thumb_func 
CYW43_LL_$$_SPI_READ_BIT$$BOOLEAN:
.Ll101:
# [237] begin
	push	{r14}
	sub	r13,r13,#40
# Var $result located at r13+0, size=OS_8
.Ll102:
# [239] gpio_set_high(CYW43_PIN_WL_CLK);
	mov	r0,#29
	bl	CYW43_LL_$$_GPIO_SET_HIGH$LONGWORD
#  CPU ARMV6M
.Ll103:
# [240] asm nop; nop; nop; nop; end;
	nop
	nop
	nop
	nop
#  CPU ARMV6M
.Ll104:
# [242] Result := gpio_get(CYW43_PIN_WL_DATA);
	mov	r0,#24
	bl	CYW43_LL_$$_GPIO_GET$LONGWORD$$BOOLEAN
	mov	r1,r0
	mov	r0,r13
	strb	r1,[r0]
.Ll105:
# [244] gpio_set_low(CYW43_PIN_WL_CLK);
	mov	r0,#29
	bl	CYW43_LL_$$_GPIO_SET_LOW$LONGWORD
#  CPU ARMV6M
.Ll106:
# [245] asm nop; nop; nop; nop; end;
	nop
	nop
	nop
	nop
#  CPU ARMV6M
.Ll107:
# [246] end;
	mov	r1,r13
	ldrb	r0,[r1]
	add	r13,r13,#40
	pop	{r15}
.Lt25:
.Le19:
	.size	CYW43_LL_$$_SPI_READ_BIT$$BOOLEAN, .Le19 - CYW43_LL_$$_SPI_READ_BIT$$BOOLEAN
.Ll108:

.section .text.n_cyw43_ll_$$_spi_write_byte$byte
	.balign 4
.thumb_func 
.globl	CYW43_LL_$$_SPI_WRITE_BYTE$BYTE
CYW43_LL_$$_SPI_WRITE_BYTE$BYTE:
.Ll109:
# [252] begin
	push	{r4,r5,r14}
	sub	r13,r13,#40
# Var i located in register r0
	mov	r5,r0
# Var b located in register r5
.Ll110:
# [253] spi_data_output;
	bl	CYW43_LL_$$_SPI_DATA_OUTPUT
# Var i located in register r4
.Ll111:
# [254] for i := 7 downto 0 do
	mov	r4,#8
	.balign 4
.Lj72:
	mov	r0,r4
	sub	r0,#1
	mov	r4,r0
.Ll112:
# [255] spi_write_bit((b and (1 shl i)) <> 0);
	mov	r0,#1
	lsl	r0,r4
	mov	r1,r5
	and	r1,r0
	cmp	r1,#0
	bne	.Lj75
	mov	r0,#0
	b	.Lj76
.Lj75:
	mov	r0,#1
.Lj76:
	bl	CYW43_LL_$$_SPI_WRITE_BIT$BOOLEAN
.Ll113:
	cmp	r4,#0
	bgt	.Lj77
	bl	.Lj74
.Lj77:
	bl	.Lj72
.Lj74:
.Ll114:
# [256] end;
	add	r13,r13,#40
	pop	{r4,r5,r15}
.Lt9:
.Le20:
	.size	CYW43_LL_$$_SPI_WRITE_BYTE$BYTE, .Le20 - CYW43_LL_$$_SPI_WRITE_BYTE$BYTE
.Ll115:

.section .text.n_cyw43_ll_$$_spi_read_byte$$byte
	.balign 4
.thumb_func 
.globl	CYW43_LL_$$_SPI_READ_BYTE$$BYTE
CYW43_LL_$$_SPI_READ_BYTE$$BYTE:
.Ll116:
# [262] begin
	push	{r4,r5,r14}
	sub	r13,r13,#40
# Var $result located in register r0
# Var i located in register r0
# Var $result located in register r5
.Ll117:
# [263] Result := 0;
	mov	r5,#0
.Ll118:
# [264] spi_data_input;
	bl	CYW43_LL_$$_SPI_DATA_INPUT
# Var i located in register r4
.Ll119:
# [265] for i := 7 downto 0 do
	mov	r4,#8
	.balign 4
.Lj80:
	mov	r0,r4
	sub	r0,#1
	mov	r4,r0
.Ll120:
# [267] if spi_read_bit then
	bl	CYW43_LL_$$_SPI_READ_BIT$$BOOLEAN
	cmp	r0,#0
	beq	.Lj85
	bl	.Lj83
.Lj85:
	bl	.Lj84
.Lj83:
.Ll121:
# [268] Result := Result or (1 shl i);
	mov	r0,#1
	lsl	r0,r4
	mov	r1,r5
	orr	r1,r0
	uxtb	r5,r1
.Lj84:
.Ll122:
	cmp	r4,#0
	bgt	.Lj86
	bl	.Lj82
.Lj86:
	bl	.Lj80
.Lj82:
.Ll123:
# [270] end;
	mov	r0,r5
	add	r13,r13,#40
	pop	{r4,r5,r15}
.Lt10:
.Le21:
	.size	CYW43_LL_$$_SPI_READ_BYTE$$BYTE, .Le21 - CYW43_LL_$$_SPI_READ_BYTE$$BYTE
.Ll124:

.section .text.n_cyw43_ll_$$_spi_write_word$longword
	.balign 4
.thumb_func 
CYW43_LL_$$_SPI_WRITE_WORD$LONGWORD:
.Ll125:
# [274] begin
	push	{r4,r14}
	sub	r13,r13,#40
	mov	r4,r0
# Var w located in register r4
.Ll126:
# [275] spi_write_byte((w shr 24) and $FF);
	mov	r0,r4
	lsr	r0,r0,#24
	mov	r1,#255
	and	r0,r1
	uxtb	r0,r0
	bl	CYW43_LL_$$_SPI_WRITE_BYTE$BYTE
.Ll127:
# [276] spi_write_byte((w shr 16) and $FF);
	mov	r0,r4
	lsr	r0,r0,#16
	mov	r1,#255
	and	r0,r1
	uxtb	r0,r0
	bl	CYW43_LL_$$_SPI_WRITE_BYTE$BYTE
.Ll128:
# [277] spi_write_byte((w shr 8) and $FF);
	mov	r0,r4
	lsr	r0,r0,#8
	mov	r1,#255
	and	r0,r1
	uxtb	r0,r0
	bl	CYW43_LL_$$_SPI_WRITE_BYTE$BYTE
.Ll129:
# [278] spi_write_byte(w and $FF);
	mov	r0,r4
	mov	r1,#255
	and	r0,r1
	uxtb	r0,r0
	bl	CYW43_LL_$$_SPI_WRITE_BYTE$BYTE
.Ll130:
# [279] end;
	add	r13,r13,#40
	pop	{r4,r15}
.Lt26:
.Le22:
	.size	CYW43_LL_$$_SPI_WRITE_WORD$LONGWORD, .Le22 - CYW43_LL_$$_SPI_WRITE_WORD$LONGWORD
.Ll131:

.section .text.n_cyw43_ll_$$_spi_read_word$$longword
	.balign 4
.thumb_func 
CYW43_LL_$$_SPI_READ_WORD$$LONGWORD:
.Ll132:
# [283] begin
	push	{r4,r14}
	sub	r13,r13,#40
# Var $result located in register r0
.Ll133:
# [284] Result := LongWord(spi_read_byte) shl 24;
	bl	CYW43_LL_$$_SPI_READ_BYTE$$BYTE
	mov	r4,r0
	lsl	r4,r4,#24
# Var $result located in register r4
.Ll134:
# [285] Result := Result or (LongWord(spi_read_byte) shl 16);
	bl	CYW43_LL_$$_SPI_READ_BYTE$$BYTE
	lsl	r0,r0,#16
	orr	r0,r4
# Var $result located in register r4
	mov	r4,r0
.Ll135:
# [286] Result := Result or (LongWord(spi_read_byte) shl 8);
	bl	CYW43_LL_$$_SPI_READ_BYTE$$BYTE
	lsl	r0,r0,#8
	orr	r0,r4
# Var $result located in register r4
	mov	r4,r0
.Ll136:
# [287] Result := Result or spi_read_byte;
	bl	CYW43_LL_$$_SPI_READ_BYTE$$BYTE
	orr	r0,r4
# Var $result located in register r0
.Ll137:
# [288] end;
	add	r13,r13,#40
	pop	{r4,r15}
.Lt27:
.Le23:
	.size	CYW43_LL_$$_SPI_READ_WORD$$LONGWORD, .Le23 - CYW43_LL_$$_SPI_READ_WORD$$LONGWORD
.Ll138:

.section .text.n_cyw43_ll_$$_cyw43_read_reg$longword$$longword
	.balign 4
.thumb_func 
.globl	CYW43_LL_$$_CYW43_READ_REG$LONGWORD$$LONGWORD
CYW43_LL_$$_CYW43_READ_REG$LONGWORD$$LONGWORD:
.Ll139:
# [313] begin
	push	{r4,r14}
	sub	r13,r13,#48
# Var $result located in register r0
# Var cmd located in register r0
# Var addr located in register r0
.Ll140:
# [314] cmd := GSPI_CMD_READ or GSPI_FUNC_BUS or ((addr and $1FFFF) shl 11) or 4;
	ldr	r1,.Lj93
	and	r0,r1
	mov	r4,r0
	lsl	r4,r4,#11
	mov	r0,#4
	orr	r4,r0
# Var cmd located in register r4
.Ll141:
# [316] spi_cs_low;
	bl	CYW43_LL_$$_SPI_CS_LOW
.Ll142:
# [317] spi_write_word(cmd);
	mov	r0,r4
# Var cmd located in register r0
	bl	CYW43_LL_$$_SPI_WRITE_WORD$LONGWORD
.Ll143:
# [319] spi_data_input;
	bl	CYW43_LL_$$_SPI_DATA_INPUT
.Ll144:
# [321] Result := spi_read_word;
	bl	CYW43_LL_$$_SPI_READ_WORD$$LONGWORD
	mov	r4,r0
# Var $result located in register r4
.Ll145:
# [322] spi_cs_high;
	bl	CYW43_LL_$$_SPI_CS_HIGH
.Ll146:
# [323] end;
	mov	r0,r4
	add	r13,r13,#48
	pop	{r4,r15}
	.balign 4
.Lj93:
	.long	131071
.Lt11:
.Le24:
	.size	CYW43_LL_$$_CYW43_READ_REG$LONGWORD$$LONGWORD, .Le24 - CYW43_LL_$$_CYW43_READ_REG$LONGWORD$$LONGWORD
.Ll147:

.section .text.n_cyw43_ll_$$_cyw43_write_reg$longword$longword
	.balign 4
.thumb_func 
.globl	CYW43_LL_$$_CYW43_WRITE_REG$LONGWORD$LONGWORD
CYW43_LL_$$_CYW43_WRITE_REG$LONGWORD$LONGWORD:
.Ll148:
# [329] begin
	push	{r4,r5,r14}
	sub	r13,r13,#48
# Var cmd located in register r0
# Var addr located in register r0
	mov	r5,r1
# Var value located in register r5
.Ll149:
# [330] cmd := GSPI_CMD_WRITE or GSPI_FUNC_BUS or ((addr and $1FFFF) shl 11) or 4;
	ldr	r1,.Lj96
	and	r0,r1
	lsl	r0,r0,#11
	ldr	r1,.Lj97
	orr	r0,r1
	mov	r1,#4
	orr	r0,r1
# Var cmd located in register r4
	mov	r4,r0
.Ll150:
# [332] spi_cs_low;
	bl	CYW43_LL_$$_SPI_CS_LOW
.Ll151:
# [333] spi_write_word(cmd);
	mov	r0,r4
# Var cmd located in register r0
	bl	CYW43_LL_$$_SPI_WRITE_WORD$LONGWORD
.Ll152:
# [334] spi_write_word(value);
	mov	r0,r5
# Var value located in register r0
	bl	CYW43_LL_$$_SPI_WRITE_WORD$LONGWORD
.Ll153:
# [335] spi_cs_high;
	bl	CYW43_LL_$$_SPI_CS_HIGH
.Ll154:
# [336] end;
	add	r13,r13,#48
	pop	{r4,r5,r15}
	.balign 4
.Lj96:
	.long	131071
.Lj97:
	.long	-2147483648
.Lt12:
.Le25:
	.size	CYW43_LL_$$_CYW43_WRITE_REG$LONGWORD$LONGWORD, .Le25 - CYW43_LL_$$_CYW43_WRITE_REG$LONGWORD$LONGWORD
.Ll155:

.section .text.n_cyw43_ll_$$_cyw43_get_chip_id$$longword
	.balign 4
.thumb_func 
.globl	CYW43_LL_$$_CYW43_GET_CHIP_ID$$LONGWORD
CYW43_LL_$$_CYW43_GET_CHIP_ID$$LONGWORD:
.Ll156:
# [342] begin
	push	{r14}
	sub	r13,r13,#40
# Var $result located in register r0
.Ll157:
# [343] Result := cyw43_read_reg(CHIPID_ADDR);
	mov	r0,#20
	bl	CYW43_LL_$$_CYW43_READ_REG$LONGWORD$$LONGWORD
# Var $result located in register r0
.Ll158:
# [344] end;
	add	r13,r13,#40
	pop	{r15}
.Lt13:
.Le26:
	.size	CYW43_LL_$$_CYW43_GET_CHIP_ID$$LONGWORD, .Le26 - CYW43_LL_$$_CYW43_GET_CHIP_ID$$LONGWORD
.Ll159:
# End asmlist al_procedures
# Begin asmlist al_dwarf_info

.section .debug_info
.Ldebug_info0:
	.long	.Ledebug_info0-.Lf2
.Lf2:
	.short	2
	.long	.Ldebug_abbrev0
	.byte	4
	.uleb128	1
# [75] procedure reg_write(addr, value: LongWord); inline;
	.ascii	"../src/wifi/cyw43_ll.pas\000"
	.ascii	"Free Pascal 3.2.2-r0d122c49 2026/04/06\000"
	.ascii	"/Users/herux/Documents/pico-fpc/build-wifi/\000"
	.byte	9
	.byte	3
	.long	.Ldebug_line0
	.long	DEBUGSTART_$CYW43_LL
	.long	DEBUGEND_$CYW43_LL
# Syms - Begin unit CYW43_LL has index 3
# Symbol CYW43_LL
# Symbol SYSTEM
# Symbol OBJPAS
# Symbol CYW43_PIN_WL_REG_ON
	.uleb128	2
	.ascii	"CYW43_PIN_WL_REG_ON\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	23
# Symbol CYW43_PIN_WL_DATA
	.uleb128	2
	.ascii	"CYW43_PIN_WL_DATA\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	24
# Symbol CYW43_PIN_WL_CS
	.uleb128	2
	.ascii	"CYW43_PIN_WL_CS\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	25
# Symbol CYW43_PIN_WL_CLK
	.uleb128	2
	.ascii	"CYW43_PIN_WL_CLK\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	29
# Symbol SIO_BASE
	.uleb128	2
	.ascii	"SIO_BASE\000"
	.long	_$CYW43_LL$_Ld3
	.uleb128	-805306368
# Symbol IO_BANK0_BASE
	.uleb128	2
	.ascii	"IO_BANK0_BASE\000"
	.long	_$CYW43_LL$_Ld5
	.uleb128	1073823744
# Symbol PADS_BANK0_BASE
	.uleb128	2
	.ascii	"PADS_BANK0_BASE\000"
	.long	_$CYW43_LL$_Ld5
	.uleb128	1073856512
# Symbol RESETS_BASE
	.uleb128	2
	.ascii	"RESETS_BASE\000"
	.long	_$CYW43_LL$_Ld5
	.uleb128	1073790976
# Symbol GPIO_FUNC_SIO
	.uleb128	2
	.ascii	"GPIO_FUNC_SIO\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	5
# Symbol GPIO_FUNC_NULL
	.uleb128	2
	.ascii	"GPIO_FUNC_NULL\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	31
# Symbol SIO_GPIO_OUT_SET
	.uleb128	2
	.ascii	"SIO_GPIO_OUT_SET\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	20
# Symbol SIO_GPIO_OUT_CLR
	.uleb128	2
	.ascii	"SIO_GPIO_OUT_CLR\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	24
# Symbol SIO_GPIO_OE_SET
	.uleb128	2
	.ascii	"SIO_GPIO_OE_SET\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	36
# Symbol SIO_GPIO_OE_CLR
	.uleb128	2
	.ascii	"SIO_GPIO_OE_CLR\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	40
# Symbol SIO_GPIO_IN
	.uleb128	2
	.ascii	"SIO_GPIO_IN\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	4
# Symbol CYW43_POWER_INIT
# Symbol CYW43_POWER_ON
# Symbol CYW43_POWER_OFF
# Symbol CYW43_IS_POWERED
# Symbol CYW43_DELAY_US
# Symbol CYW43_DELAY_MS
# Symbol SPI_CS_LOW
# Symbol SPI_CS_HIGH
# Symbol SPI_WRITE_BYTE
# Symbol SPI_READ_BYTE
# Symbol CYW43_READ_REG
# Symbol CYW43_WRITE_REG
# Symbol CYW43_GET_CHIP_ID
# Syms - End unit CYW43_LL has index 3
# Syms - Begin Staticsymtable
# Symbol CYW43_LL_$$_init$
# Symbol REG_WRITE
# Symbol REG_READ
# Symbol GPIO_SET_FUNCTION
# Symbol GPIO_SET_OUTPUT
# Symbol GPIO_SET_INPUT
# Symbol GPIO_SET_HIGH
# Symbol GPIO_SET_LOW
# Symbol GPIO_GET
# Symbol SPI_DATA_OUTPUT
# Symbol SPI_DATA_INPUT
# Symbol SPI_WRITE_BIT
# Symbol SPI_READ_BIT
# Symbol SPI_WRITE_WORD
# Symbol SPI_READ_WORD
# Symbol GSPI_CMD_WRITE
	.uleb128	2
	.ascii	"GSPI_CMD_WRITE\000"
	.long	_$CYW43_LL$_Ld3
	.uleb128	-2147483648
# Symbol GSPI_CMD_READ
	.uleb128	2
	.ascii	"GSPI_CMD_READ\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	0
# Symbol GSPI_CMD_INCR_ADDR
	.uleb128	2
	.ascii	"GSPI_CMD_INCR_ADDR\000"
	.long	_$CYW43_LL$_Ld5
	.uleb128	1073741824
# Symbol GSPI_FUNC_BUS
	.uleb128	2
	.ascii	"GSPI_FUNC_BUS\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	0
# Symbol GSPI_FUNC_WLAN
	.uleb128	2
	.ascii	"GSPI_FUNC_WLAN\000"
	.long	_$CYW43_LL$_Ld5
	.uleb128	268435456
# Symbol GSPI_FUNC_BT
	.uleb128	2
	.ascii	"GSPI_FUNC_BT\000"
	.long	_$CYW43_LL$_Ld5
	.uleb128	536870912
# Syms - End Staticsymtable
# Procdef cyw43_power_init;
	.uleb128	3
	.ascii	"CYW43_POWER_INIT\000"
	.byte	1
	.byte	1
	.long	CYW43_LL_$$_CYW43_POWER_INIT
	.long	.Lt1
	.byte	0
# Procdef cyw43_power_on;
	.uleb128	3
	.ascii	"CYW43_POWER_ON\000"
	.byte	1
	.byte	1
	.long	CYW43_LL_$$_CYW43_POWER_ON
	.long	.Lt2
	.byte	0
# Procdef cyw43_power_off;
	.uleb128	3
	.ascii	"CYW43_POWER_OFF\000"
	.byte	1
	.byte	1
	.long	CYW43_LL_$$_CYW43_POWER_OFF
	.long	.Lt3
	.byte	0
# Procdef cyw43_is_powered:Boolean;
	.uleb128	4
	.ascii	"CYW43_IS_POWERED\000"
	.byte	1
	.byte	1
	.long	_$CYW43_LL$_Ld7
	.long	CYW43_LL_$$_CYW43_IS_POWERED$$BOOLEAN
	.long	.Lt4
# Symbol result
	.uleb128	5
	.ascii	"result\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld7
# Symbol CYW43_IS_POWERED
	.uleb128	5
	.ascii	"CYW43_IS_POWERED\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld7
# Symbol RESULT
	.uleb128	5
	.ascii	"RESULT\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld7
	.byte	0
# Procdef cyw43_delay_us(LongWord);
	.uleb128	3
	.ascii	"CYW43_DELAY_US\000"
	.byte	1
	.byte	1
	.long	CYW43_LL_$$_CYW43_DELAY_US$LONGWORD
	.long	.Lt5
# Symbol US
	.uleb128	6
	.ascii	"US\000"
	.byte	2
	.byte	125
	.sleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol I
	.uleb128	5
	.ascii	"I\000"
	.byte	2
	.byte	125
	.sleb128	4
	.long	_$CYW43_LL$_Ld3
	.byte	0
# Procdef cyw43_delay_ms(LongWord);
	.uleb128	3
	.ascii	"CYW43_DELAY_MS\000"
	.byte	1
	.byte	1
	.long	CYW43_LL_$$_CYW43_DELAY_MS$LONGWORD
	.long	.Lt6
# Symbol MS
	.uleb128	6
	.ascii	"MS\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol I
	.uleb128	5
	.ascii	"I\000"
	.byte	2
	.byte	144
	.uleb128	4
	.long	_$CYW43_LL$_Ld3
	.byte	0
# Procdef spi_cs_low;
	.uleb128	3
	.ascii	"SPI_CS_LOW\000"
	.byte	1
	.byte	1
	.long	CYW43_LL_$$_SPI_CS_LOW
	.long	.Lt7
	.byte	0
# Procdef spi_cs_high;
	.uleb128	3
	.ascii	"SPI_CS_HIGH\000"
	.byte	1
	.byte	1
	.long	CYW43_LL_$$_SPI_CS_HIGH
	.long	.Lt8
	.byte	0
# Procdef spi_write_byte(Byte);
	.uleb128	3
	.ascii	"SPI_WRITE_BYTE\000"
	.byte	1
	.byte	1
	.long	CYW43_LL_$$_SPI_WRITE_BYTE$BYTE
	.long	.Lt9
# Symbol B
	.uleb128	6
	.ascii	"B\000"
	.byte	2
	.byte	144
	.uleb128	5
	.long	_$CYW43_LL$_Ld9
# Symbol I
	.uleb128	5
	.ascii	"I\000"
	.byte	2
	.byte	144
	.uleb128	4
	.long	_$CYW43_LL$_Ld5
	.byte	0
# Procdef spi_read_byte:Byte;
	.uleb128	4
	.ascii	"SPI_READ_BYTE\000"
	.byte	1
	.byte	1
	.long	_$CYW43_LL$_Ld9
	.long	CYW43_LL_$$_SPI_READ_BYTE$$BYTE
	.long	.Lt10
# Symbol result
	.uleb128	5
	.ascii	"result\000"
	.byte	2
	.byte	144
	.uleb128	5
	.long	_$CYW43_LL$_Ld9
# Symbol SPI_READ_BYTE
	.uleb128	5
	.ascii	"SPI_READ_BYTE\000"
	.byte	2
	.byte	144
	.uleb128	5
	.long	_$CYW43_LL$_Ld9
# Symbol RESULT
	.uleb128	5
	.ascii	"RESULT\000"
	.byte	2
	.byte	144
	.uleb128	5
	.long	_$CYW43_LL$_Ld9
# Symbol I
	.uleb128	5
	.ascii	"I\000"
	.byte	2
	.byte	144
	.uleb128	4
	.long	_$CYW43_LL$_Ld5
	.byte	0
# Procdef cyw43_read_reg(LongWord):DWord;
	.uleb128	4
	.ascii	"CYW43_READ_REG\000"
	.byte	1
	.byte	1
	.long	_$CYW43_LL$_Ld3
	.long	CYW43_LL_$$_CYW43_READ_REG$LONGWORD$$LONGWORD
	.long	.Lt11
# Symbol ADDR
	.uleb128	6
	.ascii	"ADDR\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol result
	.uleb128	5
	.ascii	"result\000"
	.byte	2
	.byte	144
	.uleb128	4
	.long	_$CYW43_LL$_Ld3
# Symbol CYW43_READ_REG
	.uleb128	5
	.ascii	"CYW43_READ_REG\000"
	.byte	2
	.byte	144
	.uleb128	4
	.long	_$CYW43_LL$_Ld3
# Symbol RESULT
	.uleb128	5
	.ascii	"RESULT\000"
	.byte	2
	.byte	144
	.uleb128	4
	.long	_$CYW43_LL$_Ld3
# Symbol CMD
	.uleb128	5
	.ascii	"CMD\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
	.byte	0
# Procdef cyw43_write_reg(LongWord;LongWord);
	.uleb128	3
	.ascii	"CYW43_WRITE_REG\000"
	.byte	1
	.byte	1
	.long	CYW43_LL_$$_CYW43_WRITE_REG$LONGWORD$LONGWORD
	.long	.Lt12
# Symbol ADDR
	.uleb128	6
	.ascii	"ADDR\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol VALUE
	.uleb128	6
	.ascii	"VALUE\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol CMD
	.uleb128	5
	.ascii	"CMD\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
	.byte	0
# Procdef cyw43_get_chip_id:DWord;
	.uleb128	4
	.ascii	"CYW43_GET_CHIP_ID\000"
	.byte	1
	.byte	1
	.long	_$CYW43_LL$_Ld3
	.long	CYW43_LL_$$_CYW43_GET_CHIP_ID$$LONGWORD
	.long	.Lt13
# Symbol result
	.uleb128	5
	.ascii	"result\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol CYW43_GET_CHIP_ID
	.uleb128	5
	.ascii	"CYW43_GET_CHIP_ID\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol RESULT
	.uleb128	5
	.ascii	"RESULT\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol CHIPID_ADDR
	.uleb128	2
	.ascii	"CHIPID_ADDR\000"
	.long	_$CYW43_LL$_Ld1
	.uleb128	20
	.byte	0
# Procdef reg_write(LongWord;LongWord);
	.uleb128	7
	.ascii	"REG_WRITE\000"
	.byte	1
	.long	CYW43_LL_$$_REG_WRITE$LONGWORD$LONGWORD
	.long	.Lt14
# Symbol ADDR
	.uleb128	6
	.ascii	"ADDR\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol VALUE
	.uleb128	6
	.ascii	"VALUE\000"
	.byte	2
	.byte	144
	.uleb128	1
	.long	_$CYW43_LL$_Ld3
	.byte	0
# Procdef reg_read(LongWord):DWord;
	.uleb128	8
	.ascii	"REG_READ\000"
	.byte	1
	.long	_$CYW43_LL$_Ld3
	.long	CYW43_LL_$$_REG_READ$LONGWORD$$LONGWORD
	.long	.Lt15
# Symbol ADDR
	.uleb128	6
	.ascii	"ADDR\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol result
	.uleb128	5
	.ascii	"result\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol REG_READ
	.uleb128	5
	.ascii	"REG_READ\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol RESULT
	.uleb128	5
	.ascii	"RESULT\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
	.byte	0
# Procdef gpio_set_function(LongWord;LongWord);
	.uleb128	7
	.ascii	"GPIO_SET_FUNCTION\000"
	.byte	1
	.long	CYW43_LL_$$_GPIO_SET_FUNCTION$LONGWORD$LONGWORD
	.long	.Lt16
# Symbol GPIO
	.uleb128	6
	.ascii	"GPIO\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol FUNC
	.uleb128	6
	.ascii	"FUNC\000"
	.byte	2
	.byte	144
	.uleb128	1
	.long	_$CYW43_LL$_Ld3
# Symbol CTRL_ADDR
	.uleb128	5
	.ascii	"CTRL_ADDR\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
	.byte	0
# Procdef gpio_set_output(LongWord);
	.uleb128	7
	.ascii	"GPIO_SET_OUTPUT\000"
	.byte	1
	.long	CYW43_LL_$$_GPIO_SET_OUTPUT$LONGWORD
	.long	.Lt17
# Symbol GPIO
	.uleb128	6
	.ascii	"GPIO\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
	.byte	0
# Procdef gpio_set_input(LongWord);
	.uleb128	7
	.ascii	"GPIO_SET_INPUT\000"
	.byte	1
	.long	CYW43_LL_$$_GPIO_SET_INPUT$LONGWORD
	.long	.Lt18
# Symbol GPIO
	.uleb128	6
	.ascii	"GPIO\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
	.byte	0
# Procdef gpio_set_high(LongWord);
	.uleb128	7
	.ascii	"GPIO_SET_HIGH\000"
	.byte	1
	.long	CYW43_LL_$$_GPIO_SET_HIGH$LONGWORD
	.long	.Lt19
# Symbol GPIO
	.uleb128	6
	.ascii	"GPIO\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
	.byte	0
# Procdef gpio_set_low(LongWord);
	.uleb128	7
	.ascii	"GPIO_SET_LOW\000"
	.byte	1
	.long	CYW43_LL_$$_GPIO_SET_LOW$LONGWORD
	.long	.Lt20
# Symbol GPIO
	.uleb128	6
	.ascii	"GPIO\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
	.byte	0
# Procdef gpio_get(LongWord):Boolean;
	.uleb128	8
	.ascii	"GPIO_GET\000"
	.byte	1
	.long	_$CYW43_LL$_Ld7
	.long	CYW43_LL_$$_GPIO_GET$LONGWORD$$BOOLEAN
	.long	.Lt21
# Symbol GPIO
	.uleb128	6
	.ascii	"GPIO\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol result
	.uleb128	5
	.ascii	"result\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld7
# Symbol GPIO_GET
	.uleb128	5
	.ascii	"GPIO_GET\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld7
# Symbol RESULT
	.uleb128	5
	.ascii	"RESULT\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld7
	.byte	0
# Procdef spi_data_output;
	.uleb128	7
	.ascii	"SPI_DATA_OUTPUT\000"
	.byte	1
	.long	CYW43_LL_$$_SPI_DATA_OUTPUT
	.long	.Lt22
	.byte	0
# Procdef spi_data_input;
	.uleb128	7
	.ascii	"SPI_DATA_INPUT\000"
	.byte	1
	.long	CYW43_LL_$$_SPI_DATA_INPUT
	.long	.Lt23
	.byte	0
# Procdef spi_write_bit(Boolean);
	.uleb128	7
	.ascii	"SPI_WRITE_BIT\000"
	.byte	1
	.long	CYW43_LL_$$_SPI_WRITE_BIT$BOOLEAN
	.long	.Lt24
# Symbol BIT
	.uleb128	6
	.ascii	"BIT\000"
	.byte	2
	.byte	125
	.sleb128	0
	.long	_$CYW43_LL$_Ld7
	.byte	0
# Procdef spi_read_bit:Boolean;
	.uleb128	8
	.ascii	"SPI_READ_BIT\000"
	.byte	1
	.long	_$CYW43_LL$_Ld7
	.long	CYW43_LL_$$_SPI_READ_BIT$$BOOLEAN
	.long	.Lt25
# Symbol result
	.uleb128	5
	.ascii	"result\000"
	.byte	2
	.byte	125
	.sleb128	0
	.long	_$CYW43_LL$_Ld7
# Symbol SPI_READ_BIT
	.uleb128	5
	.ascii	"SPI_READ_BIT\000"
	.byte	2
	.byte	125
	.sleb128	0
	.long	_$CYW43_LL$_Ld7
# Symbol RESULT
	.uleb128	5
	.ascii	"RESULT\000"
	.byte	2
	.byte	125
	.sleb128	0
	.long	_$CYW43_LL$_Ld7
	.byte	0
# Procdef spi_write_word(LongWord);
	.uleb128	7
	.ascii	"SPI_WRITE_WORD\000"
	.byte	1
	.long	CYW43_LL_$$_SPI_WRITE_WORD$LONGWORD
	.long	.Lt26
# Symbol W
	.uleb128	6
	.ascii	"W\000"
	.byte	2
	.byte	144
	.uleb128	4
	.long	_$CYW43_LL$_Ld3
	.byte	0
# Procdef spi_read_word:DWord;
	.uleb128	8
	.ascii	"SPI_READ_WORD\000"
	.byte	1
	.long	_$CYW43_LL$_Ld3
	.long	CYW43_LL_$$_SPI_READ_WORD$$LONGWORD
	.long	.Lt27
# Symbol result
	.uleb128	5
	.ascii	"result\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol SPI_READ_WORD
	.uleb128	5
	.ascii	"SPI_READ_WORD\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
# Symbol RESULT
	.uleb128	5
	.ascii	"RESULT\000"
	.byte	2
	.byte	144
	.uleb128	0
	.long	_$CYW43_LL$_Ld3
	.byte	0
# Defs - Begin unit SYSTEM has index 1
# Definition Byte
.globl	_$CYW43_LL$_Ld9
_$CYW43_LL$_Ld9:
	.uleb128	9
	.ascii	"BYTE\000"
	.long	.La1
.La1:
	.uleb128	10
	.ascii	"BYTE\000"
	.byte	7
	.byte	1
.globl	_$CYW43_LL$_Ld10
_$CYW43_LL$_Ld10:
	.uleb128	11
	.long	_$CYW43_LL$_Ld9
# Definition ShortInt
.globl	_$CYW43_LL$_Ld1
_$CYW43_LL$_Ld1:
	.uleb128	9
	.ascii	"SHORTINT\000"
	.long	.La2
.La2:
	.uleb128	10
	.ascii	"SHORTINT\000"
	.byte	5
	.byte	1
.globl	_$CYW43_LL$_Ld2
_$CYW43_LL$_Ld2:
	.uleb128	11
	.long	_$CYW43_LL$_Ld1
# Definition LongWord
.globl	_$CYW43_LL$_Ld3
_$CYW43_LL$_Ld3:
	.uleb128	9
	.ascii	"LONGWORD\000"
	.long	.La3
.La3:
	.uleb128	10
	.ascii	"LONGWORD\000"
	.byte	7
	.byte	4
.globl	_$CYW43_LL$_Ld4
_$CYW43_LL$_Ld4:
	.uleb128	11
	.long	_$CYW43_LL$_Ld3
# Definition LongInt
.globl	_$CYW43_LL$_Ld5
_$CYW43_LL$_Ld5:
	.uleb128	9
	.ascii	"LONGINT\000"
	.long	.La4
.La4:
	.uleb128	10
	.ascii	"LONGINT\000"
	.byte	5
	.byte	4
.globl	_$CYW43_LL$_Ld6
_$CYW43_LL$_Ld6:
	.uleb128	11
	.long	_$CYW43_LL$_Ld5
# Definition Boolean
.globl	_$CYW43_LL$_Ld7
_$CYW43_LL$_Ld7:
	.uleb128	9
	.ascii	"BOOLEAN\000"
	.long	.La5
.La5:
	.uleb128	10
	.ascii	"Boolean\000"
	.byte	2
	.byte	1
.globl	_$CYW43_LL$_Ld8
_$CYW43_LL$_Ld8:
	.uleb128	11
	.long	_$CYW43_LL$_Ld7
# Defs - End unit SYSTEM has index 1
# Defs - Begin unit OBJPAS has index 2
# Defs - End unit OBJPAS has index 2
# Defs - Begin unit CYW43_LL has index 3
# Defs - End unit CYW43_LL has index 3
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
	.uleb128	46
	.byte	1
	.uleb128	3
	.uleb128	8
	.uleb128	39
	.uleb128	12
	.uleb128	63
	.uleb128	12
	.uleb128	73
	.uleb128	16
	.uleb128	17
	.uleb128	1
	.uleb128	18
	.uleb128	1
	.byte	0
	.byte	0
# Abbrev 5
	.uleb128	5
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
	.uleb128	17
	.uleb128	1
	.uleb128	18
	.uleb128	1
	.byte	0
	.byte	0
# Abbrev 8
	.uleb128	8
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
# Abbrev 9
	.uleb128	9
	.uleb128	22
	.byte	0
	.uleb128	3
	.uleb128	8
	.uleb128	73
	.uleb128	16
	.byte	0
	.byte	0
# Abbrev 10
	.uleb128	10
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
# Abbrev 11
	.uleb128	11
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
# [347] 
	.ascii	"../src/wifi\000"
	.byte	0
# file_names
	.ascii	"cyw43_ll.pas\000"
	.uleb128	1
	.uleb128	0
	.uleb128	0
	.byte	0
.Lehdebug_line0:
# === header end ===
# function: CYW43_LL_$$_REG_WRITE$LONGWORD$LONGWORD
# [76:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll1
	.byte	5
	.uleb128	1
	.byte	87
# [77:3]
	.byte	2
	.uleb128	.Ll2-.Ll1
	.byte	5
	.uleb128	3
	.byte	13
# [78:1]
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
# function: CYW43_LL_$$_REG_READ$LONGWORD$$LONGWORD
# [81:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll5
	.byte	5
	.uleb128	1
	.byte	92
# [82:3]
	.byte	2
	.uleb128	.Ll6-.Ll5
	.byte	5
	.uleb128	3
	.byte	13
# [83:1]
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
# function: CYW43_LL_$$_GPIO_SET_FUNCTION$LONGWORD$LONGWORD
# [89:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll9
	.byte	5
	.uleb128	1
	.byte	100
# [90:32]
	.byte	2
	.uleb128	.Ll10-.Ll9
	.byte	5
	.uleb128	32
	.byte	13
# [91:3]
	.byte	2
	.uleb128	.Ll11-.Ll10
	.byte	5
	.uleb128	3
	.byte	13
# [92:1]
	.byte	2
	.uleb128	.Ll12-.Ll11
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll13
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_GPIO_SET_OUTPUT$LONGWORD
# [96:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll14
	.byte	5
	.uleb128	1
	.byte	107
# [97:51]
	.byte	2
	.uleb128	.Ll15-.Ll14
	.byte	5
	.uleb128	51
	.byte	13
# [98:1]
	.byte	2
	.uleb128	.Ll16-.Ll15
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll17
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_GPIO_SET_INPUT$LONGWORD
# [102:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll18
	.byte	5
	.uleb128	1
	.byte	113
# [103:51]
	.byte	2
	.uleb128	.Ll19-.Ll18
	.byte	5
	.uleb128	51
	.byte	13
# [104:1]
	.byte	2
	.uleb128	.Ll20-.Ll19
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll21
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_GPIO_SET_HIGH$LONGWORD
# [108:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll22
	.byte	5
	.uleb128	1
	.byte	119
# [109:52]
	.byte	2
	.uleb128	.Ll23-.Ll22
	.byte	5
	.uleb128	52
	.byte	13
# [110:1]
	.byte	2
	.uleb128	.Ll24-.Ll23
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll25
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_GPIO_SET_LOW$LONGWORD
# [114:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll26
	.byte	5
	.uleb128	1
	.byte	125
# [115:52]
	.byte	2
	.uleb128	.Ll27-.Ll26
	.byte	5
	.uleb128	52
	.byte	13
# [116:1]
	.byte	2
	.uleb128	.Ll28-.Ll27
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll29
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_GPIO_GET$LONGWORD$$BOOLEAN
# [120:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll30
	.byte	5
	.uleb128	1
	.byte	131
# [121:14]
	.byte	2
	.uleb128	.Ll31-.Ll30
	.byte	5
	.uleb128	14
	.byte	13
# [122:1]
	.byte	2
	.uleb128	.Ll32-.Ll31
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll33
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_CYW43_DELAY_US$LONGWORD
# [128:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll34
	.byte	5
	.uleb128	1
	.byte	139
# [131:20]
	.byte	2
	.uleb128	.Ll35-.Ll34
	.byte	5
	.uleb128	20
	.byte	15
# [132:9]
	.byte	2
	.uleb128	.Ll36-.Ll35
	.byte	5
	.uleb128	9
	.byte	13
# [131:3]
	.byte	2
	.uleb128	.Ll37-.Ll36
	.byte	5
	.uleb128	3
	.byte	3
	.sleb128	-1
	.byte	1
# [133:1]
	.byte	2
	.uleb128	.Ll38-.Ll37
	.byte	5
	.uleb128	1
	.byte	14
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll39
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_CYW43_DELAY_MS$LONGWORD
# [138:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll40
	.byte	5
	.uleb128	1
	.byte	149
# [139:3]
	.byte	2
	.uleb128	.Ll41-.Ll40
	.byte	5
	.uleb128	3
	.byte	13
# [140:5]
	.byte	2
	.uleb128	.Ll42-.Ll41
	.byte	5
	.uleb128	5
	.byte	13
# [139:3]
	.byte	2
	.uleb128	.Ll43-.Ll42
	.byte	5
	.uleb128	3
	.byte	3
	.sleb128	-1
	.byte	1
# [141:1]
	.byte	2
	.uleb128	.Ll44-.Ll43
	.byte	5
	.uleb128	1
	.byte	14
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll45
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_CYW43_POWER_INIT
# [145:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll46
	.byte	5
	.uleb128	1
	.byte	156
# [147:3]
	.byte	2
	.uleb128	.Ll47-.Ll46
	.byte	5
	.uleb128	3
	.byte	14
# [148:3]
	.byte	2
	.uleb128	.Ll48-.Ll47
	.byte	13
# [149:3]
	.byte	2
	.uleb128	.Ll49-.Ll48
	.byte	13
# [152:3]
	.byte	2
	.uleb128	.Ll50-.Ll49
	.byte	15
# [153:3]
	.byte	2
	.uleb128	.Ll51-.Ll50
	.byte	13
# [154:3]
	.byte	2
	.uleb128	.Ll52-.Ll51
	.byte	13
# [157:3]
	.byte	2
	.uleb128	.Ll53-.Ll52
	.byte	15
# [158:3]
	.byte	2
	.uleb128	.Ll54-.Ll53
	.byte	13
# [159:3]
	.byte	2
	.uleb128	.Ll55-.Ll54
	.byte	13
# [162:3]
	.byte	2
	.uleb128	.Ll56-.Ll55
	.byte	15
# [163:3]
	.byte	2
	.uleb128	.Ll57-.Ll56
	.byte	13
# [164:3]
	.byte	2
	.uleb128	.Ll58-.Ll57
	.byte	13
# [165:1]
	.byte	2
	.uleb128	.Ll59-.Ll58
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll60
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_CYW43_POWER_ON
# [169:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll61
	.byte	5
	.uleb128	1
	.byte	180
# [170:3]
	.byte	2
	.uleb128	.Ll62-.Ll61
	.byte	5
	.uleb128	3
	.byte	13
# [172:3]
	.byte	2
	.uleb128	.Ll63-.Ll62
	.byte	14
# [173:1]
	.byte	2
	.uleb128	.Ll64-.Ll63
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll65
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_CYW43_POWER_OFF
# [177:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll66
	.byte	5
	.uleb128	1
	.byte	188
# [178:3]
	.byte	2
	.uleb128	.Ll67-.Ll66
	.byte	5
	.uleb128	3
	.byte	13
# [179:3]
	.byte	2
	.uleb128	.Ll68-.Ll67
	.byte	13
# [180:1]
	.byte	2
	.uleb128	.Ll69-.Ll68
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll70
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_CYW43_IS_POWERED$$BOOLEAN
# [184:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll71
	.byte	5
	.uleb128	1
	.byte	195
# [186:13]
	.byte	2
	.uleb128	.Ll72-.Ll71
	.byte	5
	.uleb128	13
	.byte	14
# [187:1]
	.byte	2
	.uleb128	.Ll73-.Ll72
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll74
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_SPI_CS_LOW
# [195:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll75
	.byte	5
	.uleb128	1
	.byte	206
# [196:3]
	.byte	2
	.uleb128	.Ll76-.Ll75
	.byte	5
	.uleb128	3
	.byte	13
# [197:1]
	.byte	2
	.uleb128	.Ll77-.Ll76
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll78
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_SPI_CS_HIGH
# [201:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll79
	.byte	5
	.uleb128	1
	.byte	212
# [202:3]
	.byte	2
	.uleb128	.Ll80-.Ll79
	.byte	5
	.uleb128	3
	.byte	13
# [203:1]
	.byte	2
	.uleb128	.Ll81-.Ll80
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll82
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_SPI_DATA_OUTPUT
# [207:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll83
	.byte	5
	.uleb128	1
	.byte	218
# [208:3]
	.byte	2
	.uleb128	.Ll84-.Ll83
	.byte	5
	.uleb128	3
	.byte	13
# [209:1]
	.byte	2
	.uleb128	.Ll85-.Ll84
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll86
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_SPI_DATA_INPUT
# [213:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll87
	.byte	5
	.uleb128	1
	.byte	224
# [214:3]
	.byte	2
	.uleb128	.Ll88-.Ll87
	.byte	5
	.uleb128	3
	.byte	13
# [215:1]
	.byte	2
	.uleb128	.Ll89-.Ll88
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll90
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_SPI_WRITE_BIT$BOOLEAN
# [219:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll91
	.byte	5
	.uleb128	1
	.byte	230
# [221:6]
	.byte	2
	.uleb128	.Ll92-.Ll91
	.byte	5
	.uleb128	6
	.byte	14
# [222:5]
	.byte	2
	.uleb128	.Ll93-.Ll92
	.byte	5
	.uleb128	5
	.byte	13
# [224:5]
	.byte	2
	.uleb128	.Ll94-.Ll93
	.byte	14
# [227:3]
	.byte	2
	.uleb128	.Ll95-.Ll94
	.byte	5
	.uleb128	3
	.byte	15
# [229:7]
	.byte	2
	.uleb128	.Ll96-.Ll95
	.byte	5
	.uleb128	7
	.byte	14
# [231:3]
	.byte	2
	.uleb128	.Ll97-.Ll96
	.byte	5
	.uleb128	3
	.byte	14
# [232:7]
	.byte	2
	.uleb128	.Ll98-.Ll97
	.byte	5
	.uleb128	7
	.byte	13
# [233:1]
	.byte	2
	.uleb128	.Ll99-.Ll98
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll100
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_SPI_READ_BIT$$BOOLEAN
# [237:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll101
	.byte	5
	.uleb128	1
	.byte	248
# [239:3]
	.byte	2
	.uleb128	.Ll102-.Ll101
	.byte	5
	.uleb128	3
	.byte	14
# [240:7]
	.byte	2
	.uleb128	.Ll103-.Ll102
	.byte	5
	.uleb128	7
	.byte	13
# [242:13]
	.byte	2
	.uleb128	.Ll104-.Ll103
	.byte	5
	.uleb128	13
	.byte	14
# [244:3]
	.byte	2
	.uleb128	.Ll105-.Ll104
	.byte	5
	.uleb128	3
	.byte	14
# [245:7]
	.byte	2
	.uleb128	.Ll106-.Ll105
	.byte	5
	.uleb128	7
	.byte	13
# [246:1]
	.byte	2
	.uleb128	.Ll107-.Ll106
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll108
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_SPI_WRITE_BYTE$BYTE
# [252:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll109
	.byte	5
	.uleb128	1
	.byte	3
	.sleb128	251
	.byte	1
# [253:3]
	.byte	2
	.uleb128	.Ll110-.Ll109
	.byte	5
	.uleb128	3
	.byte	13
# [254:3]
	.byte	2
	.uleb128	.Ll111-.Ll110
	.byte	13
# [255:26]
	.byte	2
	.uleb128	.Ll112-.Ll111
	.byte	5
	.uleb128	26
	.byte	13
# [254:3]
	.byte	2
	.uleb128	.Ll113-.Ll112
	.byte	5
	.uleb128	3
	.byte	3
	.sleb128	-1
	.byte	1
# [256:1]
	.byte	2
	.uleb128	.Ll114-.Ll113
	.byte	5
	.uleb128	1
	.byte	14
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll115
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_SPI_READ_BYTE$$BYTE
# [262:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll116
	.byte	5
	.uleb128	1
	.byte	3
	.sleb128	261
	.byte	1
# [263:3]
	.byte	2
	.uleb128	.Ll117-.Ll116
	.byte	5
	.uleb128	3
	.byte	13
# [264:3]
	.byte	2
	.uleb128	.Ll118-.Ll117
	.byte	13
# [265:3]
	.byte	2
	.uleb128	.Ll119-.Ll118
	.byte	13
# [267:8]
	.byte	2
	.uleb128	.Ll120-.Ll119
	.byte	5
	.uleb128	8
	.byte	14
# [268:27]
	.byte	2
	.uleb128	.Ll121-.Ll120
	.byte	5
	.uleb128	27
	.byte	13
# [265:3]
	.byte	2
	.uleb128	.Ll122-.Ll121
	.byte	5
	.uleb128	3
	.byte	3
	.sleb128	-3
	.byte	1
# [270:1]
	.byte	2
	.uleb128	.Ll123-.Ll122
	.byte	5
	.uleb128	1
	.byte	17
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll124
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_SPI_WRITE_WORD$LONGWORD
# [274:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll125
	.byte	5
	.uleb128	1
	.byte	3
	.sleb128	273
	.byte	1
# [275:18]
	.byte	2
	.uleb128	.Ll126-.Ll125
	.byte	5
	.uleb128	18
	.byte	13
# [276:18]
	.byte	2
	.uleb128	.Ll127-.Ll126
	.byte	13
# [277:18]
	.byte	2
	.uleb128	.Ll128-.Ll127
	.byte	13
# [278:27]
	.byte	2
	.uleb128	.Ll129-.Ll128
	.byte	5
	.uleb128	27
	.byte	13
# [279:1]
	.byte	2
	.uleb128	.Ll130-.Ll129
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll131
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_SPI_READ_WORD$$LONGWORD
# [283:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll132
	.byte	5
	.uleb128	1
	.byte	3
	.sleb128	282
	.byte	1
# [284:22]
	.byte	2
	.uleb128	.Ll133-.Ll132
	.byte	5
	.uleb128	22
	.byte	13
# [285:33]
	.byte	2
	.uleb128	.Ll134-.Ll133
	.byte	5
	.uleb128	33
	.byte	13
# [286:33]
	.byte	2
	.uleb128	.Ll135-.Ll134
	.byte	13
# [287:23]
	.byte	2
	.uleb128	.Ll136-.Ll135
	.byte	5
	.uleb128	23
	.byte	13
# [288:1]
	.byte	2
	.uleb128	.Ll137-.Ll136
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll138
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_CYW43_READ_REG$LONGWORD$$LONGWORD
# [313:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll139
	.byte	5
	.uleb128	1
	.byte	3
	.sleb128	312
	.byte	1
# [314:45]
	.byte	2
	.uleb128	.Ll140-.Ll139
	.byte	5
	.uleb128	45
	.byte	13
# [316:3]
	.byte	2
	.uleb128	.Ll141-.Ll140
	.byte	5
	.uleb128	3
	.byte	14
# [317:3]
	.byte	2
	.uleb128	.Ll142-.Ll141
	.byte	13
# [319:3]
	.byte	2
	.uleb128	.Ll143-.Ll142
	.byte	14
# [321:13]
	.byte	2
	.uleb128	.Ll144-.Ll143
	.byte	5
	.uleb128	13
	.byte	14
# [322:3]
	.byte	2
	.uleb128	.Ll145-.Ll144
	.byte	5
	.uleb128	3
	.byte	13
# [323:1]
	.byte	2
	.uleb128	.Ll146-.Ll145
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll147
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_CYW43_WRITE_REG$LONGWORD$LONGWORD
# [329:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll148
	.byte	5
	.uleb128	1
	.byte	3
	.sleb128	328
	.byte	1
# [330:46]
	.byte	2
	.uleb128	.Ll149-.Ll148
	.byte	5
	.uleb128	46
	.byte	13
# [332:3]
	.byte	2
	.uleb128	.Ll150-.Ll149
	.byte	5
	.uleb128	3
	.byte	14
# [333:3]
	.byte	2
	.uleb128	.Ll151-.Ll150
	.byte	13
# [334:3]
	.byte	2
	.uleb128	.Ll152-.Ll151
	.byte	13
# [335:3]
	.byte	2
	.uleb128	.Ll153-.Ll152
	.byte	13
# [336:1]
	.byte	2
	.uleb128	.Ll154-.Ll153
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll155
	.byte	0
	.byte	1
	.byte	1
# ###################
# function: CYW43_LL_$$_CYW43_GET_CHIP_ID$$LONGWORD
# [342:1]
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll156
	.byte	5
	.uleb128	1
	.byte	3
	.sleb128	341
	.byte	1
# [343:13]
	.byte	2
	.uleb128	.Ll157-.Ll156
	.byte	5
	.uleb128	13
	.byte	13
# [344:1]
	.byte	2
	.uleb128	.Ll158-.Ll157
	.byte	5
	.uleb128	1
	.byte	13
	.byte	0
	.uleb128	5
	.byte	2
	.long	.Ll159
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
	.long	CYW43_LL_$$_CYW43_POWER_INIT
	.long	.Lt1-CYW43_LL_$$_CYW43_POWER_INIT
	.long	CYW43_LL_$$_CYW43_POWER_ON
	.long	.Lt2-CYW43_LL_$$_CYW43_POWER_ON
	.long	CYW43_LL_$$_CYW43_POWER_OFF
	.long	.Lt3-CYW43_LL_$$_CYW43_POWER_OFF
	.long	CYW43_LL_$$_CYW43_IS_POWERED$$BOOLEAN
	.long	.Lt4-CYW43_LL_$$_CYW43_IS_POWERED$$BOOLEAN
	.long	CYW43_LL_$$_CYW43_DELAY_US$LONGWORD
	.long	.Lt5-CYW43_LL_$$_CYW43_DELAY_US$LONGWORD
	.long	CYW43_LL_$$_CYW43_DELAY_MS$LONGWORD
	.long	.Lt6-CYW43_LL_$$_CYW43_DELAY_MS$LONGWORD
	.long	CYW43_LL_$$_SPI_CS_LOW
	.long	.Lt7-CYW43_LL_$$_SPI_CS_LOW
	.long	CYW43_LL_$$_SPI_CS_HIGH
	.long	.Lt8-CYW43_LL_$$_SPI_CS_HIGH
	.long	CYW43_LL_$$_SPI_WRITE_BYTE$BYTE
	.long	.Lt9-CYW43_LL_$$_SPI_WRITE_BYTE$BYTE
	.long	CYW43_LL_$$_SPI_READ_BYTE$$BYTE
	.long	.Lt10-CYW43_LL_$$_SPI_READ_BYTE$$BYTE
	.long	CYW43_LL_$$_CYW43_READ_REG$LONGWORD$$LONGWORD
	.long	.Lt11-CYW43_LL_$$_CYW43_READ_REG$LONGWORD$$LONGWORD
	.long	CYW43_LL_$$_CYW43_WRITE_REG$LONGWORD$LONGWORD
	.long	.Lt12-CYW43_LL_$$_CYW43_WRITE_REG$LONGWORD$LONGWORD
	.long	CYW43_LL_$$_CYW43_GET_CHIP_ID$$LONGWORD
	.long	.Lt13-CYW43_LL_$$_CYW43_GET_CHIP_ID$$LONGWORD
	.long	CYW43_LL_$$_REG_WRITE$LONGWORD$LONGWORD
	.long	.Lt14-CYW43_LL_$$_REG_WRITE$LONGWORD$LONGWORD
	.long	CYW43_LL_$$_REG_READ$LONGWORD$$LONGWORD
	.long	.Lt15-CYW43_LL_$$_REG_READ$LONGWORD$$LONGWORD
	.long	CYW43_LL_$$_GPIO_SET_FUNCTION$LONGWORD$LONGWORD
	.long	.Lt16-CYW43_LL_$$_GPIO_SET_FUNCTION$LONGWORD$LONGWORD
	.long	CYW43_LL_$$_GPIO_SET_OUTPUT$LONGWORD
	.long	.Lt17-CYW43_LL_$$_GPIO_SET_OUTPUT$LONGWORD
	.long	CYW43_LL_$$_GPIO_SET_INPUT$LONGWORD
	.long	.Lt18-CYW43_LL_$$_GPIO_SET_INPUT$LONGWORD
	.long	CYW43_LL_$$_GPIO_SET_HIGH$LONGWORD
	.long	.Lt19-CYW43_LL_$$_GPIO_SET_HIGH$LONGWORD
	.long	CYW43_LL_$$_GPIO_SET_LOW$LONGWORD
	.long	.Lt20-CYW43_LL_$$_GPIO_SET_LOW$LONGWORD
	.long	CYW43_LL_$$_GPIO_GET$LONGWORD$$BOOLEAN
	.long	.Lt21-CYW43_LL_$$_GPIO_GET$LONGWORD$$BOOLEAN
	.long	CYW43_LL_$$_SPI_DATA_OUTPUT
	.long	.Lt22-CYW43_LL_$$_SPI_DATA_OUTPUT
	.long	CYW43_LL_$$_SPI_DATA_INPUT
	.long	.Lt23-CYW43_LL_$$_SPI_DATA_INPUT
	.long	CYW43_LL_$$_SPI_WRITE_BIT$BOOLEAN
	.long	.Lt24-CYW43_LL_$$_SPI_WRITE_BIT$BOOLEAN
	.long	CYW43_LL_$$_SPI_READ_BIT$$BOOLEAN
	.long	.Lt25-CYW43_LL_$$_SPI_READ_BIT$$BOOLEAN
	.long	CYW43_LL_$$_SPI_WRITE_WORD$LONGWORD
	.long	.Lt26-CYW43_LL_$$_SPI_WRITE_WORD$LONGWORD
	.long	CYW43_LL_$$_SPI_READ_WORD$$LONGWORD
	.long	.Lt27-CYW43_LL_$$_SPI_READ_WORD$$LONGWORD
	.long	0
	.long	0
.Learanges0:
# End asmlist al_dwarf_aranges
# Begin asmlist al_dwarf_ranges

.section .debug_ranges
# End asmlist al_dwarf_ranges
# Begin asmlist al_end

.section .text.z_DEBUGEND_$CYW43_LL
.globl	DEBUGEND_$CYW43_LL
DEBUGEND_$CYW43_LL:
# End asmlist al_end

