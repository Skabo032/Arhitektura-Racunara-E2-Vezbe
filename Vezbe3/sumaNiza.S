#suma el niza, indeksno adresiranje

.section .data
	N = 10
	niz: .long 1,2,3,4,5,6,7,8,9,10
	suma: .long 0
.section .text
.globl main
main:
	movl $0, %esi	#indeksni registar
	movl $0, %eax	#u eax racunamo sumu
loop:
	addl niz(,%esi,4), %eax
	incl %esi
	cmpl $N, %esi
	jl loop
	
	movl %eax, suma
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
