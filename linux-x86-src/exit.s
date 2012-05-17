#
# (linux/x86) normal exit w/ random (so to speak) return value - 5 bytes
#

.section .text
	.global _start
	_start:

		xorl %eax, %eax
		incl %eax
		int $0x80

