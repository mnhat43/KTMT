# Lab 6, assignment 3
.data
	A: .word 8,2,4,6,1,3,10,7,9,5,12,13,11
	Aend: .word
.text
main: 	
	li $a2, 12		#a2 = n - 1
	la $a0, A 		#$a0 = Address(A[0])
	la $a1,Aend
 	addi $a1,$a1,-4 	#$a1 = Address(A[n-1])
 	j sort 			#sort
after_sort: 
	li $v0, 10 #exit
 	syscall
end_main:

sort:
   	li $s0, 0	# i = 0
   	addi $t0, $a0, 0	# s0 = j = 0

   loop_j:
   	mul $s1, $s0, 4
   	sub $t3, $a1, $s1 	#t3 = n-i-1 
   	beq $t0, $t3, end_loop_j	#nếu t0 = t3 ( j = n-i-1 ) thì kết thúc vòng lặp j, tăng i
   	
   	lw $t1, 0($t0)	# t1 = A[j]
   	lw $t2, 4($t0)	# t2 = A[j+1}
   	
   	slt $t5, $t1, $t2 # nếu t1 < t2 ( a[j] < a[j+1] => t5 = 1
   	bne $t5, $zero, no_swap
   	
   	#swap
   	sw $t1, 4($t0)
   	sw $t2, 0($t0)
   	
   	no_swap:
   	addi $t0, $t0, 4 #j++
   	j loop_j
   end_loop_j:
   
   loop_i:
	addi $s0, $s0, 1	# i += 1
   	slt $t4, $s0, $a2	# nếu i < n thì t4 = 1
   	beq $t4, $zero, end_loop_i
   	addi $t0, $a0, 0	# s0 = j = 0
   	j loop_j
   end_loop_i:
   
   	j after_sort

 