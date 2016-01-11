.data

arrSize: .word 10
arrElements: .word 10,4,5,6,10,7,8,9,5,10
my_message: .asciiz"Found at: "
line: 		.asciiz "\n"

.text
.globl main

main:   

	la $t0,arrSize        
	lw $s0, 0($t0)    #s0 = 10
	la $t0,arrElements    
	add $s1,$0,$0 	 # i = 0
	li $t5, 5		 # target 
	li $t4, 0		 # boolean if found  

	loop: 
		slt $t2,$s1,$s0  
		beq $t2,$zero,end_loop    
    	sll $t1,$s1,2           
		add $t3,$t0,$t1         
		lw  $s2, 0($t3)         
		bne $t5,$s2,continue #if arr element != target continue		
		la $a0,my_message
		li $v0,4
		syscall 		
		move $a0, $s1
		li $t4, 1 # set boolean to true
		li $v0, 1
		syscall
		la $a0,line
		li $v0,4
		syscall 		
		
	continue:
		addi $s1,$s1,1
	j loop  
	end_loop: 

	bne $t4,$zero,EXIT
		li $a0, -1
		li $v0, 1
		syscall  

	EXIT:
		li $v0,10
		syscall

.end main







