#Lab 7, Assignment 5
.data
	Message1: .asciiz "Lon nhat: "
	Message2: .asciiz "Nho nhat: "
	space: .asciiz ", "
	newline: .asciiz "\n"
.text
main:
	li $s0, 1
	li $s1, 5
	li $s2, -3
	li $s3, -7
	li $s4, 7
	li $s5, -6
	li $s6, 9
	li $s7, 1
	jal MINMAX
	
print:
	addi $t0, $a0, 0
	addi $t1, $a1, 0
	addi $t2, $a2, 0
	addi $t3, $a3, 0
	li $v0, 4
	la $a0, Message1
	syscall
	li $v0, 1
	addi $a0, $t2, 0
	syscall
	li $v0, 4
	la $a0, space
	syscall
	li $v0, 1
	addi $a0, $t3, 0
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	la $a0, Message2
	syscall
	li $v0, 1
	addi $a0, $t0, 0
	syscall
	li $v0, 4
	la $a0, space
	syscall
	li $v0, 1
	addi $a0, $t1, 0
	syscall
quit:	li $v0, 10
	syscall
	
MINMAX:
	addi $sp, $sp, -8
	sw $fp, 4($sp)
	sw $ra, 0($sp)
push_to_stack:
	addi $a0, $zero, 1000 #min
	addi $a1, $zero, -1 #min position
	addi $a2, $zero, -1000 #max
	addi $a3, $zero, -1 #max position
	addi $sp, $sp, -48
	sw $s7, 44($sp)
	sw $s6, 40($sp)
	sw $s5, 36($sp)
	sw $s4, 32($sp)
	sw $s3, 28($sp)
	sw $s2, 24($sp)
	sw $s1, 20($sp)
	sw $s0, 16($sp)
	sw $a0, 12($sp)
	sw $a1, 8($sp)
	sw $a2, 4($sp)
	sw $a3, 0($sp)
	
	addi $t0, $zero, -1
loop:
	addi $t0, $t0, 1 #t0 is loop counter
	beq $t0, 8, MINMAX_done
	jal compare
	nop
j loop
	nop
compare:
	lw $a3, 0($sp)
	lw $a2, 4($sp)
	lw $a1, 8($sp)
	lw $a0, 12($sp)
	lw $t1, 16($sp) #t1 is the current value to compare
	addi $sp, $sp, 20
compare_min:
	sub $t2, $t1, $a0 #compare with min
	slti $t2, $t2, 0
	beqz $t2, compare_max
	addi $a0, $t1, 0
	addi $a1, $t0, 0
compare_max:
	sub $t2, $t1, $a2 #compare with max
	sgt $t2, $t2, 0
	beqz $t2, compare_done
	addi $a2, $t1, 0
	addi $a3, $t0, 0
compare_done:
	addi $sp, $sp, -16 #push results back to stack
	sw $a0, 12($sp)
	sw $a1, 8($sp)
	sw $a2, 4($sp)
	sw $a3, 0($sp)
	jr $ra
MINMAX_done:
	lw $a3, 0($sp)
	lw $a2, 4($sp)
	lw $a1, 8($sp)
	lw $a0, 12($sp)
	lw $ra, 16($sp)
	lw $fp, 20($sp)
	addi $sp, $sp, 24
	jr $ra
