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
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $s0, 4($sp)

    move $t0, $a0   # x
    move $t1, $a1   # y
    move $t2, $a2   # n

    li $t3, 5   # z = 5
    li $t4, 0   # i = 0

forLoop:
    bge $t4, $t2, calcDone

    # z = z - x + 2*y
    sll $t5, $t1, 1
    sub $t3, $t3, $t0
    add $t3, $t3, $t5

    # if (x >= 2)
    blt $t0, 2, skipRemove

    move $a0, $t0
    move $a1, $t1
    jal remove
    move $t1, $v0

skipRemove:
    # x++
    addi $t0, $t0, 1
    # i++
    addi $t4, $t4, 1

    j forLoop

calcDone:
    move $v0, $t3

    lw $ra, 0($sp)
    lw $s0, 4($sp)
    addi $sp, $sp, 8

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