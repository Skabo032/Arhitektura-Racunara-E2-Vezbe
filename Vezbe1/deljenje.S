#deljenje pomocu oduzimanja
#
#
.section .data
.section .text
.globl main
main:
	movl $11, %eax
	movl $2, %ebx
	movl $0, %ecx #rezultat
	movl $0, %edx #ostatak
	
loop:
	cmpl %ebx, %eax
	ja vece
	jb manje
	je jednako
vece:
	subl %ebx, %eax
	incl %ecx
	jmp loop
	
manje:
	movl %eax, %edx
	jmp kraj
	
jednako:
	movl $1, %ecx
	
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
