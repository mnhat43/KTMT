#Lab 7, Assignment 2
.text
main: 	li $a0, 4 
 	li $a1, 7
 	li $a2, 11
 	jal max 
 	nop
endmain:

max: 	add $v0,$a0,$zero 	#copy (a0) in v0; largest so far
 	sub $t0,$a1,$v0 	#compute (a1)-(v0)
  	bltz $t0,okay 		#if (a1)-(v0)<0 then no change
 	nop
 	add $v0,$a1,$zero 	#else (a1) is largest thus far
 	
okay: 	sub $t0,$a2,$v0 	#compute (a2)-(v0)
 	bltz $t0,done 		#if (a2)-(v0)<0 then no change
 	nop
 	add $v0,$a2,$zero 	#else (a2) is largest overall
 	
done: jr $ra 			#return to calling program