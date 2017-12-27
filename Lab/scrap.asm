	.data
	.text
	.globl main
main:
	li $t0, 3
	addi $t0, $t0, 7
	li $t1, 5
	div $t0, $t1
	mflo $t2
	la $a0, ($t2)
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall