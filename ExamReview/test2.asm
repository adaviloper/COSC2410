	.data
prompt:	.asciiz "\nPlease enter a number: "
expReq:	.asciiz "\nPlease enter the power: "
result:	.asciiz "\nThe result is: "

	.text
	.globl main
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	li $v0, 4
	la $a0, expReq
	syscall
	
	li $v0, 5
	syscall
	
	la $a0, ($s0)
	la $a1, ($v0)
	jal power
	move $s0, $v0
	
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 1
	la $a0, ($s0)
	syscall
	
end:
	li $v0, 10
	syscall
	
power:
	li $t2, 1
	move $t0, $a0
	move $t1, $a1
	startLoop:
		beqz $t1, endLoop
		mul $t2, $t2, $t0
		addi $t1, $t1, -1
		j startLoop
	endLoop:
		move $v0, $t2
		jr $ra
		