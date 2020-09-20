.section .data
	poruka: .ascii "Unesite string:\0"
	por_len = . - poruka
	nijep:  .ascii "String nije paindrom.\n\0"
	nije_len = . - nijep
	jestep: .ascii "String je palindrom.\n\0"
	jeste_len = . - jestep
	unos:	.fill 50,1,42
.section .text
.globl main
main:
	movl $4, %eax
	movl $1, %ebx
	movl $poruka, %ecx
	movl $por_len, %edx
	int $0x80
	
	movl $3, %eax
	movl $0, %ebx
	movl $unos, %ecx
	movl $50, %edx
	int $0x80			#unos gotov
	movl %eax, %esi		#cuvamo duzinu unosa
	subl $2, %eax		#da bi prvo slovo bilo indeks 0, a poslednje indeks $eax
	
	movl $0, %edi	#pokazivac na pocetak
	subl $2, %esi		#pokazivac na kraj
	
	movl $unos, %edx
	
upcase:					#pretvaram sve u velika slova, da ne bi bilo case sensitive
	cmpb $'a', (%edx)
	jb dalje
	cmpb $'z', (%edx)
	ja dalje
	addb $'A'-'a', (%edx)
dalje:
	incl %edx
	cmpb $10, (%edx)
	jne upcase
	
	
loop:
	cmpb $' ', unos(,%edi,1)	#============
	jne provera2
	incl %edi	
	provera2:					#ovaj deo bi trebao da preskace ' '
	cmpb $' ', unos(,%esi,1)	#(nadam se)
	jne continue
	decl %esi					#============
continue:
	movb unos(,%edi,1), %cl
	movb unos(,%esi,1), %dl
	cmpb %cl, %dl		#poredi dal je isto slovo
	jne nije			#ako jedno nije isto, odmah znamo da nije palindrom
	cmpl %eax, %edi		#proverava dal je stigao do kraja reci
	je jeste			#ako je uspesno stigao dovde, jeste palindrom
	incl %edi
	decl %esi
	jmp loop			#ako nije nista od ovog gore, nastavlja loop

nije:
	movl $4, %eax
	movl $1, %ebx
	movl $nijep, %ecx
	movl $nije_len, %edx
	int $0x80
	jmp kraj
jeste:
	movl $4, %eax
	movl $1, %ebx
	movl $jestep, %ecx
	movl $jeste_len, %edx
	int $0x80
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
