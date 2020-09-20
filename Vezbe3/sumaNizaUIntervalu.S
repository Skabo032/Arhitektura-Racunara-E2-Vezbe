#suma el niza u intervalu

.section .data
	N = 10
	niz: .long 1,2,3,4,5,6,7,8,9,10
	suma: .long 0
	donjaGranica: .long 2
	gornjaGranica: .long 5
.section .text
.globl main
main:
	movl $0, %esi	#indeksni registar
	addl donjaGranica, %esi
	incl gornjaGranica	# da bi sabiralo interval [ ] a ne [ )
	movl $0, %eax	#u eax racunamo sumu
loop:
	addl niz(,%esi,4), %eax
	incl %esi
	cmpl gornjaGranica, %esi
	jl loop
	
	movl %eax, suma
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
