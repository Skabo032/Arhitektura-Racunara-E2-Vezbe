#Faktorijel od n
# 5 * 4 * 3 * 2 * 1
# 5 * 4 * ostalo
# 
.section .data
.section .text
.globl main
main:
	movl $5, %eax #n
	movl $4, %ebx #n-1
	movl $0, %ecx #rezultat
	movl $4, %edx #n-1
loop:
	addl %eax, %ecx
	decl %ebx
	jne loop
	decl %edx
	je kraj
	movl %edx, %ebx
	movl %ecx, %eax
	movl $0, %ecx
	jmp loop
    
    
	

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
