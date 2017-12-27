.text #code
.globl main
main:
	add $t1, $0, 10
	add $t2, $0, 11
	add $t3, $t1, $t1
	add $t3, $t3, $t1
	add $t3, $t3, $t1
	add $t3, $t3, $t2
	add $t3, $t3, $t2
	li $v0, 10
	syscall
