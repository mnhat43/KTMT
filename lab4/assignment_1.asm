#Lab 4, Home Assignment 1
.text
	addi $s1,$zero, 0x7fffffff
	addi $s2,$zero, 10
	start:
	li $t0,0 #No Overflow is default status
	addu $s3,$s1,$s2 # s3 = s1 + s2
	xor $t1,$s1,$s2 #Test if $s1 and $s2 have the same sign
	bltz $t1,EXIT #nếu t1 < 0 ( nghĩa là 2 số trái dấu ) => nhảy tới exit
	
	slt $t2,$s3,$s1		# nếu s3 < s1 -> t2 = 1
	bltz $s1,NEGATIVE #Test if $s1 and $s2 is negative? 	ktra nếu s1 là số âm thì nhảy tới negative
	beq $t2,$zero,EXIT #s1 and $s2 are positive	 nếu t2 = 0 tức là s3 > s1 ->  nhảy tới exit
	 # if $s3 > $s1 then the result is not overflow
	j OVERFLOW
	
	NEGATIVE:
	bne $t2,$zero,EXIT #s1 and $s2 are negative
	 # if $s3 < $s1 then the result is not overflow
	OVERFLOW:
	li $t0,1 #the result is overflow
	
	EXIT:
