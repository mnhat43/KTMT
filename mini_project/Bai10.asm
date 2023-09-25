.data
	msg1: .asciiz "Enter an integer: "
	msg2: .asciiz "i\t\t\tpower(2,i)\t\t\tsquare(i)\t\t\tHexadecimal(i)\n"
	msg3_4: .asciiz "\t\t\t\t"
	msg3_3: .asciiz "\t\t\t"
	msg4: .asciiz "0x"
	msg5: .asciiz "Overflow Result"
	hex: .space 8
.text
	li	$v0, 4
	la	$a0, msg1
	syscall
#-----------------------------------------------------------
# @brief Nhap vao mot so nguyen 32-bit tu ban phim 
# @param $v0 goi service tu he thong de nhap so nguyen
# @param $v0 chua so da nhap vao
# @return $a1 luu so nguyen da duoc nhap
#-----------------------------------------------------------
	li	$v0, 5
	syscall
	move 	$a1, $v0
#-----------------------------------------------------------
# @brief Chuong trinh in bang theo de bai
# @param $v0 goi service tu he thong de in bang
# @param $a0 luu dia chi cac messages tu phan data
# @return in ra bang 
#-----------------------------------------------------------
print_head:
	li	$v0, 4
	la	$a0, msg2
	syscall
print_result:
	li	$v0, 1
	move 	$a0, $a1
	syscall
	
	li	$v0, 4
	la	$a0, msg3_3
	syscall
#-----------------------------------------------------------
# @brief Neu ket qua bi tran thi khong in ra ket qua
# @brief Nhay den function pow, lay ket qua va in ra
# @param De in duoc ket so nguyen duong lon thi phai in so nguyen duong khong dau
# @param Ket qua cua function pow duoc luu o $t1
# @return In ra man hinh ket qua o $a0 neu khong bi tran
# @note Trong he so hoc 32 bit chi co the hien thi gia tri cao nhat la pow(2, 31)
# @note Vi pow(2, 1) = 1 nen chi duoc dich trai toi da 31 lan, i>31 se xay ra hien tuong tran so
#-----------------------------------------------------------
print_pow:
	bgt 	$a1, 31, pow_over
	bltz 	$a1, pow_over
	jal	pow_func
	li  	$v0, 36
	move 	$a0, $t1
	syscall
	j	exit_pow
pow_over:
	la	$a0, msg5
	syscall
	
	li	$v0, 4
	la	$a0, msg3_3
	syscall
	
	j end_print_pow
	
exit_pow:
	li	$v0, 4
	la	$a0, msg3_4
	syscall
end_print_pow:
#-----------------------------------------------------------
# @brief Neu ket qua bi tran thi khong in ra ket qua
# @brief Nhay den function square, lay ket qua va in ra
# @param Ket qua duoc luu o $t0
# @param De in duoc ket so nguyen duong lon thi phai in so nguyen duong khong dau
# @return In ra man hinh ket qua o $a0 neu khong bi tran
# @note Trong he so hoc 32 bit, so nguyen duong lon nhat hien thi duoc la 2^{32}-1
# @note Neu nhap vao so i >= 2^{16} (65536) thi se xay ra hien tuong overflow khi goi ham square(i)
#-----------------------------------------------------------
print_square:
	bgt	$a1, 65535, square_over
	blt 	$a1, -65535, square_over
	jal square_func
	li	$v0, 36
	move 	$a0, $t0
	syscall
	j	exit_square

square_over:
	la	$a0, msg5
	syscall
	
	li	$v0, 4
	la	$a0, msg3_3
	syscall
	
	j end_square_over

exit_square:
	li	$v0, 4
	la	$a0, msg3_4
	syscall
end_square_over:
#-----------------------------------------------------------
# @brief Nhay den chuong trinh chuyen sang he hexa
# @brief In ra "0x"
# @note Vi format in ra so hexa la "0xC" KHONG PHAI la "0x0000000C"
# @note Sau function tim_so_hexa se in truc tiep so hexa su dung mang
#-----------------------------------------------------------
	la	$a0, msg4
	syscall
	jal hex_func
#-----------------------------------------------------------
# @brief Ket thuc chuong trinh
#-----------------------------------------------------------
	li	$v0, 10
	syscall

#-----------------------------------------------------------
# @brief Ham tinh pow(2, i) su dung vong lap va phep dich bit trai de tinh toan
# @param $t0 luu gia tri i vua la bien dem, vua de lap lai phep dich bit
# @param $t1 vua luu ket qua, vua de dich bit
# @param Su dung vong lap de dich bit, khi $t0 = 0 thi thoat vong lap
# @return Ket qua tra ve o $t1
# @note Chua nghi ra phuong an tim pow(2, i) voi i<0
#-----------------------------------------------------------
pow_func:
	move $t0, $a1
	add  $t1, $0, $0
	addi $t1, $t1, 1
loop:
	beqz $t0, end_pow
	sll  $t1, $t1, 1
	addi $t0, $t0, -1
	bnez $t0, loop
end_pow:
	jr	$ra
#-----------------------------------------------------------
# @brief Ham tinh square su dung phep toan so hoc mulou
# @param Su dung cau lenh mulou de tinh toan so nguyen duong lon khong dau
# @return $t0 chua ket qua can tim
# @note Neu nhap vao so nguyen am thi se duoc chuyen ve so duong de tinh toan
# @note Chuyen ve so nguyen duong bang cach su dung so bu hai
# @note Ket qua tra ve la so lon nen dung cau lenh mulou
#-----------------------------------------------------------
square_func:
	move $t0, $a1
	bgtz $t0, skip_abs
	nor  $t0, $t0, $0
	addi $t0, $t0, 1
skip_abs:
	mulou $t0, $t0, $t0
end_square:
	jr	$ra
#-----------------------------------------------------------
# @brief Ham chuyen sang he hexa su dung mang luu tru cac ky tu '0'-'9', 'A'-'F'
# @brief Lay i and 0xf de lay noi dung 4-bit cuoi
# @param Khai bao hex la mot mang 8 phan tu de luu cac gia tri ascii cua cac ky tu trong he hexa
# @param $t0 luu gia tri ban dau cua i
# @param $t1 co gia tri la offset cua mang hex, tro den vi tri trong mang hex
# @param $t2 = 0xf
# @param $t5 luu gia tri 4 bit cuoi cua i, cap nhat gia tri trong bang ascii va luu vao mang hex
# @return Mang hex chua cac gia tri ascii sau khi da chuyen sang he hexa
# @return $t1 la gia tri offset cua phan tu cuoi cung co gia tri ascii cua mang hex
# @note Phan ma gia
# While (i>0) {
# 	t5 = i and 0xf
# 	if (t5 is digit) t5 += 48
# 	else t5+= 55
# 	hex[j] = t5
# 	i = i >> 4
# }
# @note Vi khi so nhap vao be Vd: 12 thi se phai hien 0xC khong hien 0x0000000C
#-----------------------------------------------------------
hex_func:
	move 	$t0, $a1
	add  	$t1, $0, $0
	addi  	$t2, $0, 0xf
outerloop1:
	and	$t5, $t2, $t0
	addi 	$t5, $t5, 48	# 48: kí tự '0'
	blt  	$t5, 58, digit	# 58: kí tự '9' + 1
	addi 	$t5, $t5, 7	
digit:
	sb	$t5, hex($t1)
	addi 	$t1, $t1, 4
	srl  	$t0, $t0, 4
	beq  	$t1, 32, end_hex
	bnez 	$t0, outerloop1
end_hex:
#-----------------------------------------------------------
# @brief In cac gia tri ascii tu mang hex theo thu tu nguoc lai
# @param $v0 goi service in ky tu trong bang ascii
# @param $t1 tro toi o nho trong mang hex co gia tri va nguoc lai den phan tu dau tien
# @return In ra so hexa
# @note Da in truoc '0x' o phan in truoc do nen chi can in truc tiep so hexa la duoc
#-----------------------------------------------------------
	li	$v0, 11
printloop1:
	lb	$a0, hex($t1)
	syscall
	addi 	$t1, $t1, -4
	bgez 	$t1, printloop1
	jr	$ra
