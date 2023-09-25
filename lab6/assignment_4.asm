# Lab 6, assignment 4
.data
	A: .word 8,2,4,6,1,3,10,7,9,5,12,13,11
.text
#void insertionSort(int *a, int n){
#    for(int i=1; i < n; i++){   
#        int x = a[i], pos = i-1;
#        while(pos >= 0 && x < a[pos]){
#            a[pos+1] = a[pos];
#            pos--;
#        }
#        a[pos+1] = x;
#    }
#}

main: 	
	li $a2, 13		#a2 = n
	la $a0, A 		#$a0 = Address(A[0])
 	j sort 			#sort
after_sort: 
	li $v0, 10 #exit
 	syscall
end_main:

sort:
	li $t1, 0	# t1 = i = 0
	addi $t0, $a0, 0 # t0 = *a[0]	
for: 
	addi $t1, $t1, 1 # i++
	addi $t0, $t0, 4
	beq $t1, $a2, endFor	# i = n => end
	
	lw $t2, 0($t0)	# t2 = A[i]	x = a[i]
	addi $t3, $t1, -1 #t3 = i-1	pos = i-1
	addi $t5, $t0, 0
  while:
	blt $t3, $zero, endWhile #pos < 0 -> end
	
	lw $t4, -4($t5)  #t4 = A[pos]
	
	# x < a[pos]-> s1 = 1
	slt $s1, $t2, $t4
	beq $s1, $zero, endWhile

	#a[pos+1] = a[pos]
	sw $t4, 0($t5)
	addi $t5, $t5, -4
	addi $t3, $t3, -1	
	j while
  endWhile: 
  	sw $t2, 0($t5)
	j for
endFor:
	j after_sort
