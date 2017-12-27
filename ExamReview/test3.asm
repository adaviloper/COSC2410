		.data
numEnter:	.asciiz "Please enter a number: "
result:		.asciiz "The factorial is: "
	.text
	.globl main
main:
	li $v0, 4
	la $a0, numEnter
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	
	jal fact
	
	move $t0, $v0
	
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 1
	la $a0, ($t0)
	syscall
	
	li $v0, 10
	syscall

fact:
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, ($sp)
	
	li $t0, 1
	ble $a0, $t0, return_one
	
	# load argument for recursive call
	addi $a0, $a0, -1
	# recursive call
	jal fact
	
	# load $a0 from stack
	lw $a0, ($sp)
	mult $a0, $v0
	mflo $v0
	j end_fact
return_one:
	li $v0, 1
	j end_fact
	
end_fact:
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	
	jr $ra