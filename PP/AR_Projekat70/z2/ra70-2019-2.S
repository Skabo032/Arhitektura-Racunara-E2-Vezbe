#autor: Bosko Ristovic INDEX ra70-2019

#int encode(char* izvorni, char* ciljni, char* enkodovati);
.section .text
.globl encode
encode:
	pushl %ebp
	movl %esp, %ebp
		
	pushl %ebx
	pushl %esi
	pushl %edi
	xorl %eax, %eax			#delove eax cemo koristiti za poredjenja
	
	movl 16(%ebp), %esi		#string za enkodovanje		
	movl $0, %edi			#brojac promena	
	decl %esi
loop:						#glavni loop koji se krece kroz string
	incl %esi				#kretanje kroz string
	cmpb $0, (%esi)
	je zavrsi
	movl 12(%ebp), %ebx		#stavljamo se na pocetak ciljnih karaktera
	movl 8(%ebp), %ecx		#stavljamo se na kraj izvornih karaktera
loop2:
	cmpb $0, (%ecx)	
	je loop					#provera za izlazak iz ugnjezdenog loopa
	
	movb (%esi), %al        #proverava dal je su isti dal je pronadjen izvorni karakter u stringu
	movb (%ecx), %ah
	cmpb %ah, %al
	je menjaj
	
	incl %ebx				#zajedno se krece kroz ciljne i izvorne karaktere
	incl %ecx
	jmp loop2
	
	menjaj:					#menja karakter stringa sa ciljnim karakterom
		movb (%ebx), %ah
		movb %ah, (%esi)
		incl %edi			#povecaj brojac
		jmp loop			#i skaci na glavni loop
		
zavrsi:
	movl %edi, %eax
kraj:
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
	

