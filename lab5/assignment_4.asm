#LAB 5, assignment 4
.data 
	str: .space 20 
	Message1: .asciiz "Nhap xau: "
	Message2: .asciiz "Do dai la: " 
.text 
	main: 
	get_string: 
	li $v0 , 54 		# Nhap xau vao str 
	la $a0 , Message1		
	la $a1 , str		
	la $a2 , 50
	syscall 
	get_length: 
	la $a0 , str 		# a0 = address(str[0])
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
	print_length:
	li $v0 , 56
	la $a0, Message2
	move $a1, $v1
	syscall 
	li $v0, 10 
	syscall
