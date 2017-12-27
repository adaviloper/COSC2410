	.data
beep:	.word 120
dur:	.word 1000
vol:	.word 100
	.text
	.globl main
main:
	li $v0, 31
	la $a0, beep
	lw $a0, 0($a0)
	la $a1, dur
	lw $a1, 0($a1)
	la $a3, vol
	lw $a3, 0($a3)
	syscall
	
	li $v0, 10
	syscall