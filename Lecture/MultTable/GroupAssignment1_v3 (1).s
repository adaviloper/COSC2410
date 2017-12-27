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
	la $a0, ($s2)
	li $v0, 9
	syscall
	
	move $s3, $v0
	
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
	
	mul $t6, $t5, 4
	add $t6, $s3, $t6
	sw $t2, ($t6)
	li $v0, 1 
	lw $a0, ($t6)
	syscall
	addi $t5, $t5, 1
	
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

li $v0, 10
syscall
