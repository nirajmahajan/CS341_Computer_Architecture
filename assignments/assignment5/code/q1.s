# my usage of registers (mostly for my reference while coding)
# t3,t4,t5,t6,t7 = temp register
# s5,s6,s7 conditional registers
# t0,t1,t2 = iterator registers
# t4 = iterator register for k
# s0 = n
# s1 = input_hi
# s2 = input_lo
.data

raw_number:
	.space 14
processed_number:
	.space 13
proceed:
	.space 3

statement_get_mod:
	.asciiz "Enter modulus:​ "
statement_get_int:
	.asciiz "Enter string of 12 decimal digits:​ "
statement_continue:
	.asciiz "Wish to continue?: "
statement_mod:
	.asciiz " mod "
statement_eq:
	.asciiz " = "
statement_newline:
	.asciiz "\n"

.text

# function to print a newline
print_newline:
	li $v0 4
	la $a0 statement_newline
	syscall
	jr $ra

# function to calculate modulus
# assumes $v0 to have input number
# return answer in $a0
# takes mod wrt $s0
mod:
	div $v0 $s0
	mfhi $a0
	jr $ra

# function to calculate modulus for 12 digit number
# assumes $s1,$s2 to have hi,lo respectively
# return answer in $a0
# takes mod wrt $s0
bigmod:
	addi $sp $sp -4					# push ra on stack
	sw $ra ($sp)

	move $v0 $s1					# load hi
	jal mod 						# call function
	move $t3 $a0					# save answer
	
	move $v0 $s2					# load lo
	jal mod 						# call function
	move $t4 $a0					# save answer
	
	li $v0 1000000					# load 1000000
	jal mod 						# call function
	move $t5 $a0					# save answer

	mul $t3 $t3 $t5
	add $t3 $t3 $t4					# (hi modn)*(1000000 modn) + (lo modn)

	move $v0 $t3					# load resultant
	jal mod 						# call function
	
	# answer already in $a0
	lw $ra ($sp)
	addi $sp $sp 4					# pop stack
	jr $ra


# function that performs one operation
execute_once:
	addi $sp $sp -4					# push ra on stack
	sw $ra ($sp)

	# Ask for n
	li $v0 4
	la $a0 statement_get_mod
	syscall

	# Load n
	li $v0 5
	syscall
	move $s0 $v0

	# Ask for input string
	li $v0 4
	la $a0 statement_get_int
	syscall

	# Load raw input string
	li $v0 8
	la $a0 raw_number
	la $a1 14
	syscall

	copy_init:
		li $t0 12				# loop variable
		la $t1 raw_number 		# pointer for the INPUT string
		la $t2 processed_number	# pointer for the INPUT string
	copy_loop:
		beqz $t0 copy_end		# breaking condition
		lb $t4 ($t1)			# load current pointer element
		sb $t4 ($t2)
		addi $t1 1				# increment pointer
		addi $t2 1				# increment pointer
		addi $t0 -1				# decrement loop
		j copy_loop				# loop back
	copy_end:


	# load the input hi
	load_hi_init:
		li $s1 0				# init INP_hi to 0
		li $t0 6				# loop variable
		la $t1 processed_number	# pointer for the INPUT string
	load_hi_loop:
		beqz $t0 load_hi_end	# breaking condition
		lb $t4 ($t1)			# load current pointer element
		addi $t4 $t4 -48		# convert to digit
		mul $s1 $s1 10
		add $s1 $s1 $t4			# update s1 (INP_hi)
		addi $t1 1				# increment pointer
		addi $t0 -1				# decrement loop
		j load_hi_loop			# loop back
	load_hi_end:
	# load the input lo
	load_lo_init:
		li $s2 0				# init INP_hi to 0
		li $t0 6				# loop variable
		la $t1 processed_number	# pointer for the INPUT string
		addi $t1 $t1 6			# increment suitably for lo
	load_lo_loop:
		beqz $t0 load_lo_end	# breaking condition
		lb $t4 ($t1)			# load current pointer element
		addi $t4 $t4 -48		# convert to digit
		mul $s2 $s2 10
		add $s2 $s2 $t4			# update s1 (INP_hi)
		addi $t1 1				# increment pointer
		addi $t0 -1				# decrement loop
		j load_lo_loop 			# loop back
	load_lo_end:

	jal bigmod
	move $t4 $a0				# store answer

	# Print output
	li $v0 4
	la $a0 processed_number
	syscall
	li $v0 4
	la $a0 statement_mod
	syscall
	li $v0 1
	move $a0 $s0
	syscall
	li $v0 4
	la $a0 statement_eq
	syscall
	li $v0 1
	move $a0 $t4
	syscall
	jal print_newline

	lw $ra ($sp)
	addi $sp $sp 4					# pop stack
	jr $ra

main:
	
	while_loop:
		jal execute_once		# execute_once

		# Ask if repeat?
		li $v0 4
		la $a0 statement_continue
		syscall
		# read character 
		li $v0 8
		la $a0 proceed
		la $a1 3
		syscall
		lb $a0 ($a0)
		addi $t3 $a0 -78
		beqz $t3 while_end
		jal print_newline
		jal print_newline
		j while_loop
	while_end:



	# terminate
	li $v0 10
	syscall



