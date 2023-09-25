# Lab 10, Assignment 2
.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh
.eqv RED 0x00FF0000 

.text
 	li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hinh
	
	li $t0, RED	
	li $s0, 0
	li $s1, 32
	
scan_full_red:
	add $t1, $k0, $s0

	sw $t0, 0($t1)
	
	addi $s0, $s0, 4
	bne $s0, $s1, scan_full_red
end_scan_full_red:
