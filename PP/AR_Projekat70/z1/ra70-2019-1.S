#autor: Bosko Ristovic INDEX ra70-2019

.section .data
prompt_1: .ascii "Unesite string: \0"
prompt1_len = . - prompt_1
prompt_2: .ascii "Enkodovan string: \0"
prompt2_len = . - prompt_2

string1: .fill 51,1,0

.section .text
.globl main
main:
	movl $4, %eax				#ispisuje poruku 1
	movl $1, %ebx
	movl $prompt_1, %ecx
	movl $prompt1_len, %edx
	int $0x80
	
	movl $3, %eax				#unos stringa 1
	movl $0, %ebx
	movl $string1, %ecx
	movl $40, %edx
	int $0x80
	
	movl $string1, %eax			#proverava da li je string prazan
	cmpb $10, (%eax)
	jz kraj
	
	decl %eax					#ovo je glupost koja mi treba da bi loop radio
dalje:
	incl %eax					
	cmpb $10, (%eax)
	jz ispis					#proverava kad je dosao do kraja stringa
	
	cmpb $65, (%eax)			#filteri za velika slova
	jb dalje
	cmpb $90, (%eax)
	ja proveri_mala
	
	subl $3, (%eax)				#ako uhvati velika slovo shiftuje u levo
	cmpb $65, (%eax)
	jae dalje
	addl $26, (%eax)
	jmp dalje
	
proveri_mala:
	cmpb $97, (%eax)			#filteri za mala slova
	jb dalje
	cmpb $122, (%eax)
	ja dalje
	
	subl $3, (%eax)				#ako uhvati malo slovo shiftuje u levo
	cmpb $97, (%eax)
	jae dalje
	addl $26, (%eax)
	jmp dalje

ispis:
	movl $4, %eax				#ispisuje poruku 2
	movl $1, %ebx
	movl $prompt_2, %ecx
	movl $prompt2_len, %edx
	int $0x80
	
	movl $4, %eax				#ispisuje konacni string
	movl $1, %ebx
	movl $string1, %ecx
	movl $51, %edx
	int $0x80

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
