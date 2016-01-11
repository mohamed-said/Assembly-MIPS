.data

str: 		.asciiz "AbcdEfg"
size: 	.word 	7
res: 	.asciiz "number of small letters = "
line: 	.asciiz "\n"

.text

.globl main

main:

	la $a0, str
	lw $s1, size
	
	jal count_small_letters

	add $s3, $0, $v0
	
	li $v0, 4
	la $a0, res
	syscall
	
	add $a0, $0, $s3
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, line
	syscall
	
EXIT:
	li $v0, 10
	syscall	
	
.end main


count_small_letters:
	sub $sp, $sp, 4
	sw 	$ra, 0($sp)
	
	li $s0, 0 # iterator
	li $s2, 0 #counter
	
	loop:
		la $a0, str
		slt $t1, $s0, $s1
		beq $t1, 0, end_count_small_letters
		add $t3, $s0, $a0
		lb 	$t4, 0($t3)
		move $a0, $t4
		jal is_small
		beq $v0, 1, increment_counter
		add $s0, $s0, 1
		j loop

increment_counter:
	add $s2, $s2, 1
	add $s0, $s0, 1
	j loop

end_count_small_letters:
	lw $ra, 0($sp)
	add $sp, $sp, 4
	add $v0, $0, $s2	
	jr $ra

is_small:
	sub $sp, $sp, 4
	sw $ra, 0($sp)
	blt $a0, 97, return_false
	bgt $a0, 122, return_false

return_true:
	li $v0, 1
	j return

return_false:	
	li $v0, 0

return:
	lw $ra, 0($sp)
	add $sp, $sp, 4
	jr $ra
