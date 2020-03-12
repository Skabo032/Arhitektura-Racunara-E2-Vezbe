#   a = 2*b + c/3			Ocekivan rezultat: 11.000.000.000
.section .data
	a: .quad 0
	b: .quad 5000000000		#5.000.000.000
	c: .quad 3000000000		#3.000.000.000
	
	kMnozenja: .quad 2
	kDeljenja: .quad 3
	
	greskaNijeDeljivo: .long 0
	greska: .long 0
.section .text
.globl main
main:
	movl $0, %eax
	movl $0, %edx
	
loop:				#b * koeficijentMnozenja
	addl b, %eax
	adcl b+4, %edx
	jc error
	decl kMnozenja
	jnz loop
	movl %eax, a
	movl %edx, a+4

	movl c, %eax	#ubacujemo c u (edx_eax) da bi se delilo
	movl c+4, %edx
loop2:				#odavde ide deljenje sa koeficientomDeljenja
	cmp kDeljenja+4, %edx	#proverava vise znacajne delove
	ja vece
	je jednako
	jb manje

vece:				#ako je vece delimo
	subl kDeljenja, %eax
	sbbl kDeljenja+4, %edx
	incl a
	jmp loop2
	
manje:				#ako bude manje baca gresku
	incl greskaNijeDeljivo
	jmp kraj
	
jednako:			#ovde proverava manje znacajne delove
	cmp kDeljenja, %eax
	ja vece
	je jednako2
	jl manje
	
jednako2: 			#ako su skroz jednak, uvecava a i zavrsava program.
	incl a
	
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
