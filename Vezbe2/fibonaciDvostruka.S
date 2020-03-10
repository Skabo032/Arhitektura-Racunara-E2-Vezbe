#Fibonaci u dvostrukoj preciznosti
.section .data
	n: .long 15	#n je koji clan zelimo da izracunamo
	a: .quad 1
	b: .quad 1
	greska: .long 0
.section .text
.globl main
main:
	subl $2, n	#prva dva clana imamo, to su 1 i 1

	movl a, %eax	#ucitavamo a u eax i edx
	movl a+4, %edx
	movl b, %ebx	#ucitavamo b u ebx i ecx
	movl b+4, %ecx
	
step1:
	addl %ebx, %eax
	adcl %ecx, %edx	#a+=b
	jc error
	decl n		#smanjuje n
	jne step2	#ako n nije nula idi na step 2
	je kraj
step2:
	addl %eax, %ebx
	adcl %edx, %ecx #b+=a
	jc error
	decl n		#smanjuje n
	jne step1	#ako n nije nula vrati na step1
	je kraj
	
error:
	incl greska	#ako dodje do grese u sabiranju

kraj:			#rezultat je veci od dva 64-bitna broja koji 
			#se nalazi u parovima registara (eax_edx) i (ebx_ecx)
	movl $1, %eax
	movl $0, %ebx
	int $0x80
