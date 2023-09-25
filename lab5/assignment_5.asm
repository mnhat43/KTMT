#LAB 5, assignment 5
.data 
	string: .space 50 
	Message1: .asciiz "Nhap xau: "
	Message2: .asciiz "Xau dao nguoc la:  " 
	x: .space 50		# string x, empty
.text 
	main: 
	get_string: 
	li $v0 , 54 		# Nhap xau vao str 
	la $a0 , Message1		
	la $a1 , string		
	la $a2 , 50
	syscall 
	get_length: 
	la $a0 , string 	# a0 = address(str[0])
	xor $v1, $zero, $zero 	# v1 = length = 0
	xor $t0, $zero, $zero 	# t0 = i = 0
	check_char: 
	add $t1, $a0 , $t0	# t1 = a0 + t0 = address(str[0])
	lb $t2, 0($t1) 		# t2 = str[i]
	beq $t2, $zero , end_str# is null char -> exit
	addi $v1 , $v1 ,1	# length = length +1
	addi $t0, $t0, 1	# t0 = t0 + 1 -> i = i + 1
	j check_char 
	end_str:
	end_getlength:
	move $t4, $a0		# chuyen str sang o ghi t4
	inverse:
	addi $v1,$v1, -1	# tru phan tu NULL
	li $v0, 4
	la $a0, Message2
	syscall				
	strcpy:
	add $s0 , $zero , $zero	# i = 0
	la $a3, x 		# dua dia chi x vao thanh ghi a3

	L1:  
	add $t1,$v1, $t4 	# t1 = v1 + t4 =  str[length]
				#    = address of y[i]
	lb $t2, 0($t1)		# t2 = value at str[i]
	add $t3, $s0, $a3 	# t3 = s0 + a3 = i + x[0]
				#    = address of x[i]
	sb $t2, 0($t3)		# x[i] = value at y[i] 
	beq $t2, $zero ,end	# if y[i] == 0, exit 
	nop 
	addi $s0, $s0,1 	# s0 = s0 + 1
	addi $v1, $v1, -1	# v1 = v1 - 1
	j L1			# next character  
	end: 
	li $v0,4 
	move $a0, $a3		# in ra gia tri thanh ghi a3 
	syscall
