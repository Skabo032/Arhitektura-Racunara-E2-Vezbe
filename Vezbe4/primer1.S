.section .data
	poruka1: .ascii "Unesite ime i prezime: \0"
	por1_len = . - poruka1			#racuna duzinu poruke 1, prilikom kompajliranja
	poruka2: .ascii "Vi ste: \0"
	por2_len = . - poruka2			#racuna duzinu poruke 2,...
	imemax = 50
	imeprez: .fill imemax,1,42
.section .text
.global main
main:
	movl $4, %eax			#4 je broj sistemskog poziva za ispis
	movl $1, %ebx			#1 nam kaze da zelimo stdout
	movl $poruka1, %ecx 	#u ecx stavljamo adresu bafera za ispis
	movl $por1_len,%edx 	#u edx stavljamo duzinu bafera za ispis
	int $0x80
	
	movl $3, %eax			#3 je br za ulaz
	movl $0, %ebx			#0 znaci stdin
	movl $imeprez, %ecx		#u ecx ide adresa bafera za ulaz
	movl $imemax, %edx		#u edx ide duzina bafera za ulaz
	int $0x80
	movl %eax, %esi			#nakon ulaza u eax se upisuje broj unetih karaktera, to sad cuvamo u esi
	
	movl $imeprez, %eax
upcase:
	cmpb $'a', (%eax)		#sad proverava dal je neki karakter malo slovo
	jb dalje
	cmpb $'z', (%eax)		
	ja dalje
	addb $'A'-'a', (%eax)	#ako jeste pretvori ga u veliko tako sto mu dodamo ovu razliku
dalje:
	incl %eax
	cmpb $10, (%eax)		#'\n' ili 10 oznacava kraj stringa sa stdin
	jne upcase
	
	
	movl $4, %eax			# "Vi ste: "
	movl $1, %ebx			#
	movl $poruka2, %ecx 	#
	movl $por2_len,%edx 	#
	int $0x80
	
	movl $4, %eax			#ovo ispisuje ime i prezime
	movl $1, %ebx			
	movl $imeprez, %ecx 	
	movl %esi,%edx 			#u esi nam stoji duzina imena i prezimena
	int $0x80
	
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
