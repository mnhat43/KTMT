#Lab 4, Assignment 4
.text
	addi $s1,$zero, 0x7fffffff
	addi $s2,$zero, 3
	li $t0,0 #No Overflow is default status
	addu $s0, $s1, $s2    
	xor $t1, $s1, $s2    
	bltz $t1, EXIT #nếu t1 < 0 ( nghĩa là 2 số trái dấu ) => nhảy tới exit

	xor $t2, $s0, $s1    
	bltz $t2, OVERFLOW #nếu t2 < 0 ( nghĩa là 2 số trái dấu ) => Tràn 
	j EXIT
	           
	OVERFLOW:
	li $t0, 1
	j EXIT

	EXIT:
