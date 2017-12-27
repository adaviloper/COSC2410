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
	
	move $s0, $v0		# store value entered by user in $s0
	
	jal makeTable		# call to build the table
	jal prettyPrintTable	# call to print the table
	
	li $v0, 10		# end the program
	syscall
	
makeTable:
	mul $s1, $s0, $s0
	mul $s2, $s1, 4
	la $a0, ($s2)
	li $v0, 9
	syscall
	
	move $s3, $v0
	
	li $t0, 0 	# Row Counter
	li $t5, 0	# index counter
	startRow: 				# start multiplication
		bge $t0, $s0, endRow
		addi $t0, $t0, 1		# increment row counter
		li $t1, 0 
	startCol: 
		bge $t1, $s0, endCol		# jumps to next row if condition is false
		addi $t1, $t1, 1		# increment col counter
		mult $t1, $t0			# multiply row * col
		mflo $t2			# store prod in $t2
		
		mul $t6, $t5, 4			# get index of next available
		add $t6, $s3, $t6		# slot in heap array
		sw $t2, ($t6)			# store prod ($t2) in index of array
		addi $t5, $t5, 1		# increment index counter
		
		j startCol
	endCol: 
		j startRow
	endRow: 
		jr $ra				# return to main

prettyPrintTable:
	li $t0, 0					# set row counter to 0
	li $t5, 0					# set index counter to zero
	printRow:
		bge $t0, $s0, endPrintRow		
		addi $t0, $t0, 1			# increment row counter
		li $t1, 0				# set col counter to 0
		printCol:
			bge $t1, $s0, endPrintCol
			addi $t1, $t1, 1		# increment col counter
			
			mul $t6, $t5, 4			# get index of next available
			add $t6, $s3, $t6		# slot in heap array
			li $v0, 1 			# prep to print an int
			lw $a0, ($t6)			# load word from array into $a0
			syscall
			addi $t5, $t5, 1		# increment index counter
			
			li $v0, 4			# prep to print string
			la $a0, tab			# print a tab after every integer
			syscall
			j printCol
		endPrintCol:
			li $v0, 4			# prep to print string
			la $a0, newLine			# print a \n when row fiinishes
			syscall
			j printRow
	endPrintRow:
		jr $ra					# jump back to main