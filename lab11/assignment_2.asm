#Lab 11, assignment 2
.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014
.text
main:
 		li $t1, IN_ADRESS_HEXA_KEYBOARD
 		li $t2, OUT_ADRESS_HEXA_KEYBOARD
 		li $t3, 0x80 # bit 7 of = 1 to enable interrupt 
  		sb $t3, 0($t1)
  			
Loop: 		nop
		nop
 		nop
 		nop
 		b Loop # Wait for interrupt
end_main:

.ktext 0x80000180
IntSR:	 	li $t1, IN_ADRESS_HEXA_KEYBOARD
 		li $t2, OUT_ADRESS_HEXA_KEYBOARD
 		li $t3, 0x01	# row 
 		li $t4, 0x10				
pol:		sb $t3, 0($t1) # must reassign expected row
 		lb $a0, 0($t2) # read scan code of key button
 		bne $a0, $0, print
		j next_row	
			
print: 		li $v0, 34 # print integer (hexa)
 		syscall		
sleep_10: 	li $a0, 10 # sleep 100ms
 		li $v0, 32
next_row:	sll $t3, $t3, 1
 		beq $t3, $t4, end
 		j pol	
end:
 		li $t3, 0x80 # bit 7 of = 1 to enable interrupt 
  		sb $t3, 0($t1)		
  			
next_pc:	mfc0 $at, $14 # $at <= Coproc0.$14 = Coproc0.epc
 		addi $at, $at, 4 # $at = $at + 4 (next instruction)
 		mtc0 $at, $14 # Coproc0.$14 = Coproc0.epc <= $at
return: 	eret # Return from exception 
