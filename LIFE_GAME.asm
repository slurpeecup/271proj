.data
frameBuffer: .space 0x40000
gameboard: .word 0:1024

.macro RST_FRAMEPTR
la $a3, frameBuffer 
.end_macro

.macro RST_TICKER
li $t9, 0
.end_macro

.macro RST_TICKER_2
li $t8, 0
.end_macro

.macro stack_push
addi $sp, $sp, -4
sw $ra, 0($sp)
.end_macro

.macro stack_pop
lw $ra, 0($sp)
addi $sp, $sp, 4
.end_macro


lions_won: .asciiz "Rabbits have gone extinct, Lions win." 
rabbits_won: .asciiz "Lions have gone extinct, Rabbits win."
simulation_begin: .asciiz "Starting simulation\n"
newline: .asciiz"\n"
newline_2: .asciiz "\n\n"
whitespace: .asciiz " "
whitespace_8: .asciiz "        "
lion_print: .asciiz "L"
rabbit_print: .asciiz "R"
food_print: .asciiz "F"
stone_print: .asciiz "S"
combat_print: .asciiz "X"

 .macro print_string
  li $v0, 4
  syscall
 .end_macro
 
 .macro print_string_w8
  li $v0, 4
  syscall
  la $a0 whitespace_8
  syscall
 .end_macro
 
 .macro print_newline
  li $v0, 4
  la $a0, newline 
  syscall
 .end_macro

.macro print_newline_2
  li $v0, 4
  la $a0, newline_2
  syscall
 .end_macro

.macro print_whitespace_8
li $v0, 4
la $a0, whitespace_8
syscall
.end_macro


.text

### initialize gameboard

main:
 li $t0, 0 # loop incrementer
 li $t1, 0 # pos tracker 4 array
 la $t2, gameboard  #load initial address of gameboard label, which already has pre-allocated space
 la $s6, frameBuffer
 la $s7, gameboard
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
 
 la $a0, simulation_begin
 li $v0, 4
 syscall
la $a3, frameBuffer
li $t1, 0x1004fffc
li $t0, 0

jal paint_background

#jal print_grid

jal paint_full_grid
 
 li $v0, 10 
 syscall
 
 
 
########################################## 
 print_grid: ##prints grid... self explanatory
 li $t0, 0 ## column counter
 li $t1, 0 ## row counter
 la $t2, gameboard ## initial gameboard position
 la $s7, gameboard

  print_rows: ## printing every row
   beq $t1, 32, exit_rows ## printed everything, jump to end sequence
   li $t0, 0 ## reset col counter
   print_newline_2 ## self explanatory

  print_cols: ##printing columns in the row 
   beq $t0, 32, exit_cols

  print_unit:
   lw $t3, 0($t2) ## load current board position
  
   combat: 
    bne $t3, 27, lion
    la $a0, combat_print
      print_string_w8
    j post_default
   
   lion:
    bne $t3, 14, not_lion ## if lion, do lion things; else jump
    la $a0, lion_print #load lion into print argument
    
     print_string_w8
   j post_default
   
  not_lion:  ## if not lion, try rabbit
    bne $t3, 13, not_rabbit 
    la $a0, rabbit_print #load rabbit into print argument
    
     print_string_w8
   j post_default
   
  not_rabbit: ## if not rabbit, try food
   bne $t3, 12, not_food
   la $a0, food_print #load food into print argument
  
     print_string_w8
   j post_default
   
  not_food: ## if not food, try stone
   bne $t3, 11, not_stone
   la $a0, stone_print #load stone into print argument
  
     print_string_w8
   j post_default
   
  not_stone: ## if not stone, default. (0) 
   ##default condition
   li $v0, 4 #setup print integer
   la $a0, whitespace_8
   syscall
   j post_default
   
   post_default:
   
   addi $t0, $t0, 1 # increment column counter
   addi $t2, $t2, 4 # shift position in array 
  j print_cols #jump back to top of printing columns
 
 exit_cols:
addi $t1, $t1, 1
j print_rows

exit_rows:
jr $ra
 

 
############SPRITE PAINT FUNCTIONS#########
###########################################
###########################################
paint_background:
addi $a2, $zero, 0xffe6ba ## color: sand
li $t1, 0x40000
li $t0, 0
start_paint:
beq $t0, $t1, exit_paint #if reach end, branch to exit paint
sw $a2, 0($a3) #store colore $t9 into the address of $a3
addi $a3, $a3, 4 #add into $a3, $a3 + 4
addi $t0, $t0, 4
j start_paint #jump back to start
exit_paint:
jr $ra

paint_L:
RST_TICKER ## resets counter variable
addi $a2, $zero, 0xff6e7f
beq $a3, $t1, exit_paint_L ## until framePTR = maxFrame
vertical_line_loop: 
bgt $t9, 5, vertical_line_loop_end ### t2 used as increment CTR
sw $a2, 0($a3)
addi $a3, $a3, 4
sw $a2, 0($a3)
addi $a3, $a3, 1020 ### skip row - 1 because of the length of the width of L stem
sw $a2, 0($a3)
addi $t9, $t9, 1 ## incrementing small ticker
j vertical_line_loop
vertical_line_loop_end: ### stem drawn
li $t9, 0 
horizontal_line_loop:
addi $t9, $t9, 1 ### incrementing ticker again, register-conservey but annoying
horizontal_line_loop_row: ### draws the two long sides of the L
beq $t9, 8, row_loop_end
beq $t9, 18, horizontal_line_loop_end
addi $a3, $a3, 4
sw $a2, 0($a3)
addi $t9, $t9, 1
j horizontal_line_loop_row
row_loop_end:
addi $a3, $a3, 992
addi $t9, $t9, 1
j horizontal_line_loop
horizontal_line_loop_end:
exit_paint_L:
RST_TICKER
jr $ra

paint_X:
addi $a3, $a3, 7168
addi $a2, $zero, 0xff0000
RST_TICKER
forward_slash:
beq $t9, 8, forward_slash_done
sw $a2, 0($a3)
beq $t9, 3, skip_center_up_done
addi $a3, $a3, 4
sw $a2, 0($a3)
skip_center_up_done:
addi $a3, $a3, -1024
addi $t9, $t9, 1
j forward_slash
forward_slash_done:
RST_TICKER
addi $a3, $a3, 996
back_slash:
beq $t9, 8, back_slash_done
sw $a2, 0($a3)
beq $t9, 3, skip_center_down_done
addi $a3, $a3, 4
sw $a2, 0($a3)
skip_center_down_done:
addi $a3, $a3, 1024
addi $t9, $t9, 1
j back_slash
back_slash_done:
exit_paint_X:
RST_TICKER
jr $ra

paint_S:
RST_TICKER
RST_TICKER_2
addi $a2, $zero, 0x919191
paint_S_row_loop:
beq $t8, 8, paint_S_row_loop_end
RST_TICKER
paint_S_column_loop:
beq $t9, 8, paint_S_column_loop_end
sw $a2, 0($a3)
addi $a3, $a3, 4
addi $t9, $t9, 1
j paint_S_column_loop
paint_S_column_loop_end:
addi $a3, $a3, 992
addi $t8, $t8, 1
j paint_S_row_loop
paint_S_row_loop_end:
RST_TICKER
RST_TICKER_2
exit_paint_S:
jr $ra

paint_F:
addi $a3, $a3, 2048 
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
lw $a2, 0($a3)
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
add $a3, $a3 ,$s7

lw $a2, 0($a3)

sll $t2, $t0, 3## scaled col value
sll $t3, $t1, 8 ## scaled row value
sll $t3, $t3, 3 ## rowIndex * scale * numCols)
add $a3, $t3, $t2 ## ((rowIndex * scale * numCols) + col Index * scale)
sll $a3, $a3, 2 ## ((rowIndex * scale * numCols) + col Index * scale) << data_byte_width
add $a3, $a3, $s6
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
