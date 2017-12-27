	.data
eol:	.asciiz "\n"
input:	.asciiz ">>>"
	.align 2
num:	.word 0 # stores user's choice
fib:	.word 0 # stores fibonacci number
luc:	.word 0 # stores lucas number
	.text
	.globl main
main:				# start program course
	li $t2, 2
	li $t5, 5
	
	la $a0, input		# spit out prompt
	jal display_str
	
	li $v0, 5		# read number
	syscall
	sw $v0, num
	
	
	lw $a0, num		
	lw $t0, num
	jal recFib		# get num-th fibonacci number
	sw $v0, fib
	
	lw $a0, num
	lw $t0, num
	jal recLucas		# get num-th lucas number
	sw $v0, luc
	
	la $a0, eol		# start printing results
	jal display_str
	
	la $a0, fib
	jal display_int
	
	la $a0, eol
	jal display_str
	
	la $a0, luc
	jal display_int		# end printing results
	
	li $v0, 10
	syscall			# exit program

# rec_fib($a0 = n): return n-th fibonacci number
recFib:
	# enter code below here
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, ($sp)
	
	# push a register to use as a return of fib(a-1)
	addi $sp, $sp, -4
	sw $s0, ($sp)
	
	blez $a0, fibRetZero				# n = 0, get zero
		li $t0, 1
		beq $a0, $t0, fibRetOne			# n = 1, get one
			li $t0, 2
			beq $a0, $t0, fibRetOne		# n = 2, get one
				lw $a0, 4($sp)		# else, load argument
				addi $a0, $a0, -1	# decrement
				jal recLucas		# call recLucas with n - 1
				move $s0, $v0
				
				lw $a0, 4($sp)		# reload n
				addi $a0, $a0, 1	# increment
				jal recLucas		# call recLucas with n + 1
				add $v0, $v0, $s0	# add values of both calls
				
				div $v0, $t5		# divide sum by 5
				mflo $v0
				j fibReturn
fibRetZero:
	li $v0, 0		# return 0
	j fibReturn
fibRetOne:
	li $v0, 1		# retun 1
	j fibReturn
fibReturn:
	lw $s0, ($sp)		# pop stack and return
	lw $a0, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra

	
# rec_lucas($a0): return ($a0)-th lucas number
recLucas:
	# enter code below here
	div $a0, $t2			# start calc of m and n
	mflo $t3
	mfhi $t4
	add $t4 $t4, $t3		# end calc of m and n
	
	addi $sp, $sp, -28		# start prep of stack
	sw $ra, 24($sp)
	sw $s1, 20($sp)
	sw $s2, 16($sp)	
	sw $s3, 12($sp)
	sw $a0, 8($sp)
	sw $t3, 4($sp)
	sw $t4, ($sp)			# end prep of stack
	
	# push a register to use as a return of luc(a-1)
	blez $a0, lucasRetTwo
		li $t0, 1
		beq $a0, $t0, lucasRetOne
			li $t0, 2
			beq $a0, $t0, lucasRetThree
				lw $a0, 4($sp)		# loads m
				addi $a0, $a0, 1	# adds 1 to m
				jal recLucas		# recursive call to recLucas with m as new argument
				move $s1, $v0		# stores result in $s1
				
				lw $a0, ($sp)		# loads n
				jal recFib		# recursive call to recFib with n as new argument
				move $s2, $v0		# save result in $s2
				
				mult $s1, $s2		# multiply $s1, $s2
				mflo $s1		# move result to $s1
				
				lw $a0, 4($sp)		# reload m
				jal recLucas		# recursive call to recLucas with m as new argument
				move $s3, $v0		# stores result in $s3
				
				lw $a0, ($sp)		# loads n
				addi $a0, $a0, -1	# subtract 1 to n
				jal recFib		# recursive call to recFib with n-1 as new argument
				mult $v0, $s3		# multiply result of previous recFib call with $s3
				mflo $v0		# move result to $v0
				
				add $v0, $v0, $s1	# add $v0, and $s1
				j lucasReturn
lucasRetTwo:		# returns 2
	li $v0, 2
	j lucasReturn
lucasRetOne:		# returns 1
	li $v0, 1
	j lucasReturn
lucasRetThree:		# returns 3
	li $v0, 3
	j lucasReturn
lucasReturn:
	# Pops all values in the stack into the correct registers and returns
	lw $t4, ($sp)
	lw $t3, 4($sp)
	lw $a0, 8($sp)
	lw $s3, 12($sp)
	lw $s2, 16($sp)
	lw $s1, 20($sp)
	lw $ra, 24($sp)
	addi $sp, $sp, 28
	jr $ra
	
display_str: # $a0: address of the string to display
	li $v0, 4
	syscall
	jr $ra
display_int: # $a0: the ADDRESS of the int value to display
	lw $a0, ($a0)
	li $v0, 1
	syscall
	jr $ra
