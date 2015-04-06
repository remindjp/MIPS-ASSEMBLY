# Jingpeng Wu
# A.6: Write an adding machine program that repeatedly reads in integers and adds them into a running sum.
# The program should stop when it gets an input that is 0 and print out the sum.

.text

main:
	# enter loop
	j loop

loop:
	# wait for user input
	li	$v0, 5
	syscall
	
	# if input is zero, go to print
	beq	$v0, $zero, print

	# add input to t0
	add $t0, $t0, $v0
	
	# if this statement is reached, input was not 0 so keep looping
	j loop
	
print:
	# prints the sum
	move $a0, $t0
	li	$v0, 1
	syscall	
	
	# exit program
	li 	$v0, 10
	syscall
