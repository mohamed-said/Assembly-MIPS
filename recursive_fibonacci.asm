.data

	inputMsg: 			.asciiz "Enter number: \n"
	resultMessage:  .asciiz "Result is: "
	newLine:  			.asciiz "\n"
	number: 				.word 0
	result:					.word 0
.text

main:
    la $a0, inputMsg        #Print out inputMsg
    li $v0, 4
    syscall

    li $v0, 5           # Read an integer into v0
    syscall

		sw $v0, number
		
		lw $a0, number
		jal fibonacci
		
print:
	sw $v0, result
	
	li $v0, 4
	la $a0, resultMessage
	syscall
	
	li $v0, 1
	lw $a0, result
	syscall		
		
exit:       
    li, $v0, 10         #Exit Program
    syscall

.end main

fibonacci:
	addi $sp, $sp, -8 	# room for $ra and one temporary
	sw $ra, 4($sp) 			# save $ra
	move $v0, $a0 			# pre-load return value as n
	blt $a0, 2, return  # if(n < 2) return n
	sw $a0, 0($sp) 			# save a copy of n
	
	addi $a0, $a0, -1   # n - 1	
	jal fibonacci 			# fib(n - 1)
	
	lw $a0, 0($sp)      # retrieve n
	sw $v0, 0($sp) 			# save result of fib(n - 1)
	
	addi $a0, $a0, -2 	# n - 2
	jal fibonacci	      # fib(n - 2)
	
	lw $v1, 0($sp) 			# retrieve fib(n - 1)
	add $v0, $v0, $v1 	# fib(n - 1) + fib(n - 2)
	
return: 
	lw $ra, 4($sp) 		  # restore $ra
	addi $sp, $sp, 8 		# restore $sp
	jr $ra 							# back to caller
	
