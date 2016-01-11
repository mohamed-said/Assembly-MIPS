.data
str: .asciiz "Enter Base (b): "
str1: .asciiz "Enter Power (p): "
str2: .asciiz " b to the power of p is: "

.text


.globl main

main:
    la $a0,str
    li $v0,4
    syscall
    
    li $v0,5
    syscall
    
    move $t0,$v0
    
    la $a0,str1
    li $v0,4
    syscall
    
    li $v0,5
    syscall
    
    move $a1,$v0    #$a1=N    
    move $a0, $t0    #$a0=X
    jal Power
    
    move $s0,$v0
    
    la $a0,str2
    li $v0,4
    syscall
    
    move $a0,$s0
    
    li $v0,1
    syscall
    
    li $v0,10
    syscall
    
.end main


Power: 
    addi $sp,$sp,-4

    sw $ra,0($sp)
    
    bne $a1,$zero, Else
    addi $v0,$zero,1
    addi $sp, $sp,4
    
    jr $ra
    
    Else:
        bne $a1,1, Else1
        add $v0,$zero, $a0
        addi $sp,$sp,4
        jr $ra

    Else1:
        move $t1,$a1
        andi $t0, $t1,1        #check if N is even or odd
        bne $t0,$zero, Else2    #odd goto Else2
        srl $a1, $a1,1        #even N/2
        jal Power        #recursive
        mul $v0,$v0,$v0        # Power(x,n/2)*Power(x,n/2)
        lw $ra, 0($sp)
        addi $sp,$sp,4
        jr $ra

    Else2:
        addi $a1,$a1,-1        #odd X*power(x,n-1)
        jal Power
        lw $ra, 0($sp)
        addi $sp,$sp,4
        mul $v0,$v0,$a0
        jr $ra
