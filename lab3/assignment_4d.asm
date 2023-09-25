#assignment 4d
.text
	addi $s1, $zero, -4 # i
	addi $s2, $zero, 3 # j	
	addi $s3, $zero, 2 # m
	addi $s4, $zero, -1 # n	  
	start:
	add $s1, $s1, $s2 # s1 = i + j
	add $s3, $s3, $s4 # s3 = m + n
	slt $t0,$s1, $s3 # s1 < s3 ( i + j < m + n ) => t0 = 1 else t0 = 0  
	bne $t0,$zero,else # if t0 != 0 (i + j < m + n) -> else
	addi $t1,$t1,1 # x=x+1
	addi $t3,$zero,1 # z=1
	j endif # skip “else” part
	else: addi $t2,$t2,-1 # y=y-1
	add $t3,$t3,$t3 # z=2*z
	endif: