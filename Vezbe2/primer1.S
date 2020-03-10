#NZD al sa promenljivama
.section .data
	a: .long 12
	b: .long 8
.section .text
.globl main
main:
	movl a, %eax
	movl b, %ebx

uporedi:	
	cmpl %ebx, %eax
	je kraj
	ja vece
	subl %eax, %ebx
	jmp uporedi

vece:
	subl %ebx, %eax
	jmp uporedi

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
