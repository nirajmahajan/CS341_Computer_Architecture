# my usage of registers (mostly for my reference while coding)
# t3,t4,t5,t6,t7 = temp register
# t0,t1,t2 = iterator registers
# s0 = m
# s1 = n
.data

proceed:
	.space 3

statement_get_m:
	.asciiz "Enter m:​ "
statement_get_n:
	.asciiz "Enter n:​ "
statement_res1:
	.asciiz "gcd("
statement_res2:
	.asciiz ","
statement_res3:
	.asciiz ") = "
statement_continue:
	.asciiz "Wish to continue?: "
statement_newline:
	.asciiz "\n"

.text

# function to print a newline
print_newline:
	li $v0 4
	la $a0 statement_newline
	syscall
	jr $ra

# function to calculate gcd of m ($v0), n ($v1)
# return answer in $a0
# no need to save ra as it is tail recursive
gcd:
	# ensure m >= n
	sub $t3 $v0 $v1
	bgez $t3 skip_flip
	flip:
		move $t3 $v0
		move $v0 $v1
		move $v1 $t3
		jr $ra
	skip_flip:

	# get mod
	div $v0 $v1
	mfhi $t3

	beqz $t3 gcd_end
	move $v0 $v1
	move $v1 $t3
	j gcd

	
gcd_end:
	move $a0 $v1
	jr $ra

# function that performs one operation
execute_once:
	addi $sp $sp -4					# push ra on stack
	sw $ra ($sp)

	# Ask for m
	li $v0 4
	la $a0 statement_get_m
	syscall

	# Load m
	li $v0 5
	syscall
	move $s0 $v0

	# Ask for n
	li $v0 4
	la $a0 statement_get_n
	syscall

	# Load n
	li $v0 5
	syscall
	move $s1 $v0

	move $v0 $s0
	move $v1 $s1
	jal gcd
	move $t4 $a0				# store answer

	# Print output
	li $v0 4
	la $a0 statement_res1
	syscall
	li $v0 1
	move $a0 $s0
	syscall
	li $v0 4
	la $a0 statement_res2
	syscall
	li $v0 1
	move $a0 $s1
	syscall
	li $v0 4
	la $a0 statement_res3
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
		# jal print_newline
		# jal print_newline
		j while_loop
	while_end:



	# terminate
	li $v0 10
	syscall



