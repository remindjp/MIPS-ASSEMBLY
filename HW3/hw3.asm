.data
# constants
five: .float 5.0
nine: .float 9.0
tt2:  .float 32.0
# strings
choice: .asciiz "\nConvert F to C (0), or C to F (1) ? "
fprompt: .asciiz "\nWhat is degree in F: "
cprompt: .asciiz "\nWhat is degree in C: "
m: .asciiz "\nbbq"
fres:   .asciiz "\nDegree in C is: "
cres:   .asciiz "\nDegree in F is: "
# program
.text
main: 
	#prompt for F or C
     li $v0, 4
     la $a0, choice
     syscall
     
     #read response and move to t0
     li $v0, 5	
     syscall
     move $t0, $v0	
     
     #print prompt for degrees
	beq $t0, $zero, promptf2c
	li $t1, 1
	beq $t0, $t1, promptc2f

promptf2c:
     li $v0, 4 # print f prompt
     la $a0, fprompt
     syscall
     j	common
     
promptc2f:
     li $v0, 4 # print c prompt
     la $a0, cprompt
     syscall	
     j	common

common:
     # read degrees (float)
     li $v0, 6 
     syscall	
     
	# branch
	beq $t0, $zero, f2c
	beq $t0, $t1, c2f
     
     
c2f: lwc1  $f16, five
     lwc1  $f18, nine
     div.s $f16, $f18, $f16 # 9/5 in $f16
     lwc1  $f18, tt2
     mul.s $f0,  $f0, $f16
     add.s $f0, $f0, $f18 # C + 32.0

     li $v0, 4
     la $a0, cres
     syscall
     
     li $v0, 2 # print a float
     mov.s $f12, $f0 # move result (F) to $f12
     syscall
     j main # loop    

f2c: lwc1  $f16, five
     lwc1  $f18, nine
     div.s $f16, $f16, $f18 # 5/9 in $f16
     lwc1  $f18, tt2
     sub.s $f18, $f0, $f18 # F - 32.0
     mul.s $f0,  $f16, $f18

     li $v0, 4
     la $a0, fres
     syscall
     
     li $v0, 2 # print a float
     mov.s $f12, $f0 # move result (C) to $f12
     syscall
     j main # loop      
     
