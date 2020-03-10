#zbir prvih n brojeva
#
#
.section .data
.section .text
.globl main
main:
	movl $5, %eax
	movl $0, %ebx
	
loop:
	addl %eax, %ebx
	subl $1, %eax
	jne loop
	

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
