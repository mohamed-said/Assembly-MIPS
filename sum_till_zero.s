.data

.text

main:

  loop:
    li $v0, 5
    syscall 
    move $t0, $v0
    beq $t0, $0, EXIT
    add $s0, $s0, $t0
    j loop

  EXIT:
    move $a0, $s0
    li $v0, 1
    syscall

  li $v0, 10
  syscall
