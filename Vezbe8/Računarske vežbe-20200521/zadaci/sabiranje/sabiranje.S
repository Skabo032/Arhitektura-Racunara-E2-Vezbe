# Program za sabiranje dva broja u proizvoljnoj bazi
# Imenko Prezimić ra1234

# Napisati asemblerski program koji, koristeći potprograme za konverziju
# za bilo koju bazu 2‑36, vrši sabiranje dva neoznačena cela broja data u
# znakovnom obliku i rezultat vraća u znakovnom obliku. Sve konverzije
# raditi odmah nakon unosa, a u slučaju greške prekinuti dalji rad
# programa i ispisati odgovarajuću poruku. Primer korišćenja:
#       Unesite bazu broja:16
#       Unesite broj:Fa
#       Unesite bazu broja:8
#       Unesite broj:123
#       Unesite bazu rezultata:2
#       Rezultat:101001101
# Za ostale primere pokrenuti testiraj.sh.
# Dodatni primeri se mogu napraviti pomoću kalkulatora (Accessories/Calculator)

.section .data
ulaz1:      .ascii "Unesite bazu broja:\0"
ulaz1_len = . - ulaz1
ulaz2:      .ascii "Unesite broj:\0"
ulaz2_len = . - ulaz2
ulaz3:      .ascii "Unesite bazu rezultata:\0"
ulaz3_len = . - ulaz3
izlaz1:     .ascii "Rezultat:\0"
izlaz1_len = . - izlaz1
greska1:    .ascii "Greska: pogresan znak!\0"
graska1_len = . - greska1
greska2:    .ascii "Greska: prekoracenje!\0"
greska2_len = . - greska2

ulazmax = 33
broj1_znak = .fill ulazmax,1,0
broj2_znak = .fill ulazmax,1,0
broj1_int = .long 0
broj2_int = .long 0
baza_broj1 = .long 0
baza_broj2 = .long 0

.section .text
.globl main
main:
	movl $4, %eax
	movl $1, %ebx
	movl $poruka1, %ecx
	movl $por1_len, %edx
	int $0x80
	
	movl $3, %eax
	movl $0, %ebx
	movl $broj1_znak, %ecx
	movl $ulazmax, %edx
	int $0x80
	movl %eax, %esi		#duzina znakovnog oblika
	
	#pozivamo konverziju
	pushl %esi
	pushl $broj1_znak
	call znak_to_int
	
	
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
#============================
znak_to_int:
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
	
kraj:
	movl 12(%ebp), %ebx	#upisivanje greske
	movl %edi, (%ebx)
	
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret					#ne zaboravi ret debilu





