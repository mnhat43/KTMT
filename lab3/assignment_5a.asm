#assignment 5a
.data
	A: .word 1, 2, 3, 4, 5, 6, 7, 8, 9

.text
	li $s1, -1 #i
	la $s2, A #t2 store the address of A
	li $s3, 9 #number of elements of A (n)
	li $s4, 1 #step
	li $s5, 0 #sum
loop: 	add $s1,$s1,$s4 #i=i+step 
	add $t1,$s1,$s1 #t1=2*s1
	add $t1,$t1,$t1 #t1=4*s1
	add $t1,$t1,$s2 #t1 store the address of A[i]
	lw $t0,0($t1) #load value of A[i] in $t0:  t0 = A[i]
	add $s5,$s5,$t0 #sum=sum+A[i]
	slt $t3,$s1,$s3 # i < n => t3 = 1
	beq $t3,$zero,loop #if i != n, goto loop