 .data
	Str1:  .asciiz  "**************                               *************   \n"
	Str2:  .asciiz  "*222222222222222*                           *3333333333333*  \n"
	Str3:  .asciiz  "*22222******222222*                         *33333********   \n"
	Str4:  .asciiz  "*22222*      *22222*                        *33333*          \n"
	Str5:  .asciiz  "*22222*       *22222*       *************   *33333********   \n"
	Str6:  .asciiz  "*22222*       *22222*     **11111*****111*  *3333333333333*  \n"
	Str7:  .asciiz  "*22222*       *22222*   **1111**       **   *33333********   \n"
	Str8:  .asciiz  "*22222*      *22222*    *1111*              *33333*          \n"
	Str9:  .asciiz  "*22222******222222*    *11111*              *33333********   \n"
	Str10: .asciiz  "*222222222222222*      *11111*              *3333333333333*  \n"
	Str11: .asciiz  "**************         *11111*               *************   \n"
	Str12: .asciiz  "                        *1111**                              \n"
	Str13: .asciiz  "                         *1111****   *****                   \n"
	Str14: .asciiz  "                          **111111***111*                    \n"
	Str15: .asciiz  "                            ***********     dce.hust.edu.vn  \n"
	
	Menu: 	.asciiz "------------ MENU -----------\n"
	Case_1:	.asciiz "1. Hien thi hinh anh\n"
	Case_2:	.asciiz "2. Hinh anh chi con vien \n"
	Case_3:	.asciiz "3. Hoan doi vi tri thanh ECD \n"
	Case_4:	.asciiz "4. Doi mau cho chu\n"
	Exit:	.asciiz "5. Thoat\n"
	
	Nhap:	.asciiz "Nhap gia tri: "
	Chu_D:	.asciiz "Nhap màu cho chu D(0->9): "
	Chu_C:	.asciiz "Nhap màu cho chu C(0->9): "
	Chu_E:	.asciiz "Nhap màu cho chu E(0->9): "
	NhapLai:.asciiz "Hay nhap gia tri tu 0 den 9 !!!\n"
	TheEnd: .asciiz "Thoat chuong trinh thanh cong !!!\n"

.text
#-------------- Hình ảnh chỉ còn viền --------------#
	li $t5, 50 #t5: màu ban đầu của chữ D (2)
	li $t6, 49 #t6: màu ban đầu của chữ C (1)
	li $t7, 51 #t7: màu ban đầu của chữ E (3)

main:
	la $a0, Menu
	li $v0, 4
	syscall	
	
	la $a0, Case_1	
	li $v0, 4
	syscall
	la $a0, Case_2
	li $v0, 4
	syscall
	la $a0, Case_3	
	li $v0, 4
	syscall
	la $a0, Case_4	
	li $v0, 4
	syscall
	la $a0, Exit	
	li $v0, 4
	syscall
	
	la $a0, Nhap	
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	
	Case1:
		addi $v1, $zero, 1
		bne $v0, $v1, Case2
		j Function_1
	Case2:
		addi $v1, $zero, 2
		bne $v0, $v1, Case3
		j Function_2
	Case3:
		addi $v1, $zero, 3
		bne $v0, $v1, Case4
		j Function_3
	Case4:
		addi $v1, $zero, 4
		bne $v0, $v1, Case5
		j Function_4
	Case5:
		addi $v1, $zero, 5
		bne $v0, $v1, default
		j End_main			
	default:
		j main
		
End_main:
	la $a0, TheEnd
	li $v0, 4
	syscall	

	li $v0, 10
	syscall	

#-------------- Hiển thị hình ảnh --------------#
Function_1:
	addi $t0, $zero, -1	# t0 = i 	
	addi $t1, $zero, 15	# t1 = n
	
	la $a0,Str1
For1_i:
	addi $t0, $t0, 1
	beq $t0, $t1, EndFor1_i
	
	li $v0, 4
	syscall

	addi $a0, $a0, 63 # Độ dài của 1 chuỗi 
	j For1_i
EndFor1_i: j main
End_Function_1:	
	
#-------------- Hình ảnh chỉ còn viền --------------#
Function_2:
	addi $t0, $zero, -1	 # t0 = i
	addi $t1, $zero, 15	 # t1 = n : số chuỗi ( số hàng )
	la $s0,Str1
		
For2_i:	 #Duyệt từng chuỗi
	addi $t0, $t0, 1
	beq $t0, $t1, EndFor2_i
	
	addi $t2, $zero, -1	# $t2 = j 
	addi $t3, $zero, 63 	# $t3 = m  : số kí tự trong chuỗi 
	
   For2_j:	 # Duyệt từng kí tự của chuỗi
	addi $t2, $t2, 1
	beq $t2, $t3, EndFor2_j
		
	lb $t4, 0($s0)	# $t4 lưu trữ giá trị của từng kí tự trong chuỗi	
	bgt $t4, 47, Number # $t4 > 47 => $t4 là số 1-9 
	j PrintFor2
		
    Number: bgt $t4, 57, PrintFor2 # $t4 > 57 tức là > 9 thì giữ nguyên và in ra
	addi $t4, $zero, 0x20 # Thay đổi $t4 thành dấu cách
	j PrintFor2
				
    PrintFor2: li $v0, 11 	# In kí tự
	move $a0, $t4
	syscall
	
	addi $s0, $s0, 1 # Duyệt đến kí tự tiếp theo
	j For2_j
   EndFor2_j: j For2_i
EndFor2_i: j main
End_Function_2:

#-------------- Hoán đổi vị trí các chữ thành ECD --------------#
Function_3:
	addi $t0, $zero, -1	 # t0 = i
	addi $t1, $zero, 15	 # t1 = n : số chuỗi ( số hàng )
	la $s0,Str1

For3_i:	
	addi $t0, $t0, 1
	beq $t0, $t1, End_For3_i

	sb $0, 22($s0)  #Gán kí tự \0 để tách chuỗi 
	sb $0, 43($s0)
	sb $0, 60($s0)

	li $v0, 4 
	la $a0, 44($s0) #in chu E
	syscall
	
	li $v0, 4 
	la $a0, 23($s0) # in chu C
	syscall
	
	li $v0, 4 
	la $a0 0($s0) # in chu D	
	syscall
	
	li $v0, 4 
	la $a0 61($s0) # in \n
	syscall

	addi $t2, $zero, 0x20
	sb $t2, 22($s0) # Đổi kí tự kết thúc \0 thay bằng dấu cách
	sb $t2, 43($s0)
	sb $t2, 60($s0)

	addi $s0, $s0, 63
	j For3_i
End_For3_i: j main	
End_Function_3:

#-------------- Đổi màu cho chữ --------------#
Function_4:
Color_D:	la $a0, Chu_D
		li $v0, 4		
		syscall
	
		li $v0, 5		#Nhập màu chữ D
		syscall

		blt $v0,0, Again_D
		bgt $v0,9, Again_D
		
		addi $s1, $v0, 48	#$s1 lưu màu chữ D
		j Color_C
		
     Again_D: 	la $a0, NhapLai
		li $v0, 4		
		syscall
		j Color_D
		
Color_C:	la $a0, Chu_C
		li $v0, 4		
		syscall
	
		li $v0, 5	#Nhập màu chữ C
		syscall

		blt $v0,0, Again_C
		bgt $v0,9, Again_C
		
		addi $s2, $v0, 48 #$s2 lưu màu chữ C
		j Color_E
		
     Again_C: 	la  $a0, NhapLai
		li  $v0, 4		
		syscall
		j Color_C
		
Color_E:	la $a0, Chu_E
		li $v0, 4		
		syscall
	
		li $v0, 5	#Nhập màu chữ E
		syscall

		blt $v0,0, Again_E
		bgt $v0,9, Again_E
		
		addi $s3, $v0, 48 #$s1 lưu màu chữ E
		j Continue
		
     Again_E: 	la  $a0, NhapLai
		li  $v0, 4		
		syscall
		j Color_E
		
Continue:		
	addi $t0, $zero, -1	 # t0 = i
	addi $t1, $zero, 15	 # t1 = n : số chuỗi ( số hàng )
	la $s0,Str1

For4_i:		
	addi $t0, $t0, 1
	beq $t0, $t1, EndFor4_i

	addi $t2, $zero, -1	# $t2 = j 
	addi $t3, $zero, 63 	# $t3 = m  : số kí tự trong chuỗi 
	
   For4_j:
   	addi $t2, $t2, 1
	beq $t2, $t3, EndFor4_j
	
	lb $t4, 0($s0)	# $t4 lưu trữ giá trị của từng kí tự trong chuỗi
	
	CheckD: bgt $t2, 22, CheckC 	#Kiểm tra xem đã duyệt hết chữ D chưa
		beq $t4, $t5, Change_D
		j Next_j
	CheckC: bgt $t2, 43, CheckE 	#Kiểm tra xem đã duyệt hết chữ C chưa
		beq $t4, $t6, Change_C
		j Next_j
	CheckE: beq $t4, $t7, Change_E
		j Next_j
		
   Change_D: 	sb $s1, 0($s0)
		j Next_j
   Change_C: 	sb $s2, 0($s0)
		j Next_j
   Change_E: 	sb $s3, 0($s0)
		j Next_j

   Next_j: addi $s0, $s0, 1
		j For4_j
		
   EndFor4_j:	nop 
		addi $a0, $s0, -63
		li $v0, 4 
		syscall
		j For4_i
EndFor4_i: nop
UpdateColor: move $t5, $s1
	move $t6, $s2
	move $t7, $s3
	j main	
End_Function_4: 
