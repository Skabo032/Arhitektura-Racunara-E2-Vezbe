#a=2*b+c/3
.section .data
	a: .quad 0
	b: .quad 50
	c: .quad 30
	
	kMnozenja: .long 2
	kDeljenja: .long 3
	
	greska: long 0
.section .text
.globl main
main:
	movl $0, %eax
loop:	
	addl b, %eax
	adcl b+4, %edx
	jc error
	dec kMnozenja
	jnz loop
	movl %eax, a
	movl %edx, a+4
loop2:				#odavde ide deljenje sa 3
	
	
	


kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
