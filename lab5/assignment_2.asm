# Lab 5, assignment 2
.data
	x: .asciiz "Enter value for s0: "
   	y: .asciiz "Enter value for s1: "
 	result: .asciiz "The sum of s0 and s1 is "
	
.text
    main:
        # x 
        li $v0, 4
        la $a0, x
        syscall
        
        # Read s0
        li $v0, 5
        syscall
        move $s0, $v0
        
        # y
        li $v0, 4
        la $a0, y
        syscall
        
        # Read s1
        li $v0, 5
        syscall
        move $s1, $v0
        
        # Calculate the sum of s0 and s1
        add $t0, $s0, $s1
        
        # Print the result
        li $v0, 4
        la $a0, result
        syscall
        
        move $a0, $t0
        li $v0, 1
        syscall
        
        # Exit program
        li $v0, 10
        syscall
