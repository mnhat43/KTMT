# LAB 5, assignment 3 
.data 
	z: .asciiz "Nhap chuoi: "
	x: .space 100		# string x, empty
	y: .space 100		# string y variable
.text 
   main:
	li $v0, 4
	la $a0, z
	syscall 
	
	li $v0, 8		# v0 = 8 -> đọc chuỗi
	la $a0, y 		# a0: chứa địa chỉ của y
	la $a1, 100		# a1: chứa độ dài tối đa
	syscall	
		
	la $a3, x 		# a0: chứa địa chỉ của x	
	strcpy:	
	add $s0 , $zero , $zero# s0 = i = 0
	
	L1:  
	add $t1,$s0, $a0 	# t1 = s0 + a0 = i + y[0]
				#    = address of y[i]
	lb $t2, 0($t1)		# t2 = value at y[i]
	add $t3, $s0, $a3 	# t3 = s0 + a3 = i + x[0]
				#    = address of x[i]
	sb $t2, 0($t3)		# x[i] = value at y[i] 
	beq $t2, $zero ,end	# if y[i] == 0, exit 
	nop 	
	addi $s0, $s0,1 	# s0 = s0 + 1
	j L1			# next character  
	end: 
	li $v0,4 
	move $a0, $a3		# in ra gia tri thanh ghi a3 
	syscall