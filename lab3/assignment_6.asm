#assignment 6
.data
	A: .word -3, -1, -4, 4, 0, 6, -7, 9, 8
.text
	li $s0, 0 #max
	li $s1, -1 #i
	la $s2, A #t2 store the address of A
	li $s3, 9 #number of elements of A (n)
	li $s4, 1 #step
	
	loop: 	add $s1,$s1,$s4 #i=i+step 
	add $t1,$s1,$s1 #t1=2*s1
	add $t1,$t1,$t1 #t1=4*s1
	add $t1,$t1,$s2 #t1 store the address of A[i]
	lw $t0,0($t1) #load value of A[i] in $t0:  t0 = A[i]
	
	#lay tri tuyet doi
	start:
	slt $t4,$zero,$t0 # A[i] duong => t4 = 1 else am => t4 = 0
	beq $t4,$zero,else # if t4 = 0 (A[i] la so am) -> else
	j endif
	else: mul $t0,$t0,-1	
	endif:
	
	#cap nhat max
	startt:
	slt $t5,$t0,$s0 # a[i] < max => t5 = 1
	beq $t5,$zero,elsee
	j endiff
	elsee: add $s0,$t0,$zero
	endiff:
	
	slt $t3,$s3,$s1 # n < i => t3 = 1
	beq $t3,0,loop #if i <= n, goto loop
	
	
