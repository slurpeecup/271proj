


.data

lions_won: .asciiz "Rabbits have gone extinct, Lions win." 
rabbits_won: .asciiz "Lions have gone extinct, Rabbits win."
simulation_begin: .asciiz "Starting simulation\n"
newline: .asciiz"\n"
.text

li $v0, 4
la $a0, simulation_begin 

syscall


jal gameboard_generation
jal print_initial_gameboard
li $v0, 10
syscall


gameboard_generation:

addi $sp, $sp, -1600 # initializing gameboard size on stack
la $s0, 0($sp) #assignment of base game board address to $s0 register
li $s1, 400 # assignment of all tile count to register $s1

add $t0, $zero, 0 #clearing value in $t0

init_tile_val: #initializes value of each tile

bge $t0, $s1, exit_init_tile_val # "while $t0 != 400
addi $t0, $t0, 1 #incrementing $t0 for the while loop
mul $t1, $t0, 4 #shift index by byte size of integer
add $t2, $s0, $t1 # add base address + offset into $t2


###################### random number generated in this sub block
li $a1, 11#setting the upper bounds of the RNG
li $v0, 42 #loading the syscall code for RNG into the $v0 register
syscall
######################

sb $a0, 0($t2) #store value in argument register to $t2
lw $t3, 0($t2)

bgt $t3, 4, next_from_flatten #begin function to flatten values less than ten down to 0 if $t2 lt 10
addi $t3, $zero, 0  #flattening
sw $t3, 0($t2)
next_from_flatten:

###this block purely for debugging, ignore.
##lb $a0, ($t2)
##li $v0, 1
##syscall
### x0x0x0
j init_tile_val
exit_init_tile_val:
jr $ra
################ number generation step over.

print_initial_gameboard:
addi $t0, $zero, 0

row_print:
beq $t3, 20, end_row_print #while $t3 != 20"
addi $t0, $zero, 0

column_print:
beq $t0, 20, end_col_print # "while $t0 != 20"
mul $t1, $t0, 4 #shift index by byte size of integer
mul $t4,$t1, $t3 
add $t2, $s0, $t4 # add base address + offset into $t2


lb $a0, ($t2)
li $v0, 1
syscall
addi $t0, $t0, 1 #incrementing $t0 for the while loop
j column_print

end_col_print:
addi $t3, $t3, 1 #incrementing $t3 for the prior while loop
li $v0, 4
la $a0, newline
syscall
j row_print

end_row_print:
jr $ra







