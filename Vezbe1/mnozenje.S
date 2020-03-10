#mnozenje pomocu sabiranja
#
#
.section .data
.section .text
.globl main
main:
	movl $5, %eax
	movl $4, %ebx
	movl $0, %ecx
loop:
	addl %eax, %ecx
	subl $1, %ebx
	jne loop

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
