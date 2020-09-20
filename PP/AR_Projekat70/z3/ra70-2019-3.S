#autor: Bosko Ristovic INDEX ra70-2019
.section .data
prompt1: .ascii "Unesite logicki izraz: \0"
prompt1_len = . - prompt1
prompt2: .ascii "Rezultat: \0"
prompt2_len = . - prompt2
err1: .ascii "Greska kod operanda.\n\0"
err1_len = . - err1
err2: .ascii "Greska kod operacije.\n\0"
err2_len = . - err2
newline: .ascii "\n\0"

ulazmax = 101
izlazmax = 5
ulaz: .fill ulazmax,1,0
ulaz_len: .long 0
rezultat: .long 0
izlaz: .fill ulazmax,1,0

broj1: .byte 0
broj2: .long 0
operacija: .long 0
rezultat_len: .long 4
.section .text
.globl main
main:
	movl $4, %eax
	movl $1, %ebx
	movl $prompt1, %ecx
	movl $prompt1_len, %edx
	int $0x80
	
	movl $3, %eax
	movl $0, %ebx
	movl $ulaz, %ecx
	movl $ulazmax, %edx
	int $0x80
	
	#toUpper
	movl $ulaz, %esi
	decl %esi
toUpper:					#slova a-f iz ulaza prebacujem u velika
	incl %esi
	movb (%esi), %bl
	cmpb $0, %bl
	je parsiraj
	cmpb $97, %bl
	jb toUpper
	cmpb $122, %bl
	ja toUpper
	subb $32, %bl
	movb %bl, (%esi)
	jmp toUpper
parsiraj:
	xorl %eax, %eax
	xorl %ebx, %ebx
	xorl %ecx, %ecx
	xorl %edx, %edx
	
	movl $ulaz, %esi
	decl %esi
loop1:						#proverava pocetne nule i dal je heksadecimalni operand
	incl %esi
	cmpb $'0', (%esi)		#loop1 deo je zaduzen da procita prvi operand i smesti ga u promenljivu broj1
	je loop1
	cmpb $'X', (%esi)
	je hex_to_int_setup
	jmp dec_to_int
	
hex_to_int_setup:
	incl %esi
hex_to_int:
	movb $16, %cl			#osnova brojnog sistema
	movb (%esi), %bl
	cmpb $'0', %bl
	jb greska_operanda
	cmpb $'F', %bl
	ja greska_operanda
	
	subb $'0', %bl
	cmpb $17, %bl
	jb nastavi1
	subb $7, %bl
	nastavi1:
	mulb %cl
	andb %ah, %ah
	jnz greska_operanda		#prekoracenje
	addb %bl, %al
	jc greska_operanda
	incl %esi
	cmpb $' ', (%esi)
	jne hex_to_int
	movb %al, broj1		#TREBA SACUVATI BROJ I MOZDA PROVERITI DRUGI KRAJ KAO KRAJ STRINGA NPR
	jmp loop2
	
dec_to_int:
	movb $10, %cl
	movb (%esi), %bl
	cmpb $'0', %bl
	jb greska_operanda
	cmpb $'9', %bl
	ja greska_operanda
	
	subb $'0', %bl
	mulb %cl
	andb %ah, %ah
	jnz greska_operanda		#prekoracenje
	addb %bl, %al
	jc greska_operanda
	incl %esi
	cmpb $' ', (%esi)
	jne dec_to_int
	movb %al, broj1
	jmp loop2
	
loop2:						#Loop2 sluzi da nam procita koja operacija ide
	xorl %eax, %eax
	xorl %ebx, %ebx
	xorl %ecx, %ecx
	xorl %edx, %edx
	
	incl %esi
	cmpb $'^', (%esi)
	jne dalje1
	movl $1, operacija
	jmp loop3_setup
	dalje1:
	cmpb $'<', (%esi)
	jne dalje2
	movl $2, operacija
	jmp loop3_setup
	dalje2:
	cmpb $'>', (%esi)
	jne greska_operacija
	movl $3, operacija
	jmp loop3_setup
	
loop3_setup:					#loop3 deo sluzi da procita "drugi" operand i stavlja ga u al
	incl %esi	
loop3:							#proverava pocetne nule i dal je heksadecimalni operand
	incl %esi
	cmpb $'0', (%esi)
	je loop3
	cmpb $'X', (%esi)
	je hex_to_int2_setup
	jmp dec_to_int2
	
hex_to_int2_setup:
	incl %esi	
hex_to_int2:
	movb $16, %cl			#osnova brojnog sistema
	movb (%esi), %bl
	cmpb $'0', %bl
	jb greska_operanda
	cmpb $'F', %bl
	ja greska_operanda
	
	subb $'0', %bl
	cmpb $17, %bl
	jb nastavi2
	subb $7, %bl
	nastavi2:
	mulb %cl
	andb %ah, %ah
	jnz greska_operanda		#prekoracenje
	addb %bl, %al
	jc greska_operanda
	incl %esi
	cmpb $' ', (%esi)
	je racun				#TREBA DODATI USLOV ZA KRAJ STRINGA
	cmpb $10, (%esi)
	je racun
	jmp hex_to_int2
							
dec_to_int2:
	movb $10, %cl
	movb (%esi), %bl
	cmpb $'0', %bl
	jb greska_operanda
	cmpb $'9', %bl
	ja greska_operanda
	
	subb $'0', %bl
	mulb %cl
	andb %ah, %ah
	jnz greska_operanda		#prekoracenje
	addb %bl, %al
	jc greska_operanda
	#andb %ah, %ah
	#jnz greska_operanda		#prekoracenje
	incl %esi
	cmpb $' ', (%esi)
	je racun
	cmpb $10, (%esi)
	je racun
	jmp dec_to_int2
	
racun:						#ovde stize kad ima dva operanda, i vrsi odabranu operaciju, rezultat smesta u broj1
	movb %al, %cl
	cmpl $1, operacija
	je xor
	cmpl $2, operacija
	je rol
	cmpl $3, operacija
	je ror
	
	xor:
		xorb %al, broj1		#al xor broj1 -> broj1
		jmp provera_kraja
	rol:
		rolb %cl, broj1
		jmp provera_kraja				#MOZE DA NASTANE PROBLEM ZBOG REGISTARA I OPERANADA
	ror:
		rorb %cl, broj1
		jmp provera_kraja
	
provera_kraja:				#proverava da li ima jos operanada da se racuna, il je naisao na kraj ulaza
	cmpb $10, (%esi)
	je int_to_oct_setup		#ako je kraj radi zadnju konverziju
	jmp loop2				#ako nije vrati na loop2 da cita operaciju

int_to_oct_setup:
	movl $izlaz, %edi
	movb $8, %bl
	movb broj1, %al
int_to_oct:					#klasicna konverzija int to oct
	decl rezultat_len
	cmpl $1, rezultat_len		
	jl prekoracenje
	xorb %ah, %ah
	divb %bl
	addb $'0', %ah
	movb %ah, (%edi)
	incl %edi
	cmpb $0, %al
	jne int_to_oct
	
	movb $0, (%edi)			#stavljamo '\0' na kraj stringa
	decl %edi
	movl $izlaz, %esi
obrni:						#obrce string
	cmpl %esi, %edi
	jbe ispis
	movb (%edi), %al
	movb (%esi), %ah
	movb %al, (%esi)
	movb %ah, (%edi)
	incl %esi
	decl %edi
	jmp obrni
	
ispis:
	movl $4, %eax			#ispisuje prompt2
	movl $1, %ebx
	movl $prompt2, %ecx
	movl $prompt2_len, %edx
	int $0x80
	
	movl $4, %eax			#ispisuje sam rezultat
	movl $1, %ebx
	movl $izlaz, %ecx
	movl $5, %edx
	int $0x80
	
	movl $0, %ebx
	jmp kraj
	
greska_operanda:
	movl $4, %eax
	movl $1, %ebx
	movl $err1, %ecx
	movl $err1_len, %edx
	int $0x80
	
	movl $1, %ebx
	jmp kraj

greska_operacija:
	movl $4, %eax
	movl $1, %ebx
	movl $err2, %ecx
	movl $err2_len, %edx
	int $0x80
	
	movl $1, %ebx
	jmp kraj
	
prekoracenje:		#OVO STOJI OVDE SAMO ZBOG EVENTUALNOG NEDOSTATKA MESTA U IZLAZNOM STRINGU AL TO NE BI TREBALO DA SSE DESI
	movl $3, %ebx
	jmp kraj

kraj:
	movl $1, %eax
	int $0x80
	

