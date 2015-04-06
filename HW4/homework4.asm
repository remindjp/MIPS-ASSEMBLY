.data
iter: .asciiz "\nRunning iteratively: "
rec: .asciiz "\nRunning recursively: "

.text

main:

li $v0, 4
la $a0, rec
syscall

li $a0, 44444 # value
jal sum_recursive

move $a0, $v0
li $v0, 1
syscall


li $v0, 4
la $a0, iter
syscall

li $a0, 44444  # value
jal sum_iterative

move $a0, $v0
li $v0, 1
syscall

li $v0, 10   # end program
syscall







sum_recursive:
 addi $sp, $sp, -8 # adjust stack for 2 items
 sw $ra, 4($sp) # save return address
 sw $a0, 0($sp) # save argument
 slti $t0, $a0, 1 # test for n < 1
 beq $t0, $zero, recursing
 addi $sp, $sp, 8 # pop 2 items from stack
 jr $ra # and return
recursing: div $a0, $a0, 10 # else divide $a0 by 10
 jal sum_recursive # recursive call
 lw $a0, 0($sp) # restore original n
 lw $ra, 4($sp) # and return address
 
 addi $sp, $sp, 8 # pop 2 items from stack
 
 rem $t1, $a0, 10 # take remainder of $a0 mod 10 and put it in $t1
 sub $a0, $a0, $t1 # $a0 = $a0 - r
 
 add $v0, $t1, $v0 # Add remainder to total
 jr $ra # return

sum_iterative:
 addi $sp, $sp, -4 # adjust stack for 1 item
 sw $ra, 0($sp) # save return address
 jal loop
 
loop: 
 beq $a0, $zero, exit
 
 rem $t1, $a0, 10 # take remainder of $a0 mod 10 and put it in $t1
 sub $a0, $a0, $t1 # $a0 = $a0 - r
 div $a0, $a0, 10 # divide $a0 by 10
 add $v0, $t1, $v0 # Add remainder to total
 
 j loop
 
exit:
lw $ra, 0($sp) # and return address
jr $ra
