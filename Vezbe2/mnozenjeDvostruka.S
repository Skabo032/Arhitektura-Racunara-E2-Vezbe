#Mnozenje pomocu sabiranja u dvostrukoj
.section .data
	a: .quad 12
	b: .quad 8
	c: .quad 0
	greska: .long 0
.section .text
.globl main

main:
	movl a, %eax
	movl a+4, %edx
	addl %eax, c	#u c ide rezultat
	adcl %edx, c+4
	jc error
	
	movl b, %ebx	#b smanjujemo
	subl $1, %ebx	
	movl %ebx, b
	jnz main		#sve dok nije nula vracaj ga na vrh
	movl b+4, %ecx	#oduzimanje dela vece vrednosti
	sbbl $0, %ecx	
	movl %ecx, b+4
	jz kraj			#ako je nula zavrsi program
	jmp main		#ako nije opet na vrh
	
	
error:
	movl $1, greska

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
