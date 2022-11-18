.data
frameBuffer: .space 0x40000 ##4 byte spaces = 256 bytes per 32 elements per rows * 32 rows. 256 * 32 * 32 = 262144 byte or 0x40000 bytes
gameboard: .word 0:1023 ##32 * 32 x 4 byte words = the range of words from 0 to 1024

.macro RST_FRAMEPTR ### this macro resets the value of $a3 to the frame pointer
la $a3, frameBuffer ### this trick is useful in functions where $a3 is a parameter 
.end_macro ### indexing the location in memory of a dataword w/ respect to its distance
### from the initial frame buffer

.macro RST_TICKER ### utilizing $t9 as a designated incrementer for painting onto the bitmap display
li $t9, 0 ### this macro resets said incrementer to 0
.end_macro

.macro RST_TICKER_2 ### utilizing $t8 as a designated incrementer for
li $t8, 0 ### painting onto the bitmap display. This macro resets
.end_macro ### said incrementer to 0

.macro stack_push ### this macro makes pushing $ra to the stack 
addi $sp, $sp, -4 ### less annoying to me
sw $ra, 0($sp)
.end_macro

.macro stack_pop ### this macro makes popping $ra off 
lw $ra, 0($sp)### the stack less annoying to me
addi $sp, $sp, 4
.end_macro

.macro s7framePointer ### sets register $s7 to the frame pointer
la $s7, frameBuffer
.end_macro
  ##### these two macros are good for register conservation.
.macro s7gameboard ## sets register $s7 to the gameboard pointer
la $s7 gameboard
.end_macro

####################### CONSOLE OUTPUT SHIT, PROBABLY DEPRECATED ################################
lions_won: .asciiz "Rabbits have gone extinct, Lions win." 
rabbits_won: .asciiz "Lions have gone extinct, Rabbits win."
simulation_begin: .asciiz "Starting simulation\n"

.text


main:
 li $t0, 0 # loop incrementer
 li $t1, 0 # pos tracker 4 array
 la $t2, gameboard  #load initial address of gameboard label, which already has pre-allocated space 
 jal game_init ### sets initial conditions into the gameboard array 
 
 la $a0, simulation_begin
 li $v0, 4
 syscall
 
jal paint_background

#jal print_grid

jal paint_full_grid
 
 li $v0, 10 
 syscall
 
########################################################
  game_init: # initialize the values in the gameboard
   bge $t0, 1024, init_done # while board is not filled
   li $a1, 15 #limit for RNG, to be replaced w/ LFSR altho discuss w arnie.
   li $v0, 42 # syscall for rng 
   syscall 
   move $t1, $a0 #store RNG value into a tempreg
   bgt $t1, 10, ctne_fr_norm #if equal to or below 10, normalize to 0,
   # indicating an open space for the player. else, continue from norm.
   addi $t1, $zero, 0 ## normalizes the value
   j ctne_fr_norm
   ctne_fr_norm:
   sw $t1, 0($t2) # stores the RNG value into the address indicated by $t2
   addi $t2, $t2, 4 # offsets $t2 for the next element, heap grows up
   addi $t0, $t0, 1 # increments counter
   j game_init ### jump to top until condition is met
 init_done:

############SPRITE PAINT FUNCTIONS#########
###########################################
###########################################
paint_background:
RST_FRAMEPTR
addi $a2, $zero, 0xffe6ba ## color: sand
li $t1, 0x40000 ### loading into $t1 the size of the framebuffer, consider this an xmax value
s7framePointer #setting the value of s7 to the frame pointer
add $t1, $t1, $s7 ### s7 holds the address of the frame pointer
li $t0, 0 ### loading into $t0 0, $t0 will increment up to the xmax of the framebuffer
start_paint_pixel:
beq $a3, $t1, exit_paint_pixel
sw $a2, 0($a3) #$a2 will generally store a color value BY THE TIME this function is called
addi $a3, $a3, 4 #increment to the next address that we'll store a color into 
j start_paint_pixel ### jump back to the top of the loop until conditions are met 
exit_paint_pixel:
jr $ra

paint_L:
RST_TICKER ## resets counter variable
addi $a2, $zero, 0xff6e7f # writes color to $a3
beq $a3, $t1, exit_paint_L ## until framePTR = maxFrame
vertical_line_loop: 
bgt $t9, 5, vertical_line_loop_end ### t2 used as increment CTR
sw $a2, 0($a3) ### writes the color stored into $a2 to the location on the bitmap frame
addi $a3, $a3, 4 # increments to the next position on the bitmap frame
sw $a2, 0($a3) #writes color, again, for a width of now 2px
addi $a3, $a3, 1020 ### skip row - 1 because of the length of the width of L stem
sw $a2, 0($a3) #writes again 1 px 
addi $t9, $t9, 1 ## incrementing small ticker
j vertical_line_loop
vertical_line_loop_end: ### stem drawn
li $t9, 0 
horizontal_line_loop:
addi $t9, $t9, 1 ### incrementing ticker again, register-conservey but annoying
horizontal_line_loop_row: ### draws the two long sides of the L
beq $t9, 8, row_loop_end # end condition ticker 
beq $t9, 18, horizontal_line_loop_end # sub_end condition
addi $a3, $a3, 4 # increment
sw $a2, 0($a3) #write 
addi $t9, $t9, 1 # increment interior ticker
j horizontal_line_loop_row
row_loop_end:
addi $a3, $a3, 992 # jump row
addi $t9, $t9, 1 #increment exterior ticker 
j horizontal_line_loop
horizontal_line_loop_end:
exit_paint_L:
RST_TICKER
jr $ra

paint_X:
addi $a3, $a3, 7168 #### jumps to bottom right corner of bmp 8px * 8px sprite region
addi $a2, $zero, 0xff0000 ### write color 
RST_TICKER # reset ticker
forward_slash:
beq $t9, 8, forward_slash_done ### end condition from bottom right to top left of X
sw $a2, 0($a3) #write
beq $t9, 3, skip_center_up_done
addi $a3, $a3, 4 # increment
sw $a2, 0($a3) #write
skip_center_up_done: # skip upwards in diagonal fashion
addi $a3, $a3, -1024 # skip up one row in BMP 
addi $t9, $t9, 1 # increment a ticker of some fucking sort
j forward_slash
forward_slash_done:
RST_TICKER
addi $a3, $a3, 996 # jump ahead from neg incrementation,
## corrective measure for an algorithmic deficiency that i do not care
##  enough to correct at this time
back_slash:
beq $t9, 8, back_slash_done ## conditional branch
sw $a2, 0($a3) ## writing color 
beq $t9, 3, skip_center_down_done # conditional branch 
addi $a3, $a3, 4 # increment to next position
sw $a2, 0($a3) #write 
skip_center_down_done:
addi $a3, $a3, 1024 #same as above.
addi $t9, $t9, 1 
j back_slash
back_slash_done:
exit_paint_X:
RST_TICKER
jr $ra

paint_S:
RST_TICKER
RST_TICKER_2
addi $a2, $zero, 0x919191 # loads color into $a2
paint_S_row_loop:
beq $t8, 8, paint_S_row_loop_end # conditional branch
RST_TICKER
paint_S_column_loop:
beq $t9, 8, paint_S_column_loop_end # conditional branch
sw $a2, 0($a3) # writing color into frame position
addi $a3, $a3, 4 # increment to next position on frame
addi $t9, $t9, 1 ## increment ticker
j paint_S_column_loop
paint_S_column_loop_end:
addi $a3, $a3, 992 # jump to next row - offset of 32 for byte width of square row
addi $t8, $t8, 1 # increment ticker
j paint_S_row_loop
paint_S_row_loop_end:
RST_TICKER
RST_TICKER_2
exit_paint_S:
jr $ra

paint_F:
addi $a3, $a3, 2048 ## set initial position
addi $a2, $zero, 0x57d5de
RST_TICKER
paint_F_flat_top:
beq $t9, 6, paint_F_flat_top_end ### draws the first row of the 'pill' shape
addi $a3, $a3, 4
sw $a2, 0($a3)
addi $t9, $t9, 1
j paint_F_flat_top
paint_F_flat_top_end: ## end of top row
addi $a3, $a3, 996
RST_TICKER
RST_TICKER_2
paint_F_BODY: ### draws three rows of pill
RST_TICKER
beq $t8, 3, paint_F_BODY_exit
body_width:
beq $t9, 8, paint_f_body_width_end
addi $a3, $a3, 4
sw $a2, 0($a3)
addi $t9, $t9, 1
j body_width
paint_f_body_width_end:
addi $a3, $a3, 992
addi $t8, $t8, 1
j paint_F_BODY
paint_F_BODY_exit:  ## end draw three rows
RST_TICKER
addi $a3, $a3, 4 ### shunt forward 1 px to give rounded edge
paint_F_flat_bottom: ### draw bottom row of pill
beq $t9, 6, paint_F_flat_bottom_end
addi $a3, $a3, 4
sw $a2, 0($a3)
addi $t9, $t9, 1
j paint_F_flat_bottom
paint_F_flat_bottom_end:
exit_paint_F:
RST_TICKER
RST_TICKER_2
jr $ra


paint_R:
RST_TICKER
RST_TICKER_2
addi $a2, $zero, 0xfcba47
paint_R_stem:
beq $t8, 8, paint_R_stem_end
RST_TICKER
paint_R_stem_width_loop:
beq $t9, 3, paint_R_stem_width_loop_end
sw $a2, 0($a3)
addi $a3, $a3, 4
addi $t9, $t9, 1
j paint_R_stem_width_loop
paint_R_stem_width_loop_end:
addi $a3, $a3, 1012
addi $t8, $t8, 1
j paint_R_stem
paint_R_stem_end:
RST_TICKER
RST_TICKER_2
addi $a3, $a3, -8180
paint_R_top_loop:
beq $t9, 4, paint_R_top_loop_end
sw $a2, 0($a3)
addi $a3, $a3, 4
addi $t9, $t9, 1
j paint_R_top_loop
paint_R_top_loop_end:
addi $a3, $a3, 1020
sw $a2, 0($a3)
addi $a3, $a3, 1024
sw $a2, 0($a3)
RST_TICKER
addi $a3, $a3, 1012
paint_R_middle_loop:
beq $t9, 4, paint_R_middle_loop_end
sw $a2, 0($a3)
addi $a3, $a3, 4
addi $t9, $t9, 1
j paint_R_middle_loop
paint_R_middle_loop_end:
addi $a3, $a3, 1004
RST_TICKER
paint_R_leg_down:
beq $t9, 4, paint_R_leg_down_end
addi $a3, $a3, 4
sw $a2, 0($a3)
addi $a3, $a3, 4
sw $a2, 0($a3)
addi $a3, $a3, 1020
addi $t9, $t9, 1
j paint_R_leg_down
paint_R_leg_down_end:
RST_TICKER
RST_TICKER_2
paint_R_exit:
jr $ra

erase_char:
RST_TICKER
RST_TICKER_2
addi $a2, $zero, 0xffe6ba
stack_push
jal paint_S_row_loop
return_from_paint_S:
stack_pop
jr $ra

###########################################
###########################################
paint_unit:
bne $a2, 27, exit_set_combat_X############# BIG WARNING CUS I DIDN'T DOCUMENT ANYTHING
#$a2 ONLY STORES COLOR VALUE AFTER ENTITY TYPE IS DETERMINED
set_combat_X:
stack_push
jal paint_X
stack_pop
j paint_unit_complete
exit_set_combat_X:

bne $a2, 14, exit_lion_X
set_lion_X:
stack_push
jal paint_L
stack_pop
j paint_unit_complete
exit_lion_X: 

bne $a2, 13, exit_rabbit_X
set_rabbit_X:
stack_push
jal paint_R
stack_pop
j paint_unit_complete
exit_rabbit_X:

bne $a2, 12, exit_food_X
set_food_X:
stack_push
jal paint_F
stack_pop
j paint_unit_complete
exit_food_X:  

bne $a2, 11, exit_stone_X
set_stone_X:
stack_push
jal paint_S
stack_pop
j paint_unit_complete
exit_stone_X: 

##bne $a2, 0, paint_unit_complete
set_empty_char_x:
stack_push
jal erase_char
stack_pop
paint_unit_complete:
jr $ra
###########################################
###########################################
paint_full_grid:
li $a2, 0
li $a3, 0
li $t0, 0 ## resetting tickers if not already handled
li $t1, 0 ## designating $t1 as row ticker
la $t3, gameboard
RST_TICKER
RST_TICKER_2

paint_per_array_row:

beq $t1, 32, exit_paint_per_array_row
li $t0, 0
paint_per_array_col:
beq $t0, 32, exit_paint_per_array_col

sll $a3, $t1, 5 
add $a3, $a3, $t0
sll $a3, $a3, 2
s7gameboard
add $a3, $a3 ,$s7

lw $a2, 0($a3)

sll $t2, $t0, 3## scaled col value
sll $t3, $t1, 8 ## scaled row value
sll $t3, $t3, 3 ## rowIndex * scale * numCols)
add $a3, $t3, $t2 ## ((rowIndex * scale * numCols) + col Index * scale)
sll $a3, $a3, 2 ## ((rowIndex * scale * numCols) + col Index * scale) << data_byte_width
s7framePointer
add $a3, $a3, $s7
stack_push 
jal paint_unit
stack_pop


addi $t0, $t0, 1 ## incrementing the column counter
j paint_per_array_col
exit_paint_per_array_col:
addi $t1, $t1, 1 ### incrementing the row counter
j paint_per_array_row
exit_paint_per_array_row:
exit_paint_full_grid:
jr $ra
###################################

###########################################
###########################################


###########################################
###########################################

 ################################################################################## PSEUDOCODE

######################## initialize_array
###### allocate space for game board on stack, then fill array w/ values from random number generator. 
######################## flatten / next_from_flatten
###### if value generated is less than or equal to 10, set to 0
######################## print_initial_gameboard
###### loop through each array element and print w/ appropriate spacers (in development)
########################

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
# addi row_index, row_index, 32
# MODULO_32_FUNCTION
#
# intent: (row_index + 1) % square_size
# X_UP_1 :
# addi row_index, row_index, 1
# MODULO_32_FUNCTION
#
# intent: (col_index - 1 + square_size) % square_size
# COL_IN_DOWN_1:
# sub  col_index, col_index, 1
# addi col_index, col_index, 32
# MODULO_32_FUNCTION
#
# intent: (col_index + 1) % square_size
# COL_IN_UP_1 :
# addi col_index, col_index 1
# MODULO_32_FUNCTION
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
### if find rabbit, jump to immediately 
### if find food, jump to immediately.
### if find empty, store value. Jump to subsequent empty or food.


############################# 
