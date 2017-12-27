#simple calculator

#ask user to enter 2 numbers
#print sum, dif, prod and quot
.data
	numEnter:.asciiz "please enter a number: "
	sumResult: .asciiz "the sum is: "
	prodResult: .asciiz "the prod is: "

.text
.globl main
main:
	#prompt user to enter number
	li $v0, 4
	la $a0, numEnter
	syscall
	#get int from user
	li $v0, 5
	syscall
	move $t0, $v0
	
	#prompt user to enter number
	li $v0, 4
	syscall
	#get int from user
	li $v0, 5
	syscall
	move $t1, $v0
	
	add $t2, $0, $t1
	#print sum
	li $v0, 4
	la $a0, sumResult
	syscall
	
	li $v0, 1
	move $a0, $t2,
	syscall
	
	mult $t0, $1
	li $v0, 4
	la $a0, prodResult
	syscall
	mflo $t2
	
	li $v0, 1
	move $a0, $t2
	
	li $v0, 10
	syscall