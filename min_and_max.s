

.data


array_elements: .word 2, 2, 3, 4, 5, 50, 7, 8, 9, 10

line: .asciiz "\n"

.text

.globl main

main:

  li $s0, 10                  # now #s0 holding 10 ,, the size of the array
  
  la $t0, array_elements      # now $t0 is holding the array

 
  add $s1, $0, $0             # iterator
  
  li $t5, -1                  # max
  li $t6, 100                 # min

  max_loop:
    slt $t1, $s1, $s0
    beq $t1, $zero, end_loop
    sll $t2, $s1, 2
    add $t3, $t0, $t2
    lw $s2, 0($t3)
    addi $s1, $s1, 1
    bgt $s2, $t5, set_max
    j max_loop
  
  set_max:
    add $t5, $s2, $0
    j max_loop

  end_loop:
    add $a0, $0, $t5
    li $v0, 1
    syscall

  la $a0, line
  li $v0, 4
  syscall

  
  ###############

  la $t0, array_elements
  add $s1, $0, $0
  
  min_loop:
    slt $t1, $s1, $s0
    beq $t1, $zero, end_loop_2
    sll $t2, $s1, 2
    add $t3, $t2, $t0
    lw $s2, 0($t3)
    addi $s1, $s1, 1
    blt $s2, $t6, set_min
    j min_loop

  set_min:
    add $t6, $s2, $0
    j min_loop

  end_loop_2:
    add $a0, $t6, 0
    li $v0, 1
    syscall 

  exit:
    li $v0, 10
    syscall
 

.end main    






