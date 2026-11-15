	.file	"optimized.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.type	parse_size, @function
parse_size:
.LFB15:
	.cfi_startproc
	movzx	eax, BYTE PTR [rdi]
	test	al, al
	je	.L7
	cmp	al, 45
	je	.L7
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	push	rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	mov	rbp, rsi
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	mov	rbx, rdi
	sub	rsp, 16
	.cfi_def_cfa_offset 48
	call	__errno_location@PLT
	xor	r9d, r9d
	lea	rsi, 8[rsp]
	mov	rdi, rbx
	mov	DWORD PTR [rax], r9d
	mov	r12, rax
	mov	edx, 10
	call	strtoull@PLT
	cmp	DWORD PTR [r12], 0
	jne	.L5
	mov	rdx, QWORD PTR 8[rsp]
	cmp	BYTE PTR [rdx], 0
	jne	.L5
	mov	QWORD PTR 0[rbp], rax
	mov	eax, 1
.L1:
	add	rsp, 16
	.cfi_def_cfa_offset 32
	pop	rbx
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
.L7:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	xor	eax, eax
	ret
.L5:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	xor	eax, eax
	jmp	.L1
	.cfi_endproc
.LFE15:
	.size	parse_size, .-parse_size
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"clock_gettime"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4
	.type	now_seconds, @function
now_seconds:
.LFB14:
	.cfi_startproc
	sub	rsp, 24
	.cfi_def_cfa_offset 32
	mov	edi, 1
	mov	rsi, rsp
	call	clock_gettime@PLT
	test	eax, eax
	jne	.L12
	pxor	xmm0, xmm0
	pxor	xmm1, xmm1
	cvtsi2sd	xmm0, QWORD PTR 8[rsp]
	mulsd	xmm0, QWORD PTR .LC1[rip]
	cvtsi2sd	xmm1, QWORD PTR [rsp]
	add	rsp, 24
	.cfi_def_cfa_offset 8
	addsd	xmm0, xmm1
	ret
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	now_seconds.cold, @function
now_seconds.cold:
.LFSB14:
.L12:
	.cfi_def_cfa_offset 32
	lea	rdi, .LC0[rip]
	call	perror@PLT
	mov	edi, 1
	call	exit@PLT
	.cfi_endproc
.LFE14:
	.text
	.size	now_seconds, .-now_seconds
	.section	.text.unlikely
	.size	now_seconds.cold, .-now_seconds.cold
.LCOLDE2:
	.text
.LHOTE2:
	.p2align 4
	.globl	search
	.type	search, @function
search:
.LFB20:
	.cfi_startproc
	mov	rax, QWORD PTR 16[rdi]
	test	rax, rax
	je	.L14
	mov	rdx, QWORD PTR 8[rdi]
	sal	rax, 5
	lea	rdi, [rax+rdx]
	xor	eax, eax
	.p2align 4
	.p2align 3
.L18:
	mov	ecx, DWORD PTR 24[rdx]
	test	ecx, ecx
	je	.L16
	mov	ecx, DWORD PTR 20[rdx]
	cmp	ecx, DWORD PTR 24[rsi]
	jl	.L16
	cmp	ecx, DWORD PTR 28[rsi]
	jle	.L24
	.p2align 4
	.p2align 3
.L16:
	add	rdx, 32
	cmp	rdi, rdx
	jne	.L18
.L14:
	ret
	.p2align 4,,10
	.p2align 3
.L24:
	movsd	xmm0, QWORD PTR [rdx]
	movsd	xmm1, QWORD PTR 8[rdx]
	subsd	xmm0, QWORD PTR [rsi]
	subsd	xmm1, QWORD PTR 8[rsi]
	mulsd	xmm0, xmm0
	mulsd	xmm1, xmm1
	addsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR 16[rsi]
	sqrtsd	xmm0, xmm0
	comisd	xmm1, xmm0
	sbb	rax, -1
	jmp	.L16
	.cfi_endproc
.LFE20:
	.size	search, .-search
	.section	.rodata.str1.1
.LC3:
	.string	","
.LC4:
	.string	""
.LC5:
	.string	"--self-test"
.LC21:
	.string	"edge test failed\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC22:
	.string	"PASS: empty data, zero radius, inclusive radius and skill boundaries, unavailable and no-match cases"
	.align 8
.LC23:
	.string	"Usage: %s [profiles [queries [repeats [--counts]]]] | --self-test\n"
	.section	.rodata.str1.1
.LC24:
	.string	"--counts"
.LC25:
	.string	"queries"
.LC28:
	.string	"Profile allocation failed\n"
.LC29:
	.string	"optimized"
	.section	.rodata.str1.8
	.align 8
.LC30:
	.string	"{\"version\":\"%s\",\"profiles\":%zu,\"queries\":%zu,\"repeats\":%zu,\"setup_seconds\":%.9f,\"search_seconds\":%.9f,\"checksum\":%lu,\"profile_bytes\":%zu,\"profile_allocations\":%zu"
	.section	.rodata.str1.1
.LC31:
	.string	",\"counts\":["
.LC32:
	.string	"%s%zu"
.LC33:
	.string	"}"
	.section	.text.unlikely
.LCOLDB35:
	.section	.text.startup,"ax",@progbits
.LHOTB35:
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB17:
	.cfi_startproc
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rsi
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	ebx, edi
	sub	rsp, 520
	.cfi_def_cfa_offset 576
	mov	QWORD PTR 56[rsp], 100000
	mov	QWORD PTR 64[rsp], 200
	mov	QWORD PTR 72[rsp], 1
	cmp	edi, 2
	je	.L96
	cmp	edi, 5
	jg	.L39
	cmp	edi, 1
	jg	.L97
.L38:
	mov	r14, QWORD PTR 72[rsp]
	mov	ebp, 200
.L58:
	mov	r15, QWORD PTR 56[rsp]
	mov	eax, 4294967295
	cmp	rax, r15
	jb	.L39
	movabs	rax, 576460752303423487
	cmp	rax, rbp
	jb	.L39
	mov	rax, r14
	mul	rbp
	mov	rcx, rax
	seto	al
	movzx	eax, al
	mov	QWORD PTR 8[rsp], rax
	jo	.L39
	test	r15, r15
	je	.L43
	mov	rax, rcx
	mul	r15
	jo	.L39
.L43:
	cmp	ebx, 5
	jne	.L46
	mov	rdi, QWORD PTR 32[r12]
	lea	rsi, .LC24[rip]
	call	strcmp@PLT
	test	eax, eax
	jne	.L39
.L46:
	mov	rdi, rbp
	sal	rdi, 5
	call	malloc@PLT
	mov	QWORD PTR [rsp], rax
	test	rax, rax
	je	.L93
	movsd	xmm1, QWORD PTR .LC17[rip]
	mov	rsi, QWORD PTR [rsp]
	xor	r8d, r8d
	mov	ecx, 987654321
	movsd	xmm2, QWORD PTR .LC27[rip]
	mov	edi, 100001
	mov	r11d, 125
	mov	r9d, 25
	unpcklpd	xmm1, xmm1
.L48:
	imul	eax, ecx, 1664525
	xor	edx, edx
	add	r8, 1
	add	rsi, 32
	add	eax, 1013904223
	imul	ecx, eax, 1664525
	div	edi
	add	ecx, 1013904223
	mov	eax, ecx
	imul	ecx, ecx, 1664525
	add	ecx, 1013904223
	mov	r10d, edx
	xor	edx, edx
	div	edi
	movd	xmm0, r10d
	mov	eax, ecx
	imul	ecx, ecx, 1664525
	add	ecx, 1013904223
	movd	xmm3, edx
	xor	edx, edx
	punpckldq	xmm0, xmm3
	cvtdq2pd	xmm0, xmm0
	divpd	xmm0, xmm1
	div	r11d
	mov	eax, ecx
	movups	XMMWORD PTR -32[rsi], xmm0
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, edx
	xor	edx, edx
	div	r9d
	addsd	xmm0, xmm2
	movsd	QWORD PTR -16[rsi], xmm0
	mov	DWORD PTR -8[rsi], edx
	add	edx, 10
	mov	DWORD PTR -4[rsi], edx
	cmp	r8, rbp
	jb	.L48
	call	now_seconds
	mov	ecx, 6
	xor	eax, eax
	xor	r12d, r12d
	lea	r13, 320[rsp]
	movsd	QWORD PTR 16[rsp], xmm0
	mov	rdi, r13
	rep stosd
	mov	rdi, r15
	sal	rdi, 5
	mov	QWORD PTR 24[rsp], rdi
	test	r15, r15
	je	.L49
	call	malloc@PLT
	mov	r12, rax
	test	rax, rax
	je	.L50
	mov	QWORD PTR 32[rsp], rbp
	mov	r9, rax
	xor	r11d, r11d
	mov	ecx, 123456789
	movapd	xmm1, XMMWORD PTR .LC26[rip]
	mov	esi, 100001
	mov	r10d, 36
.L51:
	imul	eax, ecx, 1664525
	xor	edx, edx
	mov	DWORD PTR 16[r9], r11d
	add	r11, 1
	add	r9, 32
	add	eax, 1013904223
	imul	r8d, eax, 1664525
	div	esi
	add	r8d, 1013904223
	mov	eax, r8d
	imul	edi, r8d, 1664525
	add	edi, 1013904223
	imul	ecx, edi, 1664525
	add	ecx, 1013904223
	mov	ebp, edx
	xor	edx, edx
	div	esi
	movd	xmm0, ebp
	mov	eax, edi
	movd	xmm4, edx
	xor	edx, edx
	punpckldq	xmm0, xmm4
	cvtdq2pd	xmm0, xmm0
	divpd	xmm0, xmm1
	div	r10d
	mov	eax, ecx
	shr	eax, 16
	and	eax, 1
	mov	DWORD PTR -8[r9], eax
	mov	DWORD PTR -12[r9], edx
	movups	XMMWORD PTR -32[r9], xmm0
	cmp	r15, r11
	jne	.L51
	mov	QWORD PTR 336[rsp], r15
	mov	rbp, QWORD PTR 32[rsp]
.L49:
	call	now_seconds
	subsd	xmm0, QWORD PTR 16[rsp]
	movsd	QWORD PTR 16[rsp], xmm0
	call	now_seconds
	mov	r10, QWORD PTR [rsp]
	xor	r11d, r11d
	xor	r9d, r9d
	movsd	QWORD PTR 32[rsp], xmm0
.L52:
	mov	rsi, r10
	xor	r8d, r8d
	.p2align 4
	.p2align 3
.L53:
	mov	rdi, r13
	mov	QWORD PTR 328[rsp], r12
	add	r8, 1
	call	search
	add	rsi, 32
	add	r9, rax
	cmp	r8, rbp
	jb	.L53
	add	r11, 1
	cmp	r11, r14
	jb	.L52
	mov	QWORD PTR 40[rsp], r9
	call	now_seconds
	xor	eax, eax
	test	r15, r15
	mov	rdx, r15
	setne	al
	movapd	xmm1, xmm0
	mov	r8, r14
	mov	rcx, rbp
	push	rax
	.cfi_def_cfa_offset 584
	lea	rsi, .LC29[rip]
	lea	rdi, .LC30[rip]
	mov	eax, 2
	push	QWORD PTR 32[rsp]
	.cfi_def_cfa_offset 592
	subsd	xmm1, QWORD PTR 48[rsp]
	mov	r9, QWORD PTR 56[rsp]
	movsd	xmm0, QWORD PTR 32[rsp]
	call	printf@PLT
	pop	rax
	.cfi_def_cfa_offset 584
	pop	rdx
	.cfi_def_cfa_offset 576
	cmp	ebx, 5
	je	.L98
.L55:
	lea	rdi, .LC33[rip]
	xor	ebp, ebp
	call	puts@PLT
	mov	rdi, r12
	call	free@PLT
	mov	rdi, QWORD PTR [rsp]
	call	free@PLT
	jmp	.L25
.L97:
	mov	rdi, QWORD PTR 8[r12]
	lea	rsi, 56[rsp]
	call	parse_size
	test	eax, eax
	je	.L39
	mov	rdi, QWORD PTR 16[r12]
	lea	rsi, 64[rsp]
	call	parse_size
	test	eax, eax
	je	.L39
	cmp	ebx, 3
	je	.L40
	mov	rdi, QWORD PTR 24[r12]
	lea	rsi, 72[rsp]
	call	parse_size
	test	eax, eax
	je	.L39
	mov	rbp, QWORD PTR 64[rsp]
	test	rbp, rbp
	jne	.L99
.L39:
	mov	rdx, QWORD PTR [r12]
	mov	rdi, QWORD PTR stderr[rip]
	lea	rsi, .LC23[rip]
	xor	eax, eax
	call	fprintf@PLT
.L36:
	mov	ebp, 1
.L25:
	add	rsp, 520
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	eax, ebp
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.L96:
	.cfi_restore_state
	mov	r13, QWORD PTR 8[rsi]
	lea	rsi, .LC5[rip]
	mov	rdi, r13
	call	strcmp@PLT
	mov	ebp, eax
	test	eax, eax
	je	.L100
	lea	rsi, 56[rsp]
	mov	rdi, r13
	call	parse_size
	test	eax, eax
	jne	.L38
	jmp	.L39
.L99:
	mov	r14, QWORD PTR 72[rsp]
	test	r14, r14
	je	.L39
	jmp	.L58
.L100:
	movapd	xmm1, XMMWORD PTR .LC7[rip]
	pxor	xmm0, xmm0
	xor	ecx, ecx
	xor	esi, esi
	mov	rax, QWORD PTR .LC6[rip]
	mov	rdx, QWORD PTR .LC9[rip]
	mov	DWORD PTR 336[rsp], ecx
	mov	ecx, 6
	movaps	XMMWORD PTR 352[rsp], xmm1
	movaps	XMMWORD PTR 384[rsp], xmm1
	movapd	xmm1, XMMWORD PTR .LC10[rip]
	mov	QWORD PTR 340[rsp], rax
	movaps	XMMWORD PTR 448[rsp], xmm1
	movapd	xmm1, XMMWORD PTR .LC11[rip]
	mov	QWORD PTR 372[rsp], rax
	mov	QWORD PTR 468[rsp], rax
	mov	QWORD PTR 500[rsp], rax
	mov	rax, QWORD PTR .LC13[rip]
	movaps	XMMWORD PTR 480[rsp], xmm1
	movsd	xmm1, QWORD PTR .LC12[rip]
	mov	QWORD PTR 436[rsp], rdx
	mov	QWORD PTR 184[rsp], rax
	mov	QWORD PTR 216[rsp], rax
	movaps	XMMWORD PTR 320[rsp], xmm0
	movaps	XMMWORD PTR 416[rsp], xmm0
	movaps	XMMWORD PTR 160[rsp], xmm0
	movsd	QWORD PTR 176[rsp], xmm1
	movaps	XMMWORD PTR 192[rsp], xmm0
	movaps	XMMWORD PTR 224[rsp], xmm0
	mov	DWORD PTR 368[rsp], 1
	mov	DWORD PTR 400[rsp], 2
	mov	QWORD PTR 404[rsp], 10
	mov	DWORD PTR 432[rsp], 3
	mov	DWORD PTR 464[rsp], 4
	mov	DWORD PTR 496[rsp], 5
	mov	QWORD PTR 208[rsp], 0x000000000
	mov	rbx, QWORD PTR .LC15[rip]
	mov	QWORD PTR 248[rsp], rax
	mov	rax, QWORD PTR .LC16[rip]
	movaps	XMMWORD PTR 256[rsp], xmm0
	mov	QWORD PTR 280[rsp], rax
	mov	rax, QWORD PTR .LC17[rip]
	movaps	XMMWORD PTR 288[rsp], xmm0
	movdqa	xmm0, XMMWORD PTR .LC19[rip]
	mov	QWORD PTR 304[rsp], rax
	mov	rax, QWORD PTR .LC18[rip]
	mov	QWORD PTR 240[rsp], rbx
	lea	rbx, 80[rsp]
	mov	QWORD PTR 312[rsp], rax
	mov	rdi, rbx
	mov	eax, ebp
	rep stosd
	movaps	XMMWORD PTR 112[rsp], xmm0
	movdqa	xmm0, XMMWORD PTR .LC20[rip]
	mov	edi, 192
	mov	QWORD PTR 144[rsp], rsi
	movsd	QWORD PTR 272[rsp], xmm1
	movaps	XMMWORD PTR 128[rsp], xmm0
	call	malloc@PLT
	mov	QWORD PTR 88[rsp], rax
	mov	r9, rax
	test	rax, rax
	je	.L36
	mov	ecx, 48
	mov	rdi, rax
	lea	r10, 112[rsp]
	xor	r8d, r8d
	lea	r12, 160[rsp]
	lea	rsi, 320[rsp]
	mov	QWORD PTR 96[rsp], 6
	rep movsd
	mov	rsi, r12
.L32:
	mov	rdi, rbx
	call	search
	cmp	rax, QWORD PTR [r10+r8*8]
	jne	.L101
	add	r8, 1
	add	rsi, 32
	cmp	r8, 5
	jne	.L32
	mov	rdi, r9
	call	free@PLT
	xor	eax, eax
	mov	ecx, 6
	mov	rdi, rbx
	rep stosd
	mov	rsi, r12
	mov	rdi, rbx
	call	search
	test	rax, rax
	jne	.L36
	lea	rdi, .LC22[rip]
	call	puts@PLT
	jmp	.L25
.L40:
	mov	rbp, QWORD PTR 64[rsp]
	mov	r14d, 1
	test	rbp, rbp
	je	.L39
	jmp	.L58
.L50:
	mov	rdi, QWORD PTR [rsp]
	call	free@PLT
	mov	edx, 26
	mov	rcx, QWORD PTR stderr[rip]
	mov	esi, 1
	lea	rdi, .LC28[rip]
	call	fwrite@PLT
	jmp	.L36
.L101:
	mov	rdi, r9
	call	free@PLT
	mov	edx, 17
	mov	rcx, QWORD PTR stderr[rip]
	mov	esi, 1
	lea	rdi, .LC21[rip]
	call	fwrite@PLT
	jmp	.L36
.L98:
	lea	rdi, .LC31[rip]
	xor	eax, eax
	lea	r14, .LC32[rip]
	call	printf@PLT
	mov	QWORD PTR 16[rsp], r13
	mov	r15, QWORD PTR [rsp]
	lea	rbx, .LC3[rip]
	mov	r13, QWORD PTR 8[rsp]
.L57:
	mov	rsi, r13
	mov	rdi, QWORD PTR 16[rsp]
	mov	QWORD PTR 328[rsp], r12
	sal	rsi, 5
	add	rsi, r15
	call	search
	test	r13, r13
	lea	rsi, .LC4[rip]
	mov	rdi, r14
	cmovne	rsi, rbx
	mov	rdx, rax
	add	r13, 1
	xor	eax, eax
	call	printf@PLT
	cmp	r13, rbp
	jb	.L57
	mov	edi, 93
	call	putchar@PLT
	jmp	.L55
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	main.cold, @function
main.cold:
.LFSB17:
.L93:
	.cfi_def_cfa_offset 576
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	lea	rdi, .LC25[rip]
	call	perror@PLT
	jmp	.L36
	.cfi_endproc
.LFE17:
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE35:
	.section	.text.startup
.LHOTE35:
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	-400107883
	.long	1041313291
	.align 8
.LC6:
	.long	10
	.long	1
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC7:
	.long	0
	.long	1074266112
	.long	0
	.long	1074790400
	.section	.rodata.cst8
	.align 8
.LC9:
	.long	20
	.long	1
	.section	.rodata.cst16
	.align 16
.LC10:
	.long	0
	.long	1075314688
	.long	0
	.long	1075838976
	.align 16
.LC11:
	.long	0
	.long	-1073217536
	.long	0
	.long	-1072693248
	.section	.rodata.cst8
	.align 8
.LC12:
	.long	0
	.long	1075052544
	.align 8
.LC13:
	.long	10
	.long	10
	.align 8
.LC15:
	.long	0
	.long	1076101120
	.align 8
.LC16:
	.long	20
	.long	20
	.set	.LC17,.LC26
	.align 8
.LC18:
	.long	30
	.long	35
	.section	.rodata.cst16
	.align 16
.LC19:
	.quad	3
	.quad	1
	.align 16
.LC20:
	.quad	4
	.quad	1
	.align 16
.LC26:
	.long	0
	.long	1079574528
	.long	0
	.long	1079574528
	.section	.rodata.cst8
	.align 8
.LC27:
	.long	0
	.long	1077477376
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
