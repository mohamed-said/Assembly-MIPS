.data
	message_1: .asciiz "Enter a number: \n"
	message_2: .asciiz "Factorial is: "
	newLine:   .asciiz "\n"
	number: 	 .word 0
	answer:    .word 0
.text

.globl main
main:
	# Enter a number message
	li $v0, 4
	la $a0, message_1
	syscall
	
	
	# read an integer
	li $v0, 5
	syscall
	
	# store the input value in memory
	sw $v0, number
	
	# load the input value from memory into the parameter register
	lw $a0, number
	
	# call the function getFactorial
	jal getFactorial
	
	# store the returned value to the memory
	sw $v0, answer
	
	
	# print result message
	li $v0, 4
	la $a0, message_2
	syscall
	
	# print the result
	li $v0, 1
	lw $a0, answer
	syscall
	
	# terminate the program
	li $v0, 10
	syscall
	
.end main
#####################################

.globl getFactorial

getFactorial:
	sub $sp, $sp, 8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	li $v0, 1
	beq $a0, 0, return
	
	move $s0, $a0
	sub $a0, $a0, 1
	jal getFactorial
	
	mul $v0, $v0, $s0
	
return:
	lw  $ra, 0($sp)
	lw  $s0, 4($sp)
	add $sp, $sp, 8	
	jr  $ra

.end getFactorial
