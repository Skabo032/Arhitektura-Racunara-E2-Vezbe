#Fibonacijev za n=15
#
#
.section .data
.section .text
.globl main
main:
	movl $15, %eax
	movl $1, %ebx
	movl $1, %ecx
	subl $2, %eax
	
step1:
	addl %ebx, %ecx
	dec %eax
	jne step2
	je kraj
step2:
	addl %ecx, %ebx
	dec %eax
	jne step1
	
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
