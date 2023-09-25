#Lab 4, Assignment 3a
#abs $s0,s1
.text
	li $s1, -5
	bltz $s1, NEGATIVE	# nếu s1 âm => jum NEGATIVE
	
	add $s0, $zero, $s1
	j EXIT
	
	NEGATIVE:
	sub $s0, $zero, $s1
	
	EXIT:
