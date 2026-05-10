# calculation.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a-registers
#   make all returned values from functions go in $v0

.text
remove:
    # b -= a
    sub $v0, $a1, $a0
    jr $ra

calc:
    # save registers
    addi $sp, $sp, -24
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)

    move $s0, $a0
    move $s1, $a1
    move $s2, $a2

    li $s3, 5
    li $s4, 0

forLoop:
    bge $s4, $s2, calcDone

    # z = z - x + 2*y
    sll $t0, $s1, 1
    sub $s3, $s3, $s0
    add $s3, $s3, $t0

    # if (x >= 2)
    slti $t1, $s0, 2
    bne $t1, $zero, skipRemove

    move $a0, $s0
    move $a1, $s1
    jal remove
    move $s1, $v0

skipRemove:
    addi $s0, $s0, 1
    addi $s4, $s4, 1

    j forLoop

calcDone:
    move $v0, $s3

    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    addi $sp, $sp, 24

    jr $ra
    
main:  # DO NOT MODIFY THE MAIN SECTION
    li $a0, 4
    li $a1, 10
    li $a2, 3

    jal calc

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall
