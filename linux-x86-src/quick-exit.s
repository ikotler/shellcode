#
# (linux/x86) quick (yet conditional, eax != 0 and edx == 0) exit w/ random (so to speak) return value - 4 bytes
#

.section .text
	.global _start
	_start:

		divl %eax, %eax
		int $0x80

