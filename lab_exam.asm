.data

array: 			.word 11, 5, 2, 9, 22, 45, 56, 100, 101, 54
arrLength:  .word 10
line: 			.asciiz "\n"
.text

.globl main

main:
	la $a0, array
	lw $a1, arrLength
	
	jal replace_odd_array
	
   la $t0, array
   lw $s0, arrLength
   li $s1, 0
   li $s5, 1
  
   print:
     slt $t1, $s1, $s0
     beq $t1, $zero, EXIT 
     sll $t2, $s1, 2
     add $t3, $t0, $t2
     lw $a0, 0($t3)
     li $v0, 1 
     syscall
     li $v0, 4
     la $a0, line
     syscall
     add $s1, $s1, $s5
     j print


EXIT:
	li $v0, 10
	syscall

.end main


replace_odd_array:
	sub $sp, $sp, 4
	sw  $ra, 0($sp)
	li  $s0, 0 		#iterator
	loop:
		la $a0, array
		slt $t1, $s0, $a1
		beq $t1, 0, end_replace_odd
		sll $t2, $s0, 2
		add $t3, $t2, $a0
		lw  $t4, 0($t3)
		move $a0, $t4
		jal is_odd
		beq $v0, 1, replace_word
		add $s0, $s0, 1
		j loop
		
			
replace_word:
	li $t6, 0
	sw $t6, 0($t3)
	add $s0, $s0, 1
	j loop 		
			
end_replace_odd:
	lw $ra, 0($sp)
	add $sp, $sp, 4
	jr $ra

is_odd:
	sub $sp, $sp, 4
	sw $ra, 0($sp)
	and $v0, $a0, 1
	lw $ra, 0($sp)
	add $sp, $sp, 4
	jr $ra
	
