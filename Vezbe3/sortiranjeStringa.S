#Sortiranje stringa po abecedi
#DEFINITIVNO POSTOJI LAKSI NACIN OD OVOG, ali hej, i ovo radi.
.section .data
	string: .ascii "maestro\0"
.section .text
.globl main

main:							#START
	movl $0, %eax				#prvi pokazivac kroz string
	movl $1, %esi				#drugi pokazivac
loop:
	movb string(,%eax,1), %dl	
	cmpb %dl, string(,%esi,1)	#poredi dva karaktera
	jl zameni
nastavi:
	incl %esi					#povecaj drugi pokazivac
	cmpb $0, string(,%esi,1)	#ako je on stigao do kraja niza,
	je step						#idi na funkciju step
	jmp loop					#u suprotnom nastavi da vrtis
	
zameni:							#menja mesta karakterima na %eax i %esi
	movb string(,%eax,1), %bl
	movb string(,%esi,1), %bh
	movb %bl, string(,%esi,1)
	movb %bh, string(,%eax,1)
	jmp nastavi
	
step:
	incl %eax					#pomera prvi pokazivac unapred
	movl %eax, %esi
	incl %esi					#pomera drugi pokazivac da bude odmah posle njega
	cmpb $0, string(,%esi,1)	#ako je on stigao do kraja niza
	je kraj						#zavrsi program
	jmp loop					#u suprotnom vraca na loop

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
