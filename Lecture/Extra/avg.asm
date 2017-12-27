	.data
prompt:	.asciiz "Enter a number: "
result:	.asciiz "The average is: "
	.text
	.globl main
main:
	la $a0, prompt
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	
	la $a0, prompt
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a1, $v0
	
	la $a0, prompt
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a2, $v0
	
	jal avg
	move $a0, $v0
	jal printRes
	
	li $v0, 10
	syscall
	
avg:
	addi $sp, $sp, -12
	sw $a2, 8($sp)
	sw $a1, 4($sp)
	sw $a0, 0($sp)
	
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	
	li $t4, 2
	li $t5, 3
	
	li $v0, 1
	la $a0, ($a1)
	syscall
	
	add $t0, $a1, $a0
	
	beqz $t3, two
		add $t0, $t0, $a2
		div $t0, $t5
		mflo $v0
		addi $sp, $sp, 12
		jr $ra
	two:
		div $t0, $t4
		mflo $v0
		addi $sp, $sp, 12
		jr $ra

printRes:
	move $t0, $a0
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1
	la $a0, ($t0)
	syscall
	jr $ra