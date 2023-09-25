#assignment 4c
.text
	addi $s1, $zero, -4
	addi $s2, $zero, 3
	start:
	add $s1, $s1, $s2 # s1 = i + j
	slt $t0,$zero, $s1 # s1 < 0 ( i + j > 0 ) => t0 = 1 else t0 = 0  
	bne $t0,$zero,else # if t0 != 0 (i + j > 0) -> else
	addi $t1,$t1,1 # x=x+1
	addi $t3,$zero,1 # z=1
	j endif # skip “else” part
	else: addi $t2,$t2,-1 # y=y-1
	add $t3,$t3,$t3 # z=2*z
	endif: