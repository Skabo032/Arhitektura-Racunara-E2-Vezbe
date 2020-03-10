#
#
.section .data
.section .text
.globl main
main:
	movl $5, %eax
	movl $3, %ebx
	addl %eax, %ebx

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
