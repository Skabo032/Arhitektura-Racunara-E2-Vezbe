#Sabiranje dva broja u dvostrukoj preciznosti
.section .data
	a: .quad 12
	b: .quad 8
	greska: .long 0
.section .text
.globl main
main:
	movl a, %eax
	addl b, %eax
	
	movl a+4, %edx
	adcl b+4, %edx
	jc error
	jmp kraj
	
error:
	movl $1, greska

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
