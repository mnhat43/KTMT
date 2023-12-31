#Lab 11, assignment 3
.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014
.data
	Message: .asciiz "Key scan code "
.text
main:
 		li $t1, IN_ADRESS_HEXA_KEYBOARD
 		li $t3, 0x80 # bit 7 = 1 to enable
 		sb $t3, 0($t1)
 
 		xor $s0, $s0, $s0 # count = $s0 = 0
 		
Loop: 		addi $s0, $s0, 1 # count = count + 1
prn_seq:	addi $v0,$zero,1
 		add $a0,$s0,$zero # print auto sequence number
 		syscall
prn_eol:	addi $v0,$zero,11
 		li $a0,'\n' # print endofline
 		syscall
sleep: 		addi $v0,$zero,32
 		li $a0,300 # sleep 300 ms
 		syscall
 		nop # WARNING: nop is mandatory here.
 		b Loop # Loop
end_main:

.ktext 0x80000180
IntSR: 		addi $sp,$sp,4 
 		sw $ra,0($sp)
 		addi $sp,$sp,4 
 		sw $at,0($sp)
 		addi $sp,$sp,4
 		sw $v0,0($sp)
 		addi $sp,$sp,4 
 		sw $a0,0($sp)
 		addi $sp,$sp,4 
 		sw $t1,0($sp)
 		addi $sp,$sp,4
 		sw $t3,0($sp)
 
prn_msg:	addi $v0, $zero, 4
 		la $a0, Message
 		syscall
 		
 		li $t3, 0x01
 		li $t5, 0x10
get_cod:	li $t1, IN_ADRESS_HEXA_KEYBOARD
 		ori $t4, $t3, 0x80
 		sb $t4, 0($t1) # must reassign expected row
 		li $t1, OUT_ADRESS_HEXA_KEYBOARD
 		lb $a0, 0($t1)
 		bne $a0, $0, prn_cod
 		sll $t3, $t3, 1
 		beq $t3, $t5, end_get
		j get_cod	
end_get:	nop

prn_cod:	li $v0,34
 		syscall
 		li $v0,11
 		li $a0,'\n' # print endofline
 		syscall
 
next_pc:	mfc0 $at, $14 # $at <= Coproc0.$14 = Coproc0.epc
 		addi $at, $at, 4 # $at = $at + 4 (next instruction)
 		mtc0 $at, $14 # Coproc0.$14 = Coproc0.epc <= $at

restore:	lw $t3, 0($sp)
 		addi $sp,$sp,-4
 		lw $t1, 0($sp) 
 		addi $sp,$sp,-4
 		lw $a0, 0($sp) 
 		addi $sp,$sp,-4
 		lw $v0, 0($sp) 
 		addi $sp,$sp,-4
 		lw $ra, 0($sp)
 		addi $sp,$sp,-4
return: 	eret # Return from exception