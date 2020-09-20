.section .data
#bit na indeksu n, stavlja na vrednost v, svi ostali bitovi suprotna vrednost
.globl maska64
#unsigned long long maska64(unsigned int n, unsigned int v);
maska64:
	pushl %ebp
	movl %esp, %ebp
	
	movl $0, %eax
	movl $0, %edx
	movl 8(%ebp), %ecx #brojac mesta
	incl %ecx			#quick fix, jer je masio za jedno messto
	
	movl $1, %eax
	decl %ecx
	jz provera
	
loop:
	shll %eax
	jc visi_deo
	decl %ecx
	jnz loop
	
provera:
	cmpl $0, 12(%ebp) #proverava vrednost v
	jne kraj
	notl %eax		#invertuje bitove
	notl %edx
	
kraj:
	movl %ebp, %esp
	popl %ebp
	ret

visi_deo:
	movl $1, %edx
	decl %ecx
	jz provera
loop2:
	shll %edx
	decl %ecx
	jnz loop2
	jz provera
