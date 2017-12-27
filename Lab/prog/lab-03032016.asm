# three functions
# 1. add two numbers and print sum
# 2. add two numbers and print difference
# 3. add two numbers and print product
# 4. add two numbers and print quotient

	.data
prompt:	.asciiz "Enter a number: \n 1. addition \n 2. subtraction \n 3. multiplication \n 4. division\n"
option: .asciiz "Choose: "
dig:	.asciiz "Enter a number: "
newLine:.asciiz "\n"
	.text
	.globl main
main:
	li $v0, 4
	la $a0, prompt
	syscall
	li $v0, 4
	la $a0, option
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, dig
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 4
	la $a0, dig
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2
	
	j choice
	
choice_end:
	lw $a0, ($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	
	la $a0, ($v0)
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall

choice:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	# save arguments
	addi $sp, $sp, -12
	sw $a2, 8($sp)
	sw $a1, 4($sp)
	sw $a0, 0($sp)
	
	li $t0, 1
	beq $a0, $t0, add_fun
	addi $t0, $t0, 1
	beq $a0, $t0, sub_fun
	addi $t0, $t0, 1
	beq $a0, $t0, mult_fun
	addi $t0, $t0, 1
	beq $a0, $t0, div_fun
	li $v0, -1
	j choice_end
	
add_fun:
	# move a1 -> a0, a2 -> a1
	move $a0, $a1
	move $a1, $a2
	j addition
addition:
	add $v0, $a0, $a1
	j choice_end
sub_fun:
	move $a0, $a1
	move $a1, $a2
	j subtraction
subtraction:
	sub $v0, $a0, $a1
	j choice_end
mult_fun:
	move $a0, $a1
	move $a1, $a2
	j multiplication
multiplication:
	mul $v0, $a0, $a1
	j choice_end	
div_fun:
	move $a0, $a1
	move $a1, $a2
	j division
division:
	div $v0, $a0, $a1
	j choice_end	