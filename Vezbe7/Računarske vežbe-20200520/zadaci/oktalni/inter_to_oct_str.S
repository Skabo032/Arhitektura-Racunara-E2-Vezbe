#unsigned int inter_to_oct_str(unsigned int broj, char* str, unsigned int duzina);
.section .text
.globl inter_to_oct_str
inter_to_oct_str:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp	#za cuvanje greske
	movl $0, -4(%ebp)
	pushl %ebx
	pushl %esi
	pushl %edi
	
	movl 8(%ebp), %eax	#taj broj koji konvertujemo
	movl 12(%ebp), %edi	#pokazivac na string
	movl $8, %ebx		#osnova brojnog sistema
	
konvertuj:
	decl 16(%ebp)
	cmpl $1, 16(%ebp)
	jl greska
	xorl %edx, %edx
	divl %ebx		#ostatak deljenja ce se naci u edx, preciznije u dl
	addb $'0', %dl	#dodajemo ascii kod nule na vrednost ostatka,i tako dobijemo zeljeni ascii kod
	movb %dl, (%edi)#upisujemo karakter u string
	incl %edi		#pomeramo pokazivac stringa
	andl %eax, %eax
	jnz konvertuj
	
	movb $0, (%edi)	#stavljamo  '\0' na kraj stringa
	#sad treba da obrnemo string
	decl %edi		#jer hocemo da '\0' ostane na kraju
	movl 12(%ebp), %esi
obrni:
	cmpl %esi, %edi
	jbe kraj	#ako su se pokazivaci ukrstili (edi manji ili jednak esi)
	movb (%edi), %al
	movb (%esi), %ah
	movb %al, (%esi)
	movb %ah, (%edi)
	incl %esi
	decl %edi
	jmp obrni
	
greska:
	movl $1, -4(%ebp)
	
kraj:
	movl -4(%ebp), %eax	#u eax ide povratna vrednost programa
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
