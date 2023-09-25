#Lab7, Assignment 1	
.text
main: 	
	li $a0,-5 
	jal abs 
	nop
	add $s0, $zero, $v0
	
 	li $v0,10
 	syscall
endmain:

abs:
 	sub $v0,$zero,$a0 
 	bltz $a0,done 
 	nop
 	add $v0,$a0,$zero 
done:
 	jr $ra
