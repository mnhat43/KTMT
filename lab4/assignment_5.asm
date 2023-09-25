#Lab 4, Assignment 5
.text
	li $s1, 3
	li $s2, 23
	li $s0, 0
	li $t0, 1  # mask: 000..001
	li $t3, -1
	li $t4, 32
	LOOP:
	addi $t3, $t3, 1
	beq $t3, $t4, END_LOOP
	
	and $t1, $s2, $t0
	bne $t1, $zero, MUL
	j return

	MUL:
	sllv $t2, $s1, $t3
	add $s0, $s0, $t2
	
	return:
	sll $t0,$t0,1
	j LOOP
	
	END_LOOP:

