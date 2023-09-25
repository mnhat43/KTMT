#Lab 11, assignment 1
.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014
.text
main: 		li $t1, IN_ADRESS_HEXA_KEYBOARD
 		li $t2, OUT_ADRESS_HEXA_KEYBOARD
 		li $t3, 0x01	# row 
 		li $t4, 0x10
 				
polling:	sb $t3, 0($t1) # must reassign expected row
 		lb $a0, 0($t2) # read scan code of key button
 		bne $a0, $0, print
		j next_row		
print: 		li $v0, 34 # print integer (hexa)
 		syscall		
sleep_10: 	li $a0, 10 # sleep 100ms
 		li $v0, 32
 		syscall
next_row:	sll $t3, $t3, 1
 		beq $t3, $t4, reset
 		j polling	
reset:		li $t3, 0x01
sleep_1000: 	li $a0, 1000 # sleep 100ms
 		li $v0, 32
 		syscall	
 		j polling
		
