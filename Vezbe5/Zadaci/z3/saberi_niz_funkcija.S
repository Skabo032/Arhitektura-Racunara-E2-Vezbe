.section .text
.globl saberi_niz
#int saberi_niz(long long *a, long long *b, long long *c, int n);
saberi_niz:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi		#ova dva pushujemo jer nam trebaju
	pushl %ebx		#na kraju funkcije moramo da ih popujemo
	
	movl 16(%ebp), %esi #pokazivac na niz c
	movl 12(%ebp), %edx #pokazivac na niz b
	movl 8(%ebp), %ecx #pokazivac na niz a
	
	movl $0, %eax	#pomoc za trenutni zbir
	movl 20(%ebp), %ebx	#brojac indeksa

	
loop:
	addl (%ecx, %ebx, 8), %eax
	addl (%edx, %ebx, 8), %eax
	movl %eax, (%esi, %ebx, 8)
	movl $0, %eax
	
	adcl 4(%ecx, %ebx, 8),  %eax
	addl 4(%edx, %ebx, 8),  %eax
	jc greska
	movl %eax, 4(%esi, %ebx, 8)
	movl $0, %eax
	
	decl %ebx
	jns loop	#kad udari u -1
	jmp kraj
	
greska:
	movl $1, %eax
kraj:
	popl %ebx
	popl %esi
	movl %ebp, %esp
	popl %ebp
	ret
	
