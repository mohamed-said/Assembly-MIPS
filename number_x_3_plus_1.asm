.data

message_0: .asciiz "Please Enter a number: \n"
message_1: .asciiz "Number of Operations = "
line: .asciiz "\n"

.text

.globl main

main:

  li $v0, 4
  la $a0, message_0
  syscall
  
  li $v0, 5
  syscall
  
  # Essentials 
  add $s0, $0, $v0      #now s0 has the input inteher
  li $t1, 1
  li $t2, 2
  li $t3, 3
  li $s1, 0             #counter
  #################

  loop:
    and $t0, $s0, $t1   # operation to check if even or odd 
    beq $t0, $0, even_operation
    mul $s0, $s0, $t3   # variable *= 3
    add $s0, $s0, $t1   # variable += 1
    #####################
    li $v0, 1
    add $a0, $s0, $0
    syscall
    
    li $v0, 4
    la $a0, line
    syscall
    ####################   
    add $s1, $s1, $t1   # counter++
    beq $s0, 1, end_loop
    j loop

  even_operation:
    div $s0, $s0, $t2   # variable /= 2
    ###################
    li $v0, 1
    add $a0, $s0, $0
    syscall 
    li $v0, 4
    la $a0, line
    syscall
    ###################   
    add $s1, $s1, $t1   # counter++
    beq $s0, 1, end_loop
    j loop
    
  end_loop:

    li $v0, 4
    la $a0, message_1
    syscall

    li $v0, 1
    add $a0, $0, $s1
    syscall

    li $v0, 10
    syscall

.end main
