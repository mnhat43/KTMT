#Lab 4, Assignment 2
.text
	li $s0, 0x12345678 #load test value for these function
	#Extract MSB of $s0
	srl $t0, $s0, 24
	#Clear LSB of $s0
	andi $s0, $s0, 0xffffff00
	#Set LSB of $s0 (bits 7 to 0 are set to 1)
	ori $s0, $s0, 0x000000ff
	#Clear $s0 (s0=0, must use logical instructions)
	andi $s0, $s0, 0x00000000
