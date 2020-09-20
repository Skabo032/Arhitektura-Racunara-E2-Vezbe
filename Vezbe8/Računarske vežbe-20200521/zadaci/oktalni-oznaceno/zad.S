#int oct_str_to_inter(char* str, unsigned int* greska);
.section .text
.globl oct_str_to_inter
oct_str_to_inter:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %ebx
	pushl %esi
	pushl %edi
	
	movl 8(%ebp), %esi
	xorl %eax, %eax		#rezultat
	xorl %ebx, %ebx		#koristicemo bl
	movl $8, %ecx		#osnova brojnog sistema
	movl $0, %edi		#greska
	xorl %edx, %edx
	movl $0, -4(%ebp) 	#dal je negativan
	
	cmpl %esi, $'-'
	jne konvertuj
	incl %esi
	addl $1, -4(%ebp)
	
konvertuj:
	movb (%esi), %bl	#ubacujemo prvi znak
	andb %bl, %bl		#proveravamo dal je "\0"
	jz kraj_konvertuj
	
	cmpb $'0', %bl
	jb greska_1
	cmpb $'7', %bl
	ja greska_1
	
	mull %ecx			#r*=8
	andl %edx, %edx		#proveravamo dal je izaslo van 32-bita, prekoracenje
	jnz greska_2
	subb $'0', %bl		#dobijamo cifru nasu
	addl %ebx, %eax		#dodamo je na rez
	incl %esi
	jmp konvertuj
	
	
kraj_konvertuj:
	cmpl %esi, 8(%ebp)
	jne kraj
greska_1:
	movl $1, %edi		#ako je prazan string ili sadrzi neki invalidni karakter
	jmp kraj
greska_2:
	movl $2, %edi
	jmp kraj
	
provera:
	cmpl $1, -4(%ebp)
	jne kraj
	negl %eax
	
kraj:
	movl 12(%ebp), %ebx	#upisivanje greske
	movl %edi, (%ebx)
	
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret					#ne zaboravi ret debilu
