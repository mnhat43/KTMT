# Lab 4, Assignment 3d
#  ble $s1,s2,L
.text
	li $s1, 3
	li $s2, 3
	slt $t1, $s2, $s1  # if s1 > s2 => t1 = 1
	beq $t1, $zero, L
	j EXIT
	
	L:
	
	EXIT: