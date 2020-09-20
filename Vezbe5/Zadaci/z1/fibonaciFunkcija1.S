#ovo je onaj sto nije rekurzivan, povratna vrednost je greska a rezultat
#je argument koji se prenosi po adresi
.section .text
.globl fibonaci
fibonaci:
	pushl %ebp
	movl %esp, %ebp
	
	movl 12(%ebp), %esi	#pamcenje adrese rezultata
	movl $0, (%esi) 	#postavljanje rezultata na 0
	movl $0, %eax		#postavljanje greske na nula
	
	movl $1, %ecx
	movl $1, %edx
	
	movl $1, (%esi)		 #ovo je slucaj ako je n:1,2
	decl 8(%ebp)
	jz kraj
	decl 8(%ebp)
	jz kraj
	
loop:					#racunanje
	addl %ecx, %edx
	jc greska
	decl 8(%ebp)
	movl %edx, (%esi)
	jz kraj
	addl %edx, %ecx
	jc greska
	decl 8(%ebp)
	movl %ecx, (%esi)
	jz kraj
	jmp loop
	
greska:
	movl $1, %eax
	
kraj:
	movl %ebp, %esp
	popl %ebp
	ret
