.section .data
#bit na indeksu n, stavlja na vrednost v, svi ostali bitovi suprotna vrednost
.globl maska
#unsigned int maska(unsigned int n, unsigned int v);
maska:
	pushl %ebp
	movl %esp, %ebp
	
	movl $0, %eax
	movl 8(%ebp), %edx #brojac mesta
	incl %edx			#quick fix, jer je masio za jedno messto
	
	movl $1, %eax
	decl %edx
	jz provera
	
loop:
	shll %eax
	decl %edx
	jnz loop
	
provera:
	cmpl $0, 12(%ebp) #proverava vrednost v
	jne kraj
	notl %eax		#invertuje bitove
	
kraj:
	movl %ebp, %esp
	popl %ebp
	ret
