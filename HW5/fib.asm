# keep track of 2 fib numbers at any time
# $s0 holds fib1, $s1 holds fib2
# $s2 holds iterative counter
# $s3 holds n for use in main only

.data
space: .asciiz " "
start: .asciiz "1 1 "   # for convienience
rec: .asciiz "\nrecursive: "
it: .asciiz "\niterative: "

prompt: .asciiz "Input integer: "

.text
main:
	# prompt
	la $a0, prompt
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $s3, $v0
	
	li $s0, 1 # load first two
	li $s1, 1
	
	# iterative
	la $a0, it
	li $v0, 4
	syscall
	
	la $a0, start # print start
	li $v0, 4
	syscall

	move $s2, $s3 # n
	jal loop
		
		
	# recursive
	la $a0, rec
	li $v0, 4
	syscall
	
	la $a0, start # print start
	li $v0, 4
	syscall
		
	move $a0, $s3 # n
	jal fib_r
	
	li $v0, 10
	syscall

loop:

	sub $s2, $s2, 1
	blt $s2, 2, return
	
	add $t0, $s0, $s1 # compute next fib in t0
	move $s0, $s1 # update window
	move $s1, $t0
	
	move $a0, $s1 # print fib 2
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall
	
	j loop

return:
	li $s0, 1 # reset
	li $s1, 1
	jr $ra	

fib_r: 
	addi $sp, $sp, -8 # make room
	sw $a0, 4($sp) # store $a0
	sw $ra, 0($sp) # store $ra

	addi $t0, $0, 3 # loop one less than n
	slt $t0, $a0, $t0
	beq $t0, $0, else
	
	addi $sp, $sp, 8 # restore $sp
	jr $ra # return
	
else: addi $a0, $a0, -1 # n = n - 1
	jal fib_r # recursive call
	lw $ra, 0($sp) # restore $ra
	lw $a0, 4($sp) # restore $a0
	addi $sp, $sp, 8 # restore $sp
	
	add $t0, $s0, $s1 # compute next fib in t0
	move $s0, $s1 # update window
	move $s1, $t0
	
	move $a0, $s1 # print fib 2
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall
	
	jr $ra # return
