


.data

lions_won: .asciiz "Rabbits have gone extinct, Lions win." 
rabbits_won: .asciiz "Lions have gone extinct, Rabbits win."
simulation_begin: .asciiz "Starting simulation\n"
newline: .asciiz".\n"
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
li $a1, 15#setting the upper bounds of the RNG
li $v0, 42 #loading the syscall code for RNG into the $v0 register
syscall
######################

sb $a0, 0($t2) #store value in argument register to $t2
lw $t3, 0($t2)

bgt $t3, 10, next_from_flatten #begin function to flatten values less than ten down to 0 if $t2 lt 10
addi $t3, $zero, 0  #flattening
next_from_flatten:
sw $t3, 0($t2)
###this block purely for debugging, ignore.
lb $a0, ($t2)
li $v0, 1
syscall
la $a0, newline
li $v0, 4
syscall
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

t1equals0: #guarantees first row is printed
bne $t3, 0, t1notequals0
mul $t4, $t3, 1
add $t2, $s0, $t4
add $t3, $zero, 0
j exit_t1equals0

t1notequals0: #standard protocol
mul $t4,$t0, $t3 #multiply into $t4 the value of
add $t2, $s0, $t4 # add base address + offset into $t2
j exit_t1equals0

exit_t1equals0:
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

################################################################################## PSEUDOCODE


##### play_round
#### loop through each array element individually, left to right top to bottom. 
#### if value is correspondent to a lion or rabbit,branch to death by hunger
### if death by hunger does not return 0, branch to animals decision tree selector
### if death by hunger does return 0, return to position in loop_through_array

##### decision
#### if value in tile is correspondent to a rabbit, jump to rabbit decision tree
#### if value in tile is correspondent to a lion, jump to lion decision tree 

##### death_by_hunger
#### call system time
#### if system time is divisible by 6
#### set value in tile to 0, then return 

##### animal_combat
#### if value on tile is indicative of animals fighting
### load a random number within a range
### if number is greater than cutoff point
# SUB_RABBIT - subtract value of rabbit from tile
#else, SUB_LION - subtract value of lion from tile.


#################################### reference
#
#  row major formula : base + {(rowIndex * numCols) + colIndex } << data_byte_width
#   1 2 3
#   4 T 6
#   7 8 9
# to find values surrounding T
#
# 1: base + {( (X_Down_1) * numCols) + (colIndex_Down_1) } << data_byte_width
# 2: base + {( (X_Down_1) * numCols) + colIndex } << data_byte_width
# 3: base + {( (X_Down_1) * numCols) + (colIndex_Up_1) } << data_byte_width 
# 4: base + {( rowIndex * numCols) + (colIndex_Down_1) } << data_byte_width
#
# T: base + {(rowIndex * numCols) + colIndex } << data_byte_width
#
# 6: base + {( rowIndex * numCols) + (colIndex_Up_1) } << data_byte_width
# 7: base + {( (X_Up_1) * numCols) + (colIndex_Down_1) } << data_byte_width
# 8: base + {( (X_Up_1) * numCols) + colIndex } << data_byte_width
# 9: base + {( (X_Up_1) * numCols) + (colIndex_Up_1) } << data_byte_width
#
#
###### THE PROBLEM: wraparound is difficult & gross, functions needed to ensure wraparound while seeking targer 
#
# intent: (row_index - 1 + square_size) % square_size
# X_Down_1 : 
# sub  row_index, row_index, 1
# addi row_index, row_index, 20
# MODULO_20_FUNCTION
#
# intent: (row_index + 1) % square_size
# X_UP_1 :
# addi row_index, row_index, 1
# MODULO_20_FUNCTION
#
# intent: (col_index - 1 + square_size) % square_size
# COL_IN_DOWN_1:
# sub  col_index, col_index, 1
# addi col_index, col_index, 20
# MODULO_20_FUNCTION
#
# intent: (col_index + 1) % square_size
# COL_IN_UP_1 :
# addi col_index, col_index 1
# MODULO_20_FUNCTION
#
####### MODULO_FUNCTION
#
#
####################################


##### rabbit_decision_tree
### Look counter-clockwise, starting @ pos 5
### If food, immediately write value of rabbit to
### address of food, write value @ address of rabbit to 0

### If empty, store that address in a temp. if another
### empty is encountered, jump back to the first
### write rabbit address value to 0, write stored address to rabbit val

### If no empty address loaded into a reg when a lion is encountered,
### add value to lion, jump to animal fight function, rectify based on
### results. if empty address is loaded, jump to empty.

##### lion_decision_tree
### Look clockwise, starting @ pos 2
