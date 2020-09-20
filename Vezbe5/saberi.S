.section .data
a: .long 3
b: .long 10
rez: .long 0
.section .text
# int saberi(int a, int b);
saberi:
	pushl %ebp		#sacuvamo stari base pointer
	movl %esp, %ebp	#postavimo novu vrednost base pointera
	
	movl 8(%ebp), %eax	#prvi argument (a), stavi u eax
	addl 12(%ebp), %eax	#njemu dodaj drugi arguent (b)
	
	movl %ebp, %esp #brisanje svih lokal promenjlivih
	popl %ebp		#vratimo staru referentnu tacku
	ret				#uzima sa steka povratnu adresu i vracca se

.globl main
main:
	pushl b	#stavljamo parametre na stek u obrnutom redosledu
	pushl a
	call saberi		#poziva saberi i pamti povratnu adresu na steku
	addl $8, %esp	#brise parametre a i b sa steka
	movl %eax, rez	#rezultat funkcije se nalazi u %eax registru
kraj:
	movl $1, %eax
	movl rez, %ebx
	int $0x80
