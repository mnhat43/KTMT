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
	digits: .word zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen
	
	twenty: .asciiz "twenty "
	thirty: .asciiz "thirty "
	forty: .asciiz "forty "
	fifty: .asciiz "fifty "
	sixty: .asciiz "sixty "
	seventy: .asciiz "seventy "
	eighty: .asciiz "eighty "
	ninety: .asciiz "ninety "
	ge20: .word twenty, thirty, forty, fifty, sixty, seventy, eighty, ninety
	
	hundred: .asciiz "hundred "
	thousand: .asciiz "thousand "
	million: .asciiz "million "
	andd: .asciiz "and "
#-----------------------------------------------------------
# @brief Bai 3 su dung 2 mang digits va mang ge20 (greater or equal 20)
# @param mang digits chua dia chi tro toi xau cac so tu 0-19
# @param mang ge20 chua dia chi tro toi xau cac so hang chuc
# @param cac bien hundred, thousand, million, andd la tu noi
# @note dung mang se tien de truy nhap xau hon
#-----------------------------------------------------------
.text
main:
#-----------------------------------------------------------
# @brief chuong trinh nhap va in ra man hinh nhu de bai
# @param so nguyen nhap vao duoc luu vao $s0
# @param $ra luu lai dia chi cau lenh va nhay den chuong trinh in
#-----------------------------------------------------------
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0

	li $v0, 4
	la $a0, result
	syscall

	move $a0, $s0
	jal convert_to_text
#-----------------------------------------------------------
# @brief Ket thuc chuong trinh
#-----------------------------------------------------------
	li $v0, 10
	syscall
End_main:
#-----------------------------------------------------------
# @brief Chia so thanh hang trieu, hang nghin, va nho hon 1000
# @param Khoi tao stack va luu $ra vao stack
# @param Cac chuong trinh skip_million, skip_thousand kiem tra cac so >=1000000 va >=1000
# @param Nhay den chuong trinh print_below_thousand de in bo ba so
# @param Sau khi in xong bo ba so se in them tu noi
# @note cap phat bo nho dong, luu dia chi tra ve cho bien dem
# @note khoi phuc lai bo nho dong sau khi da thuc hien xong
#-----------------------------------------------------------
convert_to_text:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	beqz $a0, print_zero

	li $t1, 1000000
	div $a0, $t1
	mfhi $t0
	mflo $t2
	beqz $t2, skip_million
	
	addi $sp, $sp, -4
	sw $t0, 0($sp)

    move $a0, $t2
	jal print_below_thousand
	la $a0, million
	li $v0, 4
	syscall
	
	lw $t0, 0($sp)
	addi $sp, $sp, 4 

skip_million:
	move $a0, $t0

	li $t1, 1000
	div $a0, $t1
	mfhi $t0
	mflo $t2	
	beqz $t2, skip_thousand

	addi $sp, $sp, -4
	sw $t0, 0($sp)
    	
	move $a0, $t2
	jal print_below_thousand
	la $a0, thousand
	li $v0, 4
	syscall

	lw $t0, 0($sp)
	addi $sp, $sp, 4 

skip_thousand:
	move $a0, $t0
	jal print_below_thousand
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
End_convert_to_text:
	jr $ra

#-----------------------------------------------------------
# @brief Chuong trinh in bo ba so
# @brief cap phhat bo nho dong vao stack
# @param chia $a0 cho 100, lay phan du luu vao $t0, phan thuong luu vao $t2
# @param Neu $t2 > 0 thi chuyen den print_digits de in hang tram
# @param Neu $t0 != 0 thi nhay den chuong trinh in hang chuc va hang don vi
# @return $a0 luu chu so hang tram dong thoi luu hai chu so hang chuc va hang don vi
#-----------------------------------------------------------
print_below_thousand:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	li $t1, 100
	div $a0, $t1
	mfhi $t0
	mflo $t2
	beqz $t2, skip_hundred

	move $a0, $t2
	jal print_digits
	la $a0, hundred
	li $v0, 4
	syscall

	beqz $t0, skip_hundred	
	la $a0, andd
	li $v0, 4
	syscall

skip_hundred: nop
	move $a0, $t0	
	jal print_digits
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
End_print_below_thousand:

print_zero:
	li $v0, 4
	la $a0, zero
	syscall
	jr $ra
#-----------------------------------------------------------
# @brief Chuong trinh in hang chuc, hang don vi va chu so
# @param Cap phat bo nho dong vao stack
# @param Neu $a0 < 20 thi xau can tim o mang digits
# @param Neu $a0 >=20 thi xau can tim o mang ge20
# @param $t3 = 4*$a0 de tro den o nho can tim trong mang digits
# @param $t3 = 4*($a0-2) de tro den o nho can tim trong mang ge20
# @param $a1 load dia chi o nho ma $t3 tro den, chua con tro tro den ky tu dau cua xau
# @param $a0 load dia chi xau va in ra man hinh
# @param Cuoi cung se khoi phuc lai bo nho dem
#-----------------------------------------------------------
print_digits:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	bge $a0, 20, print_dozen
	li $v0, 4
	beqz $a0, end
	sll $t3, $a0, 2
	la $a1, digits($t3)
	lw $a0, ($a1)
	syscall
end:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

End_print_digits:
#-----------------------------------------------------------
# @brief Chuong trinh in so hang chuc
# @param Lay $a0 chia 10 de lay phan du va thuong so 
# @param thuong so luu vao $t2 de lay vi tri o nho trong mang ge20
# @note Neu co phan du thi se co hang don vi, vi vay se nhay den ham print_digits
#-----------------------------------------------------------
print_dozen:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t1, 10
	div $a0, $t1
	mfhi $t0
	mflo $t2
	blt $t2, 1, print_digits

	li $v0, 4
	addi $t2, $t2, -2
	sll $t3, $t2, 2
	la $a1, ge20($t3)
	lw $a0, ($a1)
	syscall

	move $a0, $t0
    beqz $a0, End
	jal print_digits
	
End:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
   
