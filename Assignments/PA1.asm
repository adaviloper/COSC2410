	.data
route:	.asciiz "\nPlease enter your choice: "
msgA:	.asciiz "\nEnter a value for A: "
msgB:	.asciiz "\nEnter a value for B: "
msgC:	.asciiz "\nEnter a value for C: "
result:	.asciiz "\nThe result is: Y = "
msg5:	.asciiz "no match! "
	.text
	.globl main
	# Inside main there are some calls (syscall) which will change the
	# value in register $ra which initially contains the return
	# address from main. This needs to be saved.
main:
	addi $s3, $0, 1
	addi $s4, $0, 2
	addi $s5, $0, 3
	addi $s6, $0, 4
	li $v0, 4
	la $a0, route		# prompt for program route
	syscall
	
	li $v0, 5		# read user option
	syscall
	move $t0, $v0	
	
	li $v0, 4
	la $a0, msgA		# prompt for val A
	syscall
	
	li $v0, 5		# read user option
	syscall
	move $s0, $v0
	
	li $v0, 4
	la $a0, msgB		# prompt for val B
	syscall
	
	li $v0, 5		# read user option
	syscall
	move $s1, $v0
	
	li $v0, 4
	la $a0, msgC		# prompt for val C
	syscall
	
	li $v0, 5		# read user option
	syscall
	move $s2, $v0
	
	beq $t0, 1, optOne
		beq $t0, 2, optTwo
			beq $t0, 3, optThree
				beq $t0, 4, optFour
					la $a0, msg5
					li $v0, 4
					syscall
					j exit
optOne:
	la $a0, result
	li $v0, 4
	syscall
	
	mult $s0, $s5		# 3A
	mflo $t1
	add $t2, $t1, $s1	#3A + B
	mult $t2, $s4		#(3A + B) * 2
	mflo $t3
	mult $t3, $s2		#(3A + B) * 2 * C
	mflo $t4
	mult $t4, $s4		#2 * (3A + B) * 2 * C
	mflo $t5
	
	li $v0, 1
	la $a0, ($t5)
	syscall
	
	j exit
optTwo:
	la $a0, result
	li $v0, 4
	syscall
	
	add $t1, $s0, $s2	# A + C
	sub $t2, $t1, 1		# A + C - 1
	mult $t2, $s6		# 4 (A + C - 1)
	mflo $t3		# op 1
	div $s1, $s4		# (B / 2)
	mflo $t4		# op 2
	sub $t5, $t3, $t4	# 4 (A + C - 1) - (B / 2)
	
	li $v0, 1
	la $a0, ($t5)
	syscall
	
	j exit
optThree:
	la $a0, result
	li $v0, 4
	syscall
	
	add $t1, $s0, $s1	# A + B
	add $t2, $t1, 3		# (A + B + 3)
	sub $t3, $s2, 2		# C - 2
	mult $t2, $t3
	mflo $t4
	
	li $v0, 1
	la $a0, ($t4)
	syscall
	
	j exit
optFour:
	la $a0, result
	li $v0, 4
	syscall
	
	mult $s1, $s1		# B * B
	mflo $t1
	add $t2, $t1, 1		# (B * B) + 1
	div $s0, $t1		# A / (B * B) + 1
	mflo $t3
	div $t3, $s2		# (A / (B * B) + 1)/C
	mfhi $t4		# get remainder from abover operation
	
	li $v0, 1
	la $a0, ($t4)
	syscall
	
	j exit
exit:
	# restore now the return address in $ra and return from main
	li $v0, 10
	syscall
