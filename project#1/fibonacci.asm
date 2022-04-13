.data
	prompt: .asciiz "Enter a number less than 40:\n" 
	space: .asciiz " "
	errMessage: .asciiz "The number you entered is invalid.
.text
	.globl main
    	main:
    		#read number from the user
    		li $v0, 4
    		la $a0, prompt
    		syscall
    		
    		#store the number
    		li $v0, 5
		syscall
		
		#assign number to temp register($t0) and max value to $t1
		add $t1, $zero, $v0
        	addi $t2, $zero, 40
        	
        	# if $t1 is less than zero, save 0 to $s0 else save 1
        	slt $s0, $zero, $t1
        	beq $s0, $zero, error
        	
        	# if $t1 is greater than 40, save 0 to $s0 else save 1
        	sge $s0, $t2, $t1
        	beq $s0, $zero, error
        	
        	move $a1, $t1
        	
        	subi $a1, $a1, 3
        	
        	#call the fib function
        	jal fib
        
        fib:
        	move $t3, $a1
        	li $t0,0 #previous
        	li $t1, 1 #Current
        	li $t2, 0 #Next
        	
        	move $a0, $t0
        	li $v0, 1
        	syscall
        	
        	li $v0,4
        	la $a0,space
        	syscall
        	
        	move $a0,$t1
       		li $v0,1
        	syscall
        
        loop: 
        	add $t2,$t1,$t0	
        	
        	li $v0,4
        	la $a0,space
        	syscall
        	
        	move $a0,$t2
        	li $v0,1
        	syscall
        	
        	move $t0,$t1
        	move $t1,$t2
        	
        	slt $t5,$t4,$t3
        	
        	beq $t5,$zero,end
        	
        	addi $t4,$t4,1

        	j loop
        
        error:
        	li $v0, 4
        	la $a0, errMessage
        	syscall
        	
        	jal end
        
        end:
		li $v0, 10
        	syscall	        	
        	
		
		
		