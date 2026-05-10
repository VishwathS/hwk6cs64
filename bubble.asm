# print_array.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0, $a1
#   make all returned values from functions go in $v0

# Example array and alen - your code should work for any integer array of any length > 1.
.data
    array:  .word 6, 4, 0, 1, 2, 9, 3, 5, 8, 7
    alen:   .word 10
    newline: .asciiz "\n"
    space:  .asciiz " "

.text
bubble:
	move $t8, $a0          # keep array base address
	lw $t0, 0($a1)         # load size
	addi $t1, $t0, -1      # i = size - 1

outerLoop:
    blt $t1, $zero, bubbleComplete
    li $t2, 1             # j = 1

innerLoop:
	bgt $t2, $t1, next

	addi $t3, $t2, -1
	sll $t4, $t3, 2
	addu $t4, $t8, $t4

	sll $t5, $t2, 2
	addu $t5, $t8, $t5

	lw $t6, 0($t4)
	lw $t7, 0($t5)

	ble $t6, $t7, noSwap

	sw $t7, 0($t4)
	sw $t6, 0($t5)

noSwap:
	addi $t2, $t2, 1
	j innerLoop

next:
	addi $t1, $t1, -1
	j outerLoop

bubbleComplete:
	jr $ra


printArray:
	move $t7, $a0          # keep array base address
	lw $t0, 0($a1)         # load size
	li $t1, 0              # i = 0

printLoop:
	bge $t1, $t0, printNewline

	sll $t2, $t1, 2
	addu $t2, $t7, $t2

	lw $t3, 0($t2)

	move $a0, $t3
	li $v0, 1
	syscall

	la $a0, space
	li $v0, 4
	syscall

	addi $t1, $t1, 1
	j printLoop

printNewline:
	la $a0, newline
	li $v0, 4
	syscall
	jr $ra

main:
    la $a0, array
    la $a1, alen
    jal printArray

    la $a0, array
    la $a1, alen
    jal bubble

    la $a0, array
    la $a1, alen
    jal printArray

    li $v0, 10
    syscall