#Adrian Davila - 37%
#Kevin Portocarrero - 30%
#Ryan Gonzalez - 33%


.data
userInput: .asciiz "Please input a value: " 
newLine: .asciiz "\n"
tab: .asciiz "\t" 

.text

.globl main
main: 
	#Asks and stores value inputed by user into $t0 
	li $v0, 4
	la $a0, userInput
	syscall
	li $v0, 5
	syscall
	
	move $s0, $v0
	
	mul $s1, $s0, $s0
	mul $s2, $s1, 4
	move $a0, $s2
	li $v0, 9
	syscall
	
#	li $v0, 1
#	move $a0, $t7
#	syscall	
	
	li $t0, 0 	# Row Counter
	li $t5, 0	# index counter
startRow: 
	bge $t0, $s0, endRow
	addi $t0, $t0, 1
	li $t1, 0 
startCol: 
	bge $t1, $s0, endCol
	addi $t1, $t1, 1
	mult $t1, $t0
	mflo $t2
	li $v0, 1 
	la $a0, ($t2) 
	syscall
	li $v0, 4
	la $a0, tab
	syscall 
	j startCol
endCol: 
	li $v0, 4 
	la $a0, newLine 
	syscall 
	j startRow
endRow: 
