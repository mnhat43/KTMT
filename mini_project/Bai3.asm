#Mini_project Bai 3
.data
	prompt: .asciiz "Nhap so: "
	result: .asciiz "Ket qua: "
	
	zero: .asciiz "zero "
	one: .asciiz "one "
	two: .asciiz "two "
	three: .asciiz "three "
	four: .asciiz "four "
	five: .asciiz "five "
	six: .asciiz "six "
	seven: .asciiz "seven "
	eight: .asciiz "eight "
	nine: .asciiz "nine "
	
	ten: .asciiz "ten "
	eleven: .asciiz "eleven "
	twelve: .asciiz "twelve "
	thirteen: .asciiz "thirteen "
	fourteen: .asciiz "fourteen "
	fifteen: .asciiz "fifteen "
	sixteen: .asciiz "sixteen "
	seventeen: .asciiz "seventeen "
	eighteen: .asciiz "eighteen "
	nineteen: .asciiz "nineteen "
	
	twenty: .asciiz "twenty "
	thirty: .asciiz "thirty "
	forty: .asciiz "forty "
	fifty: .asciiz "fifty "
	sixty: .asciiz "sixty "
	seventy: .asciiz "seventy "
	eighty: .asciiz "eighty "
	ninety: .asciiz "ninety "
	
	hundred: .asciiz "hundred "
	thousand: .asciiz "thousand "
	million: .asciiz "million "
	andd: .asciiz "and "

.text
main:
    # Hiển thị lời nhắc và nhập số từ bàn phím
    	li $v0, 4
    	la $a0, prompt
    	syscall

    	li $v0, 5
    	syscall
    	move $s0, $v0 # Lưu số nhập vào trong $s0

    # In kết quả
    	li $v0, 4
    	la $a0, result
    	syscall

    	move $a0, $s0 # Đưa số nhập vào vào $a0
    	jal convert_to_text

    # Kết thúc chương trình
    	li $v0, 10
    	syscall
End_main:

#-----------------------------------------------------------
# Hàm chuyển số thành văn bản
# Đầu vào: $a0 - Số cần chuyển đổi
# Bước 1: Xử lí trường hợp số bằng 0
# Bước 2: Kiểm tra phần tử triệu và in phần tử triệu (nếu có)
# Bước 3: Kiểm tra phần tử nghìn và in phần tử nghìn (nếu có)
# Bước 4: In phần tử còn lại (dưới 1000)
# Đầu ra: Cách đọc của số đã nhập
#-----------------------------------------------------------
convert_to_text:
    	addi $sp, $sp, -4 # Cấp phát không gian cho biến đệm
    	sw $ra, 0($sp) # Lưu địa chỉ trả về trong biến đệm

    # Xử lý trường hợp số bằng 0
    	beqz $a0, print_zero

    # Kiểm tra phần tử triệu
    	li $t1, 1000000
    	div $a0, $t1
    	mfhi $t0
    	mflo $t2
    	beqz $t2, skip_million
    	
	addi $sp, $sp, -4 
    	sw $t0, 0($sp)
    	
    # In phần tử triệu
       	move $a0, $t2
    	jal print_below_thousand
    	la $a0, million
    	li $v0, 4
    	syscall
    	
    	lw $t0, 0($sp)
       	addi $sp, $sp, 4 

    skip_million:

    	move $a0, $t0

    # Kiểm tra phần tử nghìn
    	li $t1, 1000
    	div $a0, $t1
    	mfhi $t0
    	mflo $t2	
    	beqz $t2, skip_thousand

	addi $sp, $sp, -4 # Cấp phát không gian cho biến đệm
    	sw $t0, 0($sp)
    	
    # In phần tử nghìn
    	move $a0, $t2
    	jal print_below_thousand
    	la $a0, thousand
    	li $v0, 4
    	syscall
    	
    	lw $t0, 0($sp)
       	addi $sp, $sp, 4 

    skip_thousand:
    	move $a0, $t0

    # In phần tử còn lại (dưới 1000)
    	jal print_below_thousand
	nop
    	lw $ra, 0($sp) # Khôi phục địa chỉ trả về từ biến đệm
    	addi $sp, $sp, 4 # Giải phóng không gian biến đệm
    	jr $ra
End_convert_to_text:

#-----------------------------------------------------------
# Hàm chuyển số 0 thành văn bản
# Đầu ra: Cách đọc của số 0: "zero"
#-----------------------------------------------------------
print_zero:
    	li $v0, 4
    	la $a0, zero
    	syscall
    	jr $ra

#-----------------------------------------------------------
# Hàm in phần tử nhỏ hơn 1000 thành văn bản
# Đầu vào: $a0 - Số cần chuyển đổi
# Bước 1: Kiểm tra hàng trăm và in hàng trăm (nếu có)
# Bước 2: In hàng trục và hàng đơn vị (thực hiện hàm print_double_digits)
# Đầu ra: Cách đọc của số dưới 1000 đã lưu trong thanh ghi $a0
#-----------------------------------------------------------
print_below_thousand:
    	addi $sp, $sp, -4 # Cấp phát không gian cho biến đệm
    	sw $ra, 0($sp) # Lưu địa chỉ trả về trong biến đệm
    	
    # ktra hàng trăm
    	li $t1, 100
    	div $a0, $t1
    	mfhi $t0
    	mflo $t2
    	beqz $t2, skip_hundred

    # In hàng trăm
    	move $a0, $t2
    	jal print_single_digit
    	la $a0, hundred
    	li $v0, 4
    	syscall
    	
    	beqz $t0, skip_hundred	
    	la $a0, andd
    	li $v0, 4
    	syscall

    skip_hundred: nop
    	
    # In hàng chục và hàng đơn vị
    	move $a0, $t0	
    	jal print_double_digits
    	
    	lw $ra, 0($sp) # Khôi phục địa chỉ trả về từ biến đệm
    	addi $sp, $sp, 4 # Giải phóng không gian biến đệm
    	jr $ra
End_print_below_thousand:


#-----------------------------------------------------------
# Hàm in số đơn vị thành văn bản
# Đầu vào: $a0 - Số cần chuyển đổi
# Cách hoạt động: so sánh số cần đọc ($a0) với lần lượt các số từ 1-9 rồi in ra cách đọc tương ứng
# Đầu ra: Cách đọc của số có 1 chữ số (các số từ 1-9)
#-----------------------------------------------------------
print_single_digit:
    	addi $sp, $sp, -4 # Cấp phát không gian cho biến đệm
    	sw $ra, 0($sp) # Lưu địa chỉ trả về trong biến đệm
    	
 	li $v0, 4
    	beq $a0, 1, case1
    	beq $a0, 2, case2
    	beq $a0, 3, case3
    	beq $a0, 4, case4
    	beq $a0, 5, case5
    	beq $a0, 6, case6
    	beq $a0, 7, case7
    	beq $a0, 8, case8
    	beq $a0, 9, case9
    
    case1:
	la $a0, one
    	syscall
    	j end_case
    case2:
    	la $a0, two
    	syscall
    	j end_case
    case3:
    	la $a0, three
    	syscall
    	j end_case
    case4:
    	la $a0, four
    	syscall
    	j end_case
    case5:
    	la $a0, five
    	syscall
    	j end_case
    case6:
    	la $a0, six
    	syscall
    	j end_case
    case7:
    	la $a0, seven
    	syscall
    	j end_case
    case8:
    	la $a0, eight
    	syscall
    	j end_case
    case9:
    	la $a0, nine
    	syscall
    	j end_case
    	
    end_case:	nop
    	lw $ra, 0($sp) # Khôi phục địa chỉ trả về từ biến đệm
    	addi $sp, $sp, 4 # Giải phóng không gian biến đệm
    	jr $ra	
End_print_single_digit:

#-----------------------------------------------------------
# Hàm in hàng chục và hàng đơn vị thành văn bản
# Đầu vào: $a0 - Số hàng chục và hàng đơn vị cần in
# Bước 1: Lấy a0 chia cho t1.  Thanh ghi $t2 lưu phần thương
#				Thanh ghi $t0 lưu phần dư
# Bước 2: In hàng chục
#		Trường hợp $t2 = 1 thì gọi hàm "handle_teens" in các số từ 10-19
#		Ngược lại thì so sánh $t2 với các số 20, 30, ... 90 và in ra cách đọc tương ứng		
# Bước 3: In ra hàng đơn vị ( các số từ 0 - 9 )\
#-----------------------------------------------------------
print_double_digits:
    	addi $sp, $sp, -4 # Cấp phát không gian cho biến đệm
    	sw $ra, 0($sp) # Lưu địa chỉ trả về trong biến đệm
    	
    	li $t1, 10
    	div $a0, $t1
    	mfhi $t0
    	mflo $t2
    	beqz $t2, skip_ten

    # Xử lý trường hợp hàng chục là 1 (từ 10 đến 19)
    	beq $t2, 1, handle_teens

    # In hàng chục (20, 30, ..., 90)
    	li $v0, 4
    	beq $t2, 2, case_2
    	beq $t2, 3, case_3
    	beq $t2, 4, case_4
    	beq $t2, 5, case_5
    	beq $t2, 6, case_6
    	beq $t2, 7, case_7
    	beq $t2, 8, case_8
    	beq $t2, 9, case_9
    	
    case_2:
    	la $a0, twenty
    	syscall
    	j End_case
    case_3:
    	la $a0, thirty
    	syscall
    	j End_case
    case_4:
    	la $a0, forty
    	syscall
    	j End_case
    case_5:
    	la $a0, fifty
    	syscall
    	j End_case
    case_6:
    	la $a0, sixty
    	syscall
    	j End_case
    case_7:
    	la $a0, seventy
    	syscall
    	j End_case
    case_8:
    	la $a0, eighty
    	syscall
    	j End_case
    case_9:
    	la $a0, ninety
    	syscall
    	j End_case
    	
    End_case: nop
    	
    skip_ten: nop
    # In hàng đơn vị (0-9)
        move $a0, $t0
        beqz $a0, End
    	jal print_single_digit
	
     End:
    	lw $ra, 0($sp) # Khôi phục địa chỉ trả về từ biến đệm
    	addi $sp, $sp, 4 # Giải phóng không gian biến đệm
    	jr $ra
   
#-----------------------------------------------------------
# Hàm in ra các số từ 10 đến 19
# Đầu vào: $t0 - hàng đơn vị
# Kiểm tra hàng đơn vị từ 0 đến 9 rồi in ra cách đọc tương ứng
#-----------------------------------------------------------
handle_teens:
    	addi $sp, $sp, -4 # Cấp phát không gian cho biến đệm
    	sw $ra, 0($sp) # Lưu địa chỉ trả về trong biến đệm
    	
    	li $v0, 4
    	beq $t0, 0, Case0
    	beq $t0, 1, Case1
    	beq $t0, 2, Case2
    	beq $t0, 3, Case3
    	beq $t0, 4, Case4
    	beq $t0, 5, Case5
    	beq $t0, 6, Case6
    	beq $t0, 7, Case7
    	beq $t0, 8, Case8
    	beq $t0, 9, Case9
    	
    Case0:
	la $a0, ten
    	syscall
    	j end_Case
    Case1:
	la $a0, eleven
    	syscall
    	j end_Case
    Case2:
    	la $a0, twelve
    	syscall
    	j end_Case
    Case3:
    	la $a0, thirteen
    	syscall
    	j end_Case
    Case4:
    	la $a0, fourteen
    	syscall
    	j end_Case
    Case5:
    	la $a0, fifteen
    	syscall
    	j end_Case
    Case6:
    	la $a0, sixteen
    	syscall
    	j end_Case
    Case7:
    	la $a0, seventeen
    	syscall
    	j end_Case
    Case8:
    	la $a0, eighteen
    	syscall
    	j end_Case
    Case9:
    	la $a0, nineteen
    	syscall
    	j end_Case
    	
    end_Case: nop
    	lw $ra, 0($sp) # Khôi phục địa chỉ trả về từ biến đệm
    	addi $sp, $sp, 4 # Giải phóng không gian biến đệm
    	jr $ra
End_handle_teens:

