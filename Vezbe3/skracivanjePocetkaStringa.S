#izbacivanje razmaka sa pocetka niza
.section .data
	string: .ascii " abcd\0"
.section .text
.globl main
main:
	movl $string, %eax		#eax ce biti pokazivac koji pomeramo kroz niz
loop:
	cmpb $' ',(%eax)		#ako je prvi karakter niza ' ' udri algoritam
	jne kraj
loop2:	
	movb 1(%eax), %bl		#karakter ispred prekopiraj na sadasnji
	movb %bl, (%eax)
	incl %eax				#povecava pokazivac
	cmpb $0, (%eax)			#proverava da li je kraj stringa
	je main					#ako jeste vraca ga za slucaj da ima vise ' ' na pocetku
	jne loop2				#ako nije vrti opet
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
