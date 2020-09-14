# my usage of registers (mostly for my reference while coding)
# t1,t2,t3 = temp register
# s5,s6,s7 conditional registers
# t0 = iterator register for n
# t4 = iterator register for k
# s0 = n
# s1 = k
# s2 = ans
# s3 = loop_ceiled_maxima
.data

statement1:
	.asciiz "Enter No. of integers in list\n"

statement2:
	.asciiz "Enter list\n"

statement3:
	.asciiz "Enter k (a  positive integer)\n"

array:
	.align 4
	.space 200

.text

# Function take input
take_input:
	addi $sp $sp -4
	sw $ra ($sp)
	move $t0 $s0
take_input_loop:
	blez $t0 take_input_end
	sub $t0 $t0 1
	# store new address with offset in .space offset
	# load arr address in t1
	la $t1 array
	sll $t2 $t0 2
	# add offset to t1
	add $t1 $t1 $t2
	# take input and store at t1
	li $v0 5
	syscall
	sw $v0 ($t1)
	j take_input_loop
take_input_end:
	lw $ra ($sp)
	add $sp $sp 4
	jr $ra

# Function 
kloop_start:
	addi $sp $sp -4
	sw $ra ($sp)
	move $t4 $s1
kloop:
	blez $t4 kloop_end
	add $t4 $t4 -1
	li $s3 0x80000000
	jal nloop_start
	move $s2 $s3
	# reloop
	j kloop
kloop_end:
	lw $ra ($sp)
	add $sp $sp 4
	jr $ra

# Function nloop
nloop_start:
	addi $sp $sp -4
	sw $ra ($sp)
	move $t0 $s0
nloop:
	blez $t0 nloop_end
	sub $t0 $t0 1
	# load target element in t1
	la $t1 array
	sll $t2 $t0 2
	add $t1 $t1 $t2
	lw $t1 ($t1)
	# cond1
	slt $s5 $t1 $s2
	# cond2
	slt $s6 $s3 $t1
	# final cond
	and $s5 $s5 $s6
	# if s5 is 1, then loopmaxima is ai
	movn $s3 $t1 $s5

	# reloop
	j nloop


nloop_end:
	lw $ra ($sp)
	add $sp $sp 4
	jr $ra
	

main:
	# initialise answer to intmin
	li $s2 0x7FFFFFFF

	# Ask for n
	li $v0 4
	la $a0 statement1
	syscall
	# Read in n
	li $v0 5
	syscall
	# store n in s0
	move $s0 $v0

	# Ask for array
	li $v0 4
	la $a0 statement2
	syscall
	jal take_input

	# Ask for k
	li $v0 4
	la $a0 statement3
	syscall
	# Read in k
	li $v0 5
	syscall
	# store k in s1
	move $s1 $v0

	# call kloop
	jal kloop_start
	# answer stored in $s2

	li $v0 1
	move $a0 $s2
	syscall


	li $v0 10
	syscall