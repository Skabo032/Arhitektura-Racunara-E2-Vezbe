#c[i]=a[i]+b[i] u dvostrukoj preciznosti
.section .data
	a: .quad 1,2,3,4,5,6,7,8,9
	b: .quad 9,8,7,6,5,4,3,2,1
	
	c: .fill 9,8,0	#niz u koji smestamo rezultats sabiranja
	N = 9			#konstanta duzine niza
.section .text
.globl main
main:
	movl $0, %esi				#indeks
	movl $4, %edx				#sluzi nam za bazu indeksiranja	
loop:
	movl a(,%esi,4), %eax
	movl a(%edx,%esi,4), %ebx
	addl b(,%esi,4), %eax
	adcl b(%edx,%esi,4), %ebx		#sabiranje u dvostrukoj preciznosti
	
	movl %ebx, c(%edx,%esi,4)
	movl %eax, c(,%esi,4)	#upisivanje rezultata u niz c
	
	addl $2, %esi					#povecava indeks za 2, mora tako da bi preskakao 8 bajtova
	cmpl $N*2, %esi					#i zbog toga proveravamo sa N*2
	jne loop 

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
