	.file	"baseline.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.type	store_free, @function
store_free:
.LFB18:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	sub	rsp, 8
	.cfi_def_cfa_offset 32
	mov	rbx, QWORD PTR [rdi]
	test	rbx, rbx
	je	.L2
	.p2align 4
	.p2align 3
.L3:
	mov	rdi, rbx
	mov	rbx, QWORD PTR 32[rbx]
	call	free@PLT
	test	rbx, rbx
	jne	.L3
.L2:
	pxor	xmm0, xmm0
	mov	QWORD PTR 16[rbp], 0
	movups	XMMWORD PTR 0[rbp], xmm0
	add	rsp, 8
	.cfi_def_cfa_offset 24
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE18:
	.size	store_free, .-store_free
	.p2align 4
	.type	store_create, @function
store_create:
.LFB19:
	.cfi_startproc
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pxor	xmm0, xmm0
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rdi
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rsi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 8
	.cfi_def_cfa_offset 64
	mov	QWORD PTR 16[rdi], 0
	movups	XMMWORD PTR [rdi], xmm0
	test	rsi, rsi
	je	.L11
	mov	r15, rdx
	mov	rbx, rdi
	mov	r12d, 123456789
	xor	r14d, r14d
	jmp	.L16
	.p2align 4,,10
	.p2align 3
.L23:
	mov	rdx, r14
	sal	rdx, 5
	movdqu	xmm0, XMMWORD PTR [r15+rdx]
	movups	XMMWORD PTR [rax], xmm0
	movdqu	xmm0, XMMWORD PTR 16[r15+rdx]
	movups	XMMWORD PTR 16[rax], xmm0
.L15:
	add	r14, 1
	mov	QWORD PTR 32[rax], 0
	mov	QWORD PTR [rbx], rax
	lea	rbx, 32[rax]
	cmp	rbp, r14
	je	.L11
.L16:
	mov	edi, 40
	call	malloc@PLT
	test	rax, rax
	je	.L22
	test	r15, r15
	jne	.L23
	imul	edx, r12d, 1664525
	mov	DWORD PTR 16[rax], r14d
	lea	edi, 1013904223[rdx]
	imul	esi, edi, 1664525
	mov	rdx, rdi
	imul	rdi, rdi, 703680405
	add	esi, 1013904223
	shr	rdi, 46
	imul	ecx, esi, 1664525
	imul	edi, edi, 100001
	add	ecx, 1013904223
	sub	edx, edi
	imul	r12d, ecx, 1664525
	movd	xmm0, edx
	mov	edx, esi
	imul	rdx, rdx, 703680405
	add	r12d, 1013904223
	shr	rdx, 46
	imul	edx, edx, 100001
	sub	esi, edx
	mov	edx, ecx
	imul	rdx, rdx, 954437177
	movd	xmm1, esi
	punpckldq	xmm0, xmm1
	cvtdq2pd	xmm0, xmm0
	divpd	xmm0, XMMWORD PTR .LC0[rip]
	movups	XMMWORD PTR [rax], xmm0
	shr	rdx, 35
	lea	edx, [rdx+rdx*8]
	sal	edx, 2
	sub	ecx, edx
	mov	edx, r12d
	shr	edx, 16
	mov	DWORD PTR 20[rax], ecx
	and	edx, 1
	mov	DWORD PTR 24[rax], edx
	jmp	.L15
	.p2align 4,,10
	.p2align 3
.L11:
	mov	QWORD PTR 16[r13], rbp
	mov	eax, 1
.L10:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
.L22:
	.cfi_restore_state
	mov	rdi, r13
	call	store_free
	xor	eax, eax
	jmp	.L10
	.cfi_endproc
.LFE19:
	.size	store_create, .-store_create
	.p2align 4
	.type	parse_size, @function
parse_size:
.LFB15:
	.cfi_startproc
	movzx	eax, BYTE PTR [rdi]
	test	al, al
	je	.L30
	cmp	al, 45
	je	.L30
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
	jne	.L28
	mov	rdx, QWORD PTR 8[rsp]
	cmp	BYTE PTR [rdx], 0
	jne	.L28
	mov	QWORD PTR 0[rbp], rax
	mov	eax, 1
.L24:
	add	rsp, 16
	.cfi_def_cfa_offset 32
	pop	rbx
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
.L30:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	xor	eax, eax
	ret
.L28:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	xor	eax, eax
	jmp	.L24
	.cfi_endproc
.LFE15:
	.size	parse_size, .-parse_size
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"clock_gettime"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB5:
	.text
.LHOTB5:
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
	jne	.L34
	pxor	xmm0, xmm0
	pxor	xmm1, xmm1
	cvtsi2sd	xmm0, QWORD PTR 8[rsp]
	mulsd	xmm0, QWORD PTR .LC4[rip]
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
.L34:
	.cfi_def_cfa_offset 32
	lea	rdi, .LC3[rip]
	call	perror@PLT
	mov	edi, 1
	call	exit@PLT
	.cfi_endproc
.LFE14:
	.text
	.size	now_seconds, .-now_seconds
	.section	.text.unlikely
	.size	now_seconds.cold, .-now_seconds.cold
.LCOLDE5:
	.text
.LHOTE5:
	.p2align 4
	.globl	search
	.type	search, @function
search:
.LFB20:
	.cfi_startproc
	mov	rax, QWORD PTR [rdi]
	xor	ecx, ecx
	test	rax, rax
	je	.L36
	.p2align 4
	.p2align 3
.L40:
	mov	edx, DWORD PTR 24[rax]
	test	edx, edx
	je	.L38
	mov	edx, DWORD PTR 20[rax]
	cmp	edx, DWORD PTR 24[rsi]
	jl	.L38
	cmp	edx, DWORD PTR 28[rsi]
	jle	.L44
	.p2align 4
	.p2align 3
.L38:
	mov	rax, QWORD PTR 32[rax]
	test	rax, rax
	jne	.L40
.L36:
	mov	rax, rcx
	ret
	.p2align 4,,10
	.p2align 3
.L44:
	movsd	xmm0, QWORD PTR [rax]
	movsd	xmm1, QWORD PTR 8[rax]
	subsd	xmm0, QWORD PTR [rsi]
	subsd	xmm1, QWORD PTR 8[rsi]
	mulsd	xmm0, xmm0
	mulsd	xmm1, xmm1
	addsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR 16[rsi]
	sqrtsd	xmm0, xmm0
	comisd	xmm1, xmm0
	sbb	rcx, -1
	jmp	.L38
	.cfi_endproc
.LFE20:
	.size	search, .-search
	.section	.rodata.str1.1
.LC6:
	.string	","
.LC7:
	.string	""
.LC8:
	.string	"--self-test"
.LC23:
	.string	"edge test failed\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC24:
	.string	"PASS: empty data, zero radius, inclusive radius and skill boundaries, unavailable and no-match cases"
	.align 8
.LC25:
	.string	"Usage: %s [profiles [queries [repeats [--counts]]]] | --self-test\n"
	.section	.rodata.str1.1
.LC26:
	.string	"--counts"
.LC27:
	.string	"queries"
.LC29:
	.string	"Profile allocation failed\n"
.LC30:
	.string	"baseline"
	.section	.rodata.str1.8
	.align 8
.LC31:
	.string	"{\"version\":\"%s\",\"profiles\":%zu,\"queries\":%zu,\"repeats\":%zu,\"setup_seconds\":%.9f,\"search_seconds\":%.9f,\"checksum\":%lu,\"profile_bytes\":%zu,\"profile_allocations\":%zu"
	.section	.rodata.str1.1
.LC32:
	.string	",\"counts\":["
.LC33:
	.string	"%s%zu"
.LC34:
	.string	"}"
	.section	.text.unlikely
.LCOLDB36:
	.section	.text.startup,"ax",@progbits
.LHOTB36:
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
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rsi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	ebx, edi
	sub	rsp, 504
	.cfi_def_cfa_offset 560
	mov	QWORD PTR 40[rsp], 100000
	mov	QWORD PTR 48[rsp], 200
	mov	QWORD PTR 56[rsp], 1
	cmp	edi, 2
	je	.L114
	cmp	edi, 5
	jg	.L59
	cmp	edi, 1
	jg	.L115
.L58:
	mov	r14, QWORD PTR 56[rsp]
	mov	r12d, 200
.L76:
	mov	r15, QWORD PTR 40[rsp]
	mov	eax, 4294967295
	cmp	rax, r15
	jb	.L59
	movabs	rax, 576460752303423487
	cmp	rax, r12
	jb	.L59
	mov	rax, r12
	mul	r14
	mov	rcx, rax
	seto	al
	movzx	eax, al
	mov	QWORD PTR 8[rsp], rax
	jo	.L59
	test	r15, r15
	je	.L63
	mov	rax, rcx
	mul	r15
	jo	.L59
.L63:
	cmp	ebx, 5
	jne	.L66
	mov	rdi, QWORD PTR 32[rbp]
	lea	rsi, .LC26[rip]
	call	strcmp@PLT
	test	eax, eax
	jne	.L59
.L66:
	mov	rdi, r12
	sal	rdi, 5
	call	malloc@PLT
	mov	QWORD PTR [rsp], rax
	test	rax, rax
	je	.L111
	movsd	xmm2, QWORD PTR .LC1[rip]
	mov	rsi, QWORD PTR [rsp]
	xor	r8d, r8d
	mov	ecx, 987654321
	movsd	xmm1, QWORD PTR .LC28[rip]
	mov	edi, 100001
	mov	r10d, 125
	mov	r9d, 25
	unpcklpd	xmm2, xmm2
.L68:
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
	mov	r11d, edx
	xor	edx, edx
	div	edi
	movd	xmm0, r11d
	mov	eax, ecx
	imul	ecx, ecx, 1664525
	add	ecx, 1013904223
	movd	xmm3, edx
	xor	edx, edx
	punpckldq	xmm0, xmm3
	cvtdq2pd	xmm0, xmm0
	divpd	xmm0, xmm2
	div	r10d
	mov	eax, ecx
	movups	XMMWORD PTR -32[rsi], xmm0
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, edx
	xor	edx, edx
	div	r9d
	addsd	xmm0, xmm1
	movsd	QWORD PTR -16[rsi], xmm0
	mov	DWORD PTR -8[rsi], edx
	add	edx, 10
	mov	DWORD PTR -4[rsi], edx
	cmp	r8, r12
	jb	.L68
	xor	eax, eax
	lea	rdi, 304[rsp]
	mov	ecx, 6
	rep stosd
	lea	r13, 304[rsp]
	call	now_seconds
	xor	edx, edx
	mov	rsi, r15
	mov	rdi, r13
	movsd	QWORD PTR 16[rsp], xmm0
	call	store_create
	test	eax, eax
	je	.L116
	call	now_seconds
	subsd	xmm0, QWORD PTR 16[rsp]
	xor	ebp, ebp
	movsd	QWORD PTR 16[rsp], xmm0
	call	now_seconds
	xor	r9d, r9d
	movsd	QWORD PTR 24[rsp], xmm0
.L70:
	mov	rsi, QWORD PTR [rsp]
	xor	r8d, r8d
	.p2align 4
	.p2align 3
.L71:
	mov	rdi, r13
	add	r8, 1
	call	search
	add	rsi, 32
	add	rbp, rax
	cmp	r8, r12
	jb	.L71
	add	r9, 1
	cmp	r9, r14
	jb	.L70
	call	now_seconds
	imul	rax, r15, 40
	push	r15
	.cfi_def_cfa_offset 568
	mov	rdx, r15
	movapd	xmm1, xmm0
	mov	r9, rbp
	mov	r8, r14
	mov	rcx, r12
	lea	rsi, .LC30[rip]
	lea	rdi, .LC31[rip]
	push	rax
	.cfi_def_cfa_offset 576
	subsd	xmm1, QWORD PTR 40[rsp]
	mov	eax, 2
	movsd	xmm0, QWORD PTR 32[rsp]
	call	printf@PLT
	pop	rax
	.cfi_def_cfa_offset 568
	pop	rdx
	.cfi_def_cfa_offset 560
	cmp	ebx, 5
	je	.L117
.L73:
	lea	rdi, .LC34[rip]
	xor	r12d, r12d
	call	puts@PLT
	mov	rdi, r13
	call	store_free
	mov	rdi, QWORD PTR [rsp]
	call	free@PLT
	jmp	.L45
.L115:
	mov	rdi, QWORD PTR 8[rbp]
	lea	rsi, 40[rsp]
	call	parse_size
	test	eax, eax
	je	.L59
	mov	rdi, QWORD PTR 16[rbp]
	lea	rsi, 48[rsp]
	call	parse_size
	test	eax, eax
	je	.L59
	cmp	ebx, 3
	je	.L60
	mov	rdi, QWORD PTR 24[rbp]
	lea	rsi, 56[rsp]
	call	parse_size
	test	eax, eax
	je	.L59
	mov	r12, QWORD PTR 48[rsp]
	test	r12, r12
	je	.L59
	mov	r14, QWORD PTR 56[rsp]
	test	r14, r14
	jne	.L76
	.p2align 4
	.p2align 3
.L59:
	mov	rdx, QWORD PTR 0[rbp]
	mov	rdi, QWORD PTR stderr[rip]
	lea	rsi, .LC25[rip]
	xor	eax, eax
	call	fprintf@PLT
.L56:
	mov	r12d, 1
.L45:
	add	rsp, 504
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	eax, r12d
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
.L114:
	.cfi_restore_state
	mov	r13, QWORD PTR 8[rsi]
	lea	rsi, .LC8[rip]
	mov	rdi, r13
	call	strcmp@PLT
	mov	r12d, eax
	test	eax, eax
	je	.L118
	lea	rsi, 40[rsp]
	mov	rdi, r13
	call	parse_size
	test	eax, eax
	jne	.L58
	jmp	.L59
.L118:
	movapd	xmm1, XMMWORD PTR .LC10[rip]
	pxor	xmm0, xmm0
	xor	ecx, ecx
	xor	esi, esi
	mov	rax, QWORD PTR .LC9[rip]
	mov	rdx, QWORD PTR .LC12[rip]
	mov	DWORD PTR 320[rsp], ecx
	lea	rdi, 64[rsp]
	movaps	XMMWORD PTR 336[rsp], xmm1
	mov	ecx, 6
	movaps	XMMWORD PTR 368[rsp], xmm1
	movapd	xmm1, XMMWORD PTR .LC13[rip]
	mov	QWORD PTR 324[rsp], rax
	movaps	XMMWORD PTR 432[rsp], xmm1
	movapd	xmm1, XMMWORD PTR .LC14[rip]
	mov	QWORD PTR 356[rsp], rax
	mov	QWORD PTR 452[rsp], rax
	mov	QWORD PTR 484[rsp], rax
	mov	rax, QWORD PTR .LC16[rip]
	movaps	XMMWORD PTR 464[rsp], xmm1
	movsd	xmm1, QWORD PTR .LC15[rip]
	mov	QWORD PTR 420[rsp], rdx
	lea	rdx, 304[rsp]
	mov	QWORD PTR 168[rsp], rax
	mov	QWORD PTR 200[rsp], rax
	movaps	XMMWORD PTR 304[rsp], xmm0
	movaps	XMMWORD PTR 400[rsp], xmm0
	movaps	XMMWORD PTR 144[rsp], xmm0
	movaps	XMMWORD PTR 176[rsp], xmm0
	movaps	XMMWORD PTR 208[rsp], xmm0
	mov	DWORD PTR 352[rsp], 1
	mov	DWORD PTR 384[rsp], 2
	mov	QWORD PTR 388[rsp], 10
	mov	DWORD PTR 416[rsp], 3
	mov	DWORD PTR 448[rsp], 4
	mov	DWORD PTR 480[rsp], 5
	mov	QWORD PTR 192[rsp], 0x000000000
	movsd	QWORD PTR 160[rsp], xmm1
	mov	rbx, QWORD PTR .LC18[rip]
	mov	QWORD PTR 232[rsp], rax
	mov	rax, QWORD PTR .LC19[rip]
	movaps	XMMWORD PTR 240[rsp], xmm0
	mov	QWORD PTR 264[rsp], rax
	mov	rax, QWORD PTR .LC1[rip]
	movaps	XMMWORD PTR 272[rsp], xmm0
	movdqa	xmm0, XMMWORD PTR .LC21[rip]
	mov	QWORD PTR 288[rsp], rax
	mov	rax, QWORD PTR .LC20[rip]
	mov	QWORD PTR 224[rsp], rbx
	lea	rbx, 64[rsp]
	mov	QWORD PTR 296[rsp], rax
	mov	eax, r12d
	rep stosd
	movaps	XMMWORD PTR 96[rsp], xmm0
	mov	rdi, rbx
	movdqa	xmm0, XMMWORD PTR .LC22[rip]
	mov	QWORD PTR 128[rsp], rsi
	mov	esi, 6
	movsd	QWORD PTR 256[rsp], xmm1
	movaps	XMMWORD PTR 112[rsp], xmm0
	call	store_create
	test	eax, eax
	je	.L56
	lea	rbp, 144[rsp]
	xor	r8d, r8d
	lea	r9, 96[rsp]
	mov	rsi, rbp
.L52:
	mov	rdi, rbx
	call	search
	cmp	rax, QWORD PTR [r9+r8*8]
	jne	.L119
	add	r8, 1
	add	rsi, 32
	cmp	r8, 5
	jne	.L52
	call	store_free
	xor	edx, edx
	xor	esi, esi
	mov	rdi, rbx
	call	store_create
	test	eax, eax
	je	.L56
	mov	rsi, rbp
	mov	rdi, rbx
	call	search
	mov	rbp, rax
	call	store_free
	test	rbp, rbp
	jne	.L56
	lea	rdi, .LC24[rip]
	call	puts@PLT
	jmp	.L45
.L60:
	mov	r12, QWORD PTR 48[rsp]
	mov	r14d, 1
	test	r12, r12
	je	.L59
	jmp	.L76
.L116:
	mov	rdi, QWORD PTR [rsp]
	call	free@PLT
	mov	edx, 26
	mov	rcx, QWORD PTR stderr[rip]
	mov	esi, 1
	lea	rdi, .LC29[rip]
	call	fwrite@PLT
	jmp	.L56
.L119:
	call	store_free
	mov	edx, 17
	mov	rcx, QWORD PTR stderr[rip]
	mov	esi, 1
	lea	rdi, .LC23[rip]
	call	fwrite@PLT
	jmp	.L56
.L117:
	lea	rdi, .LC32[rip]
	xor	eax, eax
	lea	rbp, .LC33[rip]
	call	printf@PLT
	lea	rbx, .LC6[rip]
.L75:
	mov	r15, QWORD PTR 8[rsp]
	mov	rax, QWORD PTR [rsp]
	mov	rdi, r13
	mov	rsi, r15
	sal	rsi, 5
	add	rsi, rax
	call	search
	test	r15, r15
	lea	rsi, .LC7[rip]
	mov	rdi, rbp
	cmovne	rsi, rbx
	mov	rdx, rax
	add	r15, 1
	xor	eax, eax
	call	printf@PLT
	mov	QWORD PTR 8[rsp], r15
	cmp	r15, r12
	jb	.L75
	mov	edi, 93
	call	putchar@PLT
	jmp	.L73
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	main.cold, @function
main.cold:
.LFSB17:
.L111:
	.cfi_def_cfa_offset 560
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	lea	rdi, .LC27[rip]
	call	perror@PLT
	jmp	.L56
	.cfi_endproc
.LFE17:
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE36:
	.section	.text.startup
.LHOTE36:
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	1079574528
	.long	0
	.long	1079574528
	.set	.LC1,.LC0
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC4:
	.long	-400107883
	.long	1041313291
	.align 8
.LC9:
	.long	10
	.long	1
	.section	.rodata.cst16
	.align 16
.LC10:
	.long	0
	.long	1074266112
	.long	0
	.long	1074790400
	.section	.rodata.cst8
	.align 8
.LC12:
	.long	20
	.long	1
	.section	.rodata.cst16
	.align 16
.LC13:
	.long	0
	.long	1075314688
	.long	0
	.long	1075838976
	.align 16
.LC14:
	.long	0
	.long	-1073217536
	.long	0
	.long	-1072693248
	.section	.rodata.cst8
	.align 8
.LC15:
	.long	0
	.long	1075052544
	.align 8
.LC16:
	.long	10
	.long	10
	.align 8
.LC18:
	.long	0
	.long	1076101120
	.align 8
.LC19:
	.long	20
	.long	20
	.align 8
.LC20:
	.long	30
	.long	35
	.section	.rodata.cst16
	.align 16
.LC21:
	.quad	3
	.quad	1
	.align 16
.LC22:
	.quad	4
	.quad	1
	.section	.rodata.cst8
	.align 8
.LC28:
	.long	0
	.long	1077477376
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
