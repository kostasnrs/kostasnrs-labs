# Calculate sums of positive odd and negative even values in an array
#   in MIPS assembly using MARS
# for MYΥ-402 - Computer Architecture
# Department of Computer Engineering, University of Ioannina
# Aris Efthymiou

        .globl main # declare the label main as global. 
        
        .text 
     
main:
        la         $a0, length       # get address of length to $a0
        lw         $a0, 0($a0)       # get the length in to $a0

        la         $a1, input        # get address of array to $a1

        addiu      $s0, $zero, 0     # sum of positive odd values starts as 0
        addiu      $s1, $zero, 0     # sum of negative even values starts as 0

        ########################################################################
	add 	$t7 , $zero , $zero	#we set register t7 to zero
	
loop:    
        lw	$t8, 0($a1)		#we load the element of the array to register t8
        beq	$t7 , $a0 , exit	#we check if t7 is the same as the length of the array
        addi	$t7, $t7 , 1 		#we add 1 to t7( basicaly we check the length of the array)
        srl 	$t1 , $t8 , 31		# we go to the firest bit of the word so we can check if it is positive or negative	
        addi	$a1 , $a1 , 4		# we go to the next word of the array
        andi 	$t0 , $t8 , 0x1		# we check if the number is even or odd
        beq 	$t0 , $zero , even	#if t0 = 0 then even
        bne 	$t0 , $zero , odd	#  t0 != 0 then odd
        
even: 
	beq	$t1 , $zero , loop 	#if t1=0 then positive even so we don't need it in our sum
	add	$s1 , $s1, $t8		# we add at s1 the number of t8 which is negative even	
	bne	$t7 , $a0 , loop	#we go back to the loop if we haven't reached the end of our array 
	
odd: 
	bne	$t1 , $zero , loop	#if t1!=0 then negative odd so we don't need it in our sum
	add	$s0 , $s0, $t8		#we add at s1 the number of t8 which is positive odd
	bne	$t7 , $a0 , loop	#we go back to the loop if we haven't reached the end of our array 
        
        ########################################################################
        
exit: 
        addiu      $v0, $zero, 10    # system service 10 is exit
        syscall                      # we are outta here.
        
        ###############################################################################
        # Data input.
        ###############################################################################
        .data
length: .word 5 # Number of values in the input array
input:  .word 3, -2, 0, 4, -1
