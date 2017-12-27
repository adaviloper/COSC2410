.text
.globl main
main:
	addi $t0, $0, 4
	srl $t1, $t0, 2
	sll $t2, $t0, 2
	li $v0, 10
	syscall
