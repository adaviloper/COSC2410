	.data
prompt:	.asciiz "Enter a number: "
newLine:.asciiz "\n"
space:	.asciiz " "
	.text
	.globl main
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0 # save user's entry
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $t1, 0
	
fib_loop:
	bge $t1, $s0, end_loop
	move $a0, $t1
	jal fib
	
	move $a0, $v0	
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	addi $t1, $t1, 1
	j fib_loop
end_loop:
	j exit

exit:
	li $v0, 10
	syscall
fib:
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, ($sp)
	
	# push a register to use as a return of fib(a-1)
	addi $sp, $sp, -4
	sw $s0, ($sp)
	
	blez $a0, get_zero
		li $t0, 1
		beq $a0, $t0, get_one
			addi $a0, $a0, -1
			jal fib
			move $s0, $v0
			addi $a0, $a0, -1
			#lw $a0, 4($sp)
			#addi $a0, $a0, -2
			jal fib
			add $v0, $v0, $s0
			j end_fib
get_zero:
	li $v0, 0
	j end_fib
get_one:
	li $v0, 1
	j end_fib
end_fib:
	lw $s0, ($sp)
	lw $a0, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra