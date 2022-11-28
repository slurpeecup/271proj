.data
frameBuffer: .space 0x10000


############### RABBIT SPRITE ##################
rabbit_row1_sprite: .word 0xc8bfe7,0xc8bfe7,0x7f7f7f,0xc8bfe7,0xc8bfe7,0x7f7f7f,0xc8bfe7,0xc8bfe7   
rabbit_row2_sprite: .word 0xc8bfe7,0x7f7f7f,0xc8bfe7,0x7f7f7f,0x7f7f7f,0xc8bfe7,0x7f7f7f,0xc8bfe7       
rabbit_row3_sprite: .word 0xc8bfe7, 0xc8bfe7,0x99d9ea, 0xc8bfe7,0xc8bfe7, 0x99d9ea,0xc8bfe7, 0xc8bfe7      
rabbit_row4_sprite: .word 0x7f7f7f, 0x7f7f7f,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0x7f7f7f, 0x7f7f7f       
rabbit_row5_sprite: .word 0xc8bfe7, 0xc8bfe7,0x7f7f7f, 0xf26f9b,0xf26f9b, 0x7f7f7f,0xc8bfe7, 0xc8bfe7       
rabbit_row6_sprite: .word 0x7f7f7f, 0x7f7f7f,0xc8bfe7, 0xf26f9b,0xf26f9b, 0xc8bfe7,0x7f7f7f, 0x7f7f7f       
rabbit_row7_sprite: .word 0xc8bfe7, 0x7f7f7f,0x7f7f7f, 0xc8bfe7,0xc8bfe7, 0x7f7f7f,0x7f7f7f, 0xc8bfe7       
rabbit_row8_sprite: .word 0x7f7f7f, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0x7f7f7f       
#################################################        
        
############### LION SPRITE ##################
lion_row1_sprite: .word 0xf7ab79, 0xf7ab79,0xff7d27, 0xff7d27,0xff7d27, 0xf7ab79,0xf7ab79, 0xc8bfe7
lion_row2_sprite: .word 0xf7ab79, 0xff7d27,0xff7d27, 0xf7ab79,0xff7d27, 0xff7d27,0xf7ab79, 0xc8bfe7       
lion_row3_sprite: .word 0xff7d27, 0xff7d27,0x000000, 0xf7ab79,0xf7ab79, 0x000000,0xff7d27, 0xc8bfe7      
lion_row4_sprite: .word 0xff7d27, 0xf7ab79,0xf7ab79, 0xf7ab79,0xf7ab79, 0xf7ab79,0xff7d27, 0xc8bfe7       
lion_row5_sprite: .word 0xff7d27, 0xff7d27,0xf7ab79, 0x000000,0xf7ab79, 0xff7d27,0xff7d27, 0xc8bfe7       
lion_row6_sprite: .word 0xff7d27, 0xff7d27,0xff7d27, 0xf7ab79,0xff7d27, 0xff7d27,0xff7d27, 0xc8bfe7       
lion_row7_sprite: .word 0xc8bfe7, 0xff7d27,0xff7d27, 0xff7d27,0xff7d27, 0xff7d27,0xc8bfe7, 0xc8bfe7       
lion_row8_sprite: .word 0xc8bfe7, 0xff7d27,0xff7d27, 0xff7d27,0xff7d27, 0xc8bfe7,0xc8bfe7, 0xc8bfe7       
#################################################            
        
############### FOOD SPRITE ##################
food_row1_sprite: .word 0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7
food_row2_sprite: .word 0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xb97957,0xb97957, 0xb97957,0xb97957, 0xc8bfe7       
food_row3_sprite: .word 0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xb97957,0xb97957, 0xb97957,0xb97957, 0xc8bfe7      
food_row4_sprite: .word 0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xb97957,0xb97957, 0xb97957,0xb97957, 0xc8bfe7       
food_row5_sprite: .word 0xc8bfe7, 0xc8bfe7,0xb97957, 0xb97957,0xb97957, 0xb97957,0xb97957, 0xc8bfe7       
food_row6_sprite: .word 0xc8bfe7, 0xc8bfe7,0xa1a1a1, 0xb97957,0xb97957, 0xb97957,0xc8bfe7, 0xc8bfe7       
food_row7_sprite: .word 0xc8bfe7, 0xc8bfe7,0xa1a1a1, 0xa1a1a1,0xb97957, 0xc8bfe7,0xc8bfe7, 0xc8bfe7       
food_row8_sprite: .word 0xc8bfe7, 0xa1a1a1,0xa1a1a1, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7       
#################################################          
        
############### STONE SPRITE ##################
stone_row1_sprite: .word 0xc8bfe7, 0xc8bfe7,0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0xc8bfe7,0xc8bfe7, 0xc8bfe7
stone_row2_sprite: .word 0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0x7f7f7f,0xc8bfe7, 0x7f7f7f       
stone_row3_sprite: .word 0x7f7f7f, 0xc8bfe7,0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0x7f7f7f      
stone_row4_sprite: .word 0xc8bfe7, 0xc8bfe7,0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0x7f7f7f,0xc8bfe7, 0xc8bfe7       
stone_row5_sprite: .word 0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0x7f7f7f,0xc8bfe7, 0xc8bfe7      
stone_row6_sprite: .word 0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0xc8bfe7      
stone_row7_sprite: .word 0xc8bfe7, 0x7f7f7f,0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0x7f7f7f       
stone_row8_sprite: .word 0xc8bfe7, 0x7f7f7f,0xc8bfe7, 0xc8bfe7,0x7f7f7f, 0x7f7f7f,0x7f7f7f, 0x7f7f7f       
################################################# 

############### EMPTY SPRITE ##################
empty_row1_sprite: .word 0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7
empty_row2_sprite: .word 0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7       
empty_row3_sprite: .word 0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7      
empty_row4_sprite: .word 0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7       
empty_row5_sprite: .word 0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7      
empty_row6_sprite: .word 0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7      
empty_row7_sprite: .word 0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7       
empty_row8_sprite: .word 0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7,0xc8bfe7, 0xc8bfe7       
################################################# 


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
.end_macro

.macro stack_pop
addi $sp, $sp, 4
.end_macro

.text
la $a3, frameBuffer ## loads address of frame buffer into $a3$
addi $t1, $a3, 0x40000 ##max size of frame buffer is arr width * arr length * bitwidth
RST_TICKER
li $t3, 0x0000FF #loads color 1 into $t9
li $a2, 0xFFFFFF #loads color 2 into $t3


main:
RST_FRAMEPTR
addi $a3, $a3, 8192 ##moving position, make parametric 
li $a2, 14
jal draw_from_entity_value

RST_FRAMEPTR
add $a3, $a3, 32
li $a2, 13
jal draw_from_entity_value

RST_FRAMEPTR
add $a3, $a3, 64
li $a2, 12
jal draw_from_entity_value

RST_FRAMEPTR
li $a2, 11
jal draw_from_entity_value

RST_FRAMEPTR
add $a3, $a3, 160
li $a2, 0
jal draw_from_entity_value

li $v0, 10
syscall



draw_from_entity_value:
  la $s7, frameBuffer
  stack_push
  bne $a2, 14, exit_paint_lion_sprite
  paint_lion_sprite :
  la $a2, lion_row1_sprite
  j paint_selected_entity
  exit_paint_lion_sprite :

  bne $a2, 13, exit_paint_rabbit_sprite
  paint_rabbit_sprite :
  la $a2, rabbit_row1_sprite
  j paint_selected_entity
  exit_paint_rabbit_sprite :

  bne $a2, 12, exit_print_food_sprite
  print_food_sprite :
  la $a2, food_row1_sprite
  j paint_selected_entity
  exit_print_food_sprite :

  bne $a2, 11, exit_paint_stone_sprite
  paint_stone_sprite :
  la $a2, stone_row1_sprite
  j paint_selected_entity
  exit_paint_stone_sprite :
 
  paint_empty_sprite :
  la $a2, empty_row1_sprite
  j paint_selected_entity

  
  paint_selected_entity:
  RST_TICKER_2
  paint_selected_entity_rows:
  RST_TICKER
  beq $t8, 8, exit_paint_selected_entity_rows #### on the occasion that $t8 exceeds ymax, exit the paint
  
                 paint_selected_entity_columns:
                 beq $t9, 8, exit_paint_selected_entity_columns # on the occasion that $t9 hits xmax, move back to xmin and increment Y
                       lw $v0, 0($a2)  #a2 contains the address of a color value, we dereference this address to obtain the color we want in $v0
                       sw $v0, 0($a3) #  a3 contains our current write address 
                       addi $t9, $t9, 1
                       addi $a2, $a2, 4 # moving forward across the sprite array
                       addi $a3, $a3, 4 # moving forward across the frame buffer by 1px in X direction
                 j paint_selected_entity_columns
                 exit_paint_selected_entity_columns:
  
  addi $t8, $t8, 1 ### increment the row counter further
  addi $a3, $a3, 992 ### jumping to the next xmin position, incremented by 1 Y
  j paint_selected_entity_rows # back to the top if ymax not reached
  exit_paint_selected_entity_rows:
  exit_paint_selected_entity:  
        
  exit_draw_from_entity_value :
  stack_pop
  jr $ra
