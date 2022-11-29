.data
        frameBuffer : .space 0x40000 ##4 byte spaces = 256 bytes per 32 elements per rows * 32 rows. 256 * 32 * 32 = 262144 byte or 0x40000 bytes
        gameboard : .word 0 : 1024 ##32 * 32 x 4 byte words = the range of words from 0 to 1024
        wrappedAddresses : .space 0xa0
        registerStack1 : .space 0x50
        index_within_decision_tree_loop : .space 0x4        #less effort than restructuring
        
        
############### RABBIT SPRITE ##################
rabbit_row1_sprite: .word 0xc8bfe7,0xc8bfe7,0x7f7f7f,0xc8bfe7,0xc8bfe7,0x7f7f7f,0xc8bfe7,0xc8bfe7   
rabbit_row2_sprite: .word 0xc8bfe7,0x7f7f7f,0xc8bfe7,0x7f7f7f,0x7f7f7f,0xc8bfe7,0x7f7f7f,0xc8bfe7       
rabbit_row3_sprite: .word 0xc8bfe7,0xc8bfe7,0x99d9ea,0xc8bfe7,0xc8bfe7,0x99d9ea,0xc8bfe7,0xc8bfe7      
rabbit_row4_sprite: .word 0x7f7f7f,0x7f7f7f,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0x7f7f7f,0x7f7f7f       
rabbit_row5_sprite: .word 0xc8bfe7,0xc8bfe7,0x7f7f7f,0xf26f9b,0xf26f9b,0x7f7f7f,0xc8bfe7,0xc8bfe7       
rabbit_row6_sprite: .word 0x7f7f7f,0x7f7f7f,0xc8bfe7,0xf26f9b,0xf26f9b,0xc8bfe7,0x7f7f7f,0x7f7f7f       
rabbit_row7_sprite: .word 0xc8bfe7,0x7f7f7f,0x7f7f7f,0xc8bfe7,0xc8bfe7,0x7f7f7f,0x7f7f7f,0xc8bfe7       
rabbit_row8_sprite: .word 0x7f7f7f,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0x7f7f7f       
#################################################        
        
############### LION SPRITE ##################
lion_row1_sprite: .word 0xf7ab79,0xf7ab79,0xff7d27,0xff7d27,0xff7d27,0xf7ab79,0xf7ab79,0xc8bfe7
lion_row2_sprite: .word 0xf7ab79,0xff7d27,0xff7d27,0xf7ab79,0xff7d27,0xff7d27,0xf7ab79,0xc8bfe7       
lion_row3_sprite: .word 0xff7d27,0xff7d27,0x000000,0xf7ab79,0xf7ab79,0x000000,0xff7d27,0xc8bfe7      
lion_row4_sprite: .word 0xff7d27,0xf7ab79,0xf7ab79,0xf7ab79,0xf7ab79,0xf7ab79,0xff7d27,0xc8bfe7       
lion_row5_sprite: .word 0xff7d27,0xff7d27,0xf7ab79,0x000000,0xf7ab79,0xff7d27,0xff7d27,0xc8bfe7       
lion_row6_sprite: .word 0xff7d27,0xff7d27,0xff7d27,0xf7ab79,0xff7d27,0xff7d27,0xff7d27,0xc8bfe7       
lion_row7_sprite: .word 0xc8bfe7,0xff7d27,0xff7d27,0xff7d27,0xff7d27,0xff7d27,0xc8bfe7,0xc8bfe7       
lion_row8_sprite: .word 0xc8bfe7,0xff7d27,0xff7d27,0xff7d27,0xff7d27,0xc8bfe7,0xc8bfe7,0xc8bfe7       
#################################################            
        
############### FOOD SPRITE ##################
food_row1_sprite: .word 0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7
food_row2_sprite: .word 0xc8bfe7,0xc8bfe7,0xc8bfe7,0xb97957,0xb97957,0xb97957,0xb97957,0xc8bfe7       
food_row3_sprite: .word 0xc8bfe7,0xc8bfe7,0xc8bfe7,0xb97957,0xb97957,0xb97957,0xb97957,0xc8bfe7      
food_row4_sprite: .word 0xc8bfe7,0xc8bfe7,0xc8bfe7,0xb97957,0xb97957,0xb97957,0xb97957,0xc8bfe7       
food_row5_sprite: .word 0xc8bfe7,0xc8bfe7,0xb97957,0xb97957,0xb97957,0xb97957,0xb97957,0xc8bfe7       
food_row6_sprite: .word 0xc8bfe7,0xc8bfe7,0xa1a1a1,0xb97957,0xb97957,0xb97957,0xc8bfe7,0xc8bfe7       
food_row7_sprite: .word 0xc8bfe7,0xc8bfe7,0xa1a1a1,0xa1a1a1,0xb97957,0xc8bfe7,0xc8bfe7,0xc8bfe7       
food_row8_sprite: .word 0xc8bfe7,0xa1a1a1,0xa1a1a1,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7       
#################################################          
        
############### STONE SPRITE ##################
stone_row1_sprite: .word 0xc8bfe7,0xc8bfe7,0x7f7f7f,0x7f7f7f,0x7f7f7f,0xc8bfe7,0xc8bfe7,0xc8bfe7
stone_row2_sprite: .word 0xc8bfe7,0xc8bfe7,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0xc8bfe7,0xc8bfe7       
stone_row3_sprite: .word 0xc8bfe7,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0xc8bfe7      
stone_row4_sprite: .word 0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0xc8bfe7       
stone_row5_sprite: .word 0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0xc8bfe7      
stone_row6_sprite: .word 0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0xc8bfe7      
stone_row7_sprite: .word 0xc8bfe7,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0x7f7f7f,0xc8bfe7,0xc8bfe7       
stone_row8_sprite: .word 0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7       
################################################# 

############### EMPTY SPRITE ##################
empty_row1_sprite: .word 0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7
empty_row2_sprite: .word 0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7       
empty_row3_sprite: .word 0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7      
empty_row4_sprite: .word 0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7       
empty_row5_sprite: .word 0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7      
empty_row6_sprite: .word 0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7      
empty_row7_sprite: .word 0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7       
empty_row8_sprite: .word 0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7,0xc8bfe7       
################################################# 

                                
 ############################################################################################################################################
 ############################################################################################################################################
 ############################################################################################################################################       
 
 .macro prime
 add $s6, $0, $s1 ### $s6 holds our true row index temporarily
 add $s5, $0, $s0 ### $5 holds our true col index temporarily
 .end_macro
 
 
 .macro unprime
move $s1, $s6 ### $s6 holds our true row index temporarily
move $s0, $s5 ### $5 holds our true col index temporarily
 .end_macro
 
 .macro prime2
 add $s6, $0, $t7 ### $s6 holds our true row index temporarily
 add $s5, $0, $t6 ### $5 holds our true col index temporarily
 .end_macro
 
 
 .macro unprime2
move $s1, $t7 ### $s6 holds our true row index temporarily
move $s0, $t6 ### $5 holds our true col index temporarily
 .end_macro

 
  .macro stash_t_registers1
        la $s7,registerStack1 # setting pointer control to register stack 1
        sw $t0,0($s7)
        sw $t1,4($s7)
        sw $t2,8($s7)
        sw $t3,12($s7)
        sw $t4,16($s7)
        sw $t5,20($s7)  ## storing all tempregs
        sw $t6,24($s7)
        sw $t7,28($s7)
        sw $t8,32($s7)
        sw $t9,36($s7)
  .end_macro
 
  .macro pull_t_registers1
        la $s7,registerStack1 # setting pointer control to register stack 1
        lw $t0,0($s7)
        lw $t1,4($s7)
        lw $t2,8($s7)
        lw $t3,12($s7)
        lw $t4,16($s7)
        lw $t5,20($s7)  ## storing all tempregs
        lw $t6,24($s7)
        lw $t7,28($s7)
        lw $t8,32($s7)
        lw $t9,36($s7)
  .end_macro
 
  .macro RST_FRAMEPTR ### this macro resets the value of $a3 to the frame pointer
        la $a3,frameBuffer ### this trick is useful in functions where $a3 is a parameter
        .end_macro ### indexing the location in memory of a dataword w / respect to its distance
        ### from the initial frame buffer
 
        .macro RST_TICKER ### utilizing $t9 as a designated incrementer for painting onto the bitmap display
        li $t9,0 ### this macro resets said incrementer to 0
  .end_macro
 
  .macro RST_TICKER_2 ### utilizing $t8 as a designated incrementer for
        li $t8,0 ### painting onto the bitmap display.This macro resets
  .end_macro ### said incrementer to 0
 
  .macro stack_push ### this macro makes pushing $ra to the stack
        addi $sp,$sp,-4 ### less annoying to me
        sw $ra,0($sp)
  .end_macro
 
  .macro stack_pop ### this macro makes popping $ra off
        lw $ra,0($sp)### the stack less annoying to me
        addi $sp,$sp,4
  .end_macro
 
  .macro s7framePointer ### sets register $s7 to the frame pointer
        la $s7,frameBuffer
  .end_macro
        ##### these two macros are good for register conservation.
  .macro s7gameboard ## sets register $s7 to the gameboard pointer
        la $s7 gameboard
  .end_macro
 
  .macro s7wrappedAddresses
        la $s7,wrappedAddresses
  .end_macro
 
  .macro s7surroundingBuffer
        la $s7,surroundingBuffer
  .end_macro
 
  .macro s7registerStack1
        la $s7,registerStack1
  .end_macro
 
  .macro wraparound_rowconst
        addi $s1,$s6,0 ## this was honestly just too trivial to turn into a function,
  .end_macro       ## but a necessary abstraction for the sake of consistency
 
  .macro wraparound_colconst
        addi $s0,$s5,0 ## this was honestly just too trivial to turn into a function,
  .end_macro       ## but a necessary abstraction for the sake of consistency
 
  
            ####################### CONSOLE OUTPUT SHIT,PROBABLY DEPRECATED ################################
    lions_won:.asciiz "Rabbits have gone extinct,Lions win."
    rabbits_won : .asciiz "Lions have gone extinct,Rabbits win."
    simulation_begin : .asciiz "Starting simulation\n"

    .text


  main :
  ######## s3,s4 reserved for end game conditions.
      li $s0,0 # loop incrementer
      li $s1,0 # pos tracker 4 array
    
    
      la $t2,gameboard
      jal game_init ### sets initial conditions into the gameboard array
      
      la $a0, simulation_begin
      li $v0,4
      syscall


        li $s0,0
        li $s1,0
        li $a0, 32

   jal paint_full_grid
   jal play_a_full_round

    endgame_condition_not_met_reset:
      s7gameboard
        
          stack_push
#              jal play_a_round ### assuming $t0 is colindex and $t1 is rowindex.
          stack_pop


#  jal count_all_rabbits

  bne $s3,0,endgame_condition_not_met_reset # are lions == 0 ?
  bne $s4,0,endgame_condition_not_met_reset # are rabbits == 0 ?

  li $v0,10
  syscall

  ########################################################
  game_init : # initialize the values in the gameboard
     bge $t0,1024,init_done # while board is not filled
       li $a1,15 #limit for RNG,to be replaced w / LFSR altho discuss w arnie.
       li $v0,42 # syscall for rng
           syscall
       move $t1,$a0 #store RNG value into a tempreg
     bgt $t1,10,ctne_fr_norm #if equal to or below 10,normalize to 0,
        # indicating an open space for the player. else,continue from norm.
        addi $t1,$zero,0 ## normalizes the value
     j ctne_fr_norm
   ctne_fr_norm :
     sw $t1,0($t2) # stores the RNG value into the address indicated by $t2
     addi $t2,$t2,4 # offsets $t2 for the next element,heap grows up
     addi $t0,$t0,1 # increments counter
   j game_init ### jump to top until condition is met
  init_done :
jr $ra

     
#################################################################################################################################     
#################################        SPRITE   BLOCK      ####################################################################
#################################################################################################################################
 
 #### draw from entity value behaves simply. the user must pass in two arguments in order for each entity to be drawn.
 ### #a2 contains the value of the entity, and #a3 must contain the address to draw the entity at. 
 ### this function utilizes registers $a2, $a3, and overwrites $v0, $t9, $t8, 
 draw_from_entity_value:
  la $s7, frameBuffer # point @ the frameBuffer as a reference. # might not be necessary, need to look into this further.
  stack_push
  bne $a2, 14, exit_paint_lion_sprite # checking the value of the entity to make sure it is a lion.         
  paint_lion_sprite :       #### the protocol is the same for all of these paint_x_sprite labels, so i'll only cover one
  la $a2, lion_row1_sprite ### if entity is a lion, we load the label for the lion sprite array in order to use it for the painting function
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
  la $a2, empty_row1_sprite ### if not one of the cardinal values, just write as empty.
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
 
#################################################################################################################################    
#################################################################################################################################    
#################################################################################################################################    


######################################  Gameboard Address to     ################################################################    
######################################  Frame Buffer Address     ################################################################    
### with the assumption that $s2 is our gameboard address, easily converting between gameboard addresses and frame buffer addresses. 
### manipulate the game board, immediately update the frame buffer correspondingly. 

convert_gameboard_address_to_framePointer:
RST_TICKER
RST_TICKER_2
       lw $a2, 0($s2) # value within the address is now at $a2
       la $s7, gameboard ### setting $s7 to gameboard pointer for fun
       sub $s2, $s2, $s7 # $a7 now equals distance from gameboard pointer WRT (gameboard scale distance)
       li $t9, 128 # gameboard width is 32 * 4 bytes, stored in $t9
       div $s2, $t9 # with this division, we get a quotient and remainder that will give us our offset in terms of rows and columns
       mflo $t8 #t4 is quotient(row index)
       mfhi $t9 #t5 is remainder(col index)
    
       ### now ready for row major
       sll $t9, $t9, 3 # shifting col index
       sll $t8, $t8, 13 ## rowindex * scale * numcols
       add $t9, $t9, $t8 ## ((rowIndex * scale * numCols) + col Index * scale)
       
       la $s7, frameBuffer ### reassign pointer control to the frame pointer
       add $a3, $t9, $s7 ### loading initial framepointer address of entity into its respective position.
exit_convert_gameboard_address_to_framePointer:
jr $ra
#################################################################################################################################    
#################################################################################################################################    

######################################      Master Index to      ################################################################    
######################################     Game Board Address    ################################################################    

### with the assumption that $s0 is our column index and $s1 is our row index, taking the position within the game round and converting it 
### into a gameboard address is the first step in manipulating anything. we will take $a0 

convert_master_index_to_gameboard:
RST_TICKER
RST_TICKER_2
s7gameboard
li $s2, 0 # resetting s2 per gameboard address

add $t9, $0, $s0 # $t9 takes is our malleable column index
add $t8, $0, $s1 # $t9 takes is our malleable row index

mul $t8, $t8, 32 #(row index * numcols)
add $s2, $t8, $t9 #(row index * ncols) + col index 
sll $s2, $s2, 2 # ((row index * ncols) + col index) << bytewidth
add $s2, $s2, $s7 # gameboard base pointer + ((row index * ncols) + col index) << bytewidth
lw $a2, 0($s2) # value within the address is now at $a2
add $a1, $0, $s2 # argument 1 contains gameboard address
exit_convert_master_index_to_gameboard:
jr $ra

#################################################################################################################################    
#################################################################################################################################  
  paint_full_grid:
      RST_TICKER
      RST_TICKER_2    # resetting $t8 and $t9 to ensure cleanliness 

      paint_per_array_row :

  beq $s1,32,exit_paint_per_array_row  # looping on each row of the gameboard array
  li $s0,0
  paint_per_array_col :
      beq $s0,32,exit_paint_per_array_col   # looping on each column in the chosen row
      stack_push
      jal convert_master_index_to_gameboard           
      jal convert_gameboard_address_to_framePointer  # these names really explain themselves.
      jal draw_from_entity_value
      stack_pop
      addi $s0, $s0, 1 #index position in columns
      j paint_per_array_col
  exit_paint_per_array_col :
      addi $s1,$s1,1 ### incrementing the row counter # index position in rows
      j paint_per_array_row
  exit_paint_per_array_row :
  exit_paint_full_grid:
      jr $ra
#################################################################################################################################    
###############################    Wraparound Address Calculation Functions   ###################################################
#################################################################################################################################

# because our gameboard is technically circular (because fuckkkkkk bounds checking), a suite of functions needs to exist that will
# allow us to consider all tiles immediately around an entity, even if that entity is on one of the map edges.


# my brain is so tired, but i need to document. wrote a macro set called prime and unprime, idea is to keep the true, gameboard authentic
# indexes in $s6 and $s5, then return them after each operation has been done with the wraparounds. it is gross, but it is what i deserve.

wraparound_rowminus:
    li $t0, 32
    # laboring under the assumption that $s6 is our TRUE row index
    addi $s1, $s6, 0 #t4 contains the new row index
    addi $s1, $s1, 31 # (rowIndex - 1 + 32)
    div $s1, $t0 # div w / intent to access remainder from mfhi, effectively mod32
    mfhi $s1 # $t5 mod 32
  end_wraparound_rowminus:
    jr $ra

  wraparound_rowplus :
    li $t0, 32
    # laboring under the assumption that $t1 is our row index
    addi $s1, $s6, 0 #t5 contains the new row index
    addi $s1, $s1, 33 # (rowIndex + 1 + 32)
    div $s1, $t0 # div w / intent to access remainder from mfhi, effectively mod31
    mfhi $s1 # $t4 mod 32
  end_wraparound_rowplus:
    jr $ra

  wraparound_colminus :
     li $t0, 32
    #laboring under the assumption that $s0 is our column index
    addi $s0, $s5, 0 # $t4 = col index
    addi $s0, $s0, 31 # (colindex - 1 + 32)
    div $s0, $t0 #mod
    mfhi $s0 #mod
  end_wraparound_colminus :
    jr $ra

  wraparound_colplus :
     li $t0, 32
    #laboring under the assumption that $s0 is our column index
    addi $s0, $s5, 0 # $t4 = col index
    addi $s0, $s0, 33 # (colindex + 1 + 32)
    div $s0, $t0 #mod
    mfhi $s0 #mod
  end_wraparound_colplus :
    jr $ra

################################### Wwrapped Address Calculator #################################################################    
###################################                             #################################################################  

# at this point im incredibly sleepy and this just should not work lol. takes wrapped addresses, stashes them in that array.

 pull_wrappedAddresses :
 la $t7, wrappedAddresses
    stack_push
     prime # stash those indexes
      jal wraparound_colminus  ## arr[X - 1][Y - 1]
      jal wraparound_rowminus
      sw $s1, 0($t7) # store row index
      addi $t7, $t7, 4 # shift forward by one space
      sw $s0, 0($t7) # store col index
      addi $t7, $t7, 4 # shift forward by one space
     unprime #reset those indexes ... not going to repeat these each time. 
     prime
      wraparound_colconst  ## arr[X - 1][Y - 1]
      jal wraparound_rowminus
      sw $s1, 0($t7) # store row index
      addi $t7, $t7, 4 # shift forward by one space
      sw $s0, 0($t7) # store col index
      addi $t7, $t7, 4 # shift forward by one space
     unprime
     prime
      jal wraparound_colplus  ## arr[X - 1][Y + 1]
      jal wraparound_rowminus
      sw $s1, 0($t7) # store row index
      addi $t7, $t7, 4 # shift forward by one space
      sw $s0, 0($t7) # store col index
      addi $t7, $t7, 4 # shift forward by one space
      
     unprime
     prime
      jal wraparound_colminus  ## arr[X][Y - 1]
      wraparound_rowconst
     sw $s1, 0($t7) # store row index
      addi $t7, $t7, 4 # shift forward by one space
      sw $s0, 0($t7) # store col index
      addi $t7, $t7, 4 # shift forward by one space
      
     unprime
     prime
      wraparound_colconst  ## arr[X][Y]
      wraparound_rowconst
      sw $s1, 0($t7) # store row index
      addi $t7, $t7, 4 # shift forward by one space
      sw $s0, 0($t7) # store col index
      addi $t7, $t7, 4 # shift forward by one space
      
     unprime
     prime
      jal wraparound_colplus  ## arr[X][Y + 1]
      wraparound_rowconst
      sw $s1, 0($t7) # store row index
      addi $t7, $t7, 4 # shift forward by one space
      sw $s0, 0($t7) # store col index
      addi $t7, $t7, 4 # shift forward by one space
      
     unprime
     prime
       jal wraparound_colminus ## arr[X + 1][Y - 1]
      jal wraparound_rowplus
      sw $s1, 0($t7) # store row index
      addi $t7, $t7, 4 # shift forward by one space
      sw $s0, 0($t7) # store col index
      addi $t7, $t7, 4 # shift forward by one space
      
      unprime
      prime
        wraparound_colconst  # arr[X + 1][Y]
       jal wraparound_rowplus
      sw $s1, 0($t7) # store row index
      addi $t7, $t7, 4 # shift forward by one space
      sw $s0, 0($t7) # store col index
      addi $t7, $t7, 4 # shift forward by one space
      unprime
      prime
       jal wraparound_colplus  # arr[X + 1][Y + 1]
       jal wraparound_rowplus
        sw $s1, 0($t7) # store row index
      addi $t7, $t7, 4 # shift forward by one space
      sw $s0, 0($t7) # store col index
      addi $t7, $t7, 4 # shift forward by one spa
      unprime
    stack_pop
  exit_pull_wrappedAddresses :
    jr $ra
#################################################################################################################################    
#################################################################################################################################   

# an aside... so where we are now, we have a function that will get you -> a unit @ address and gameboard address given master index, and 
# a frameboard pointer. where do we take this? the game has to, for each space on the gameboard, identify if the value it stands on is a lion or a rabbit.
# if either one of those entities, it must que up the surrounding addresses, then choose a new position to move to. it must move to that position, then redraw
# its surroundings with respect to its initial point accordingly. let's accomplish that here.

play_a_full_round:

li $s0, 0
li $s1, 0 




gameplay_round_rows:
beq $s1, 32, exit_gameplay_round_rows

     
gameplay_round_cols:
beq $s0, 32, exit_gameplay_round_cols
     stack_push
     jal convert_master_index_to_gameboard # per column index, convert the master index into a gba address
     beq $a2, 14, lion_decision_tree
     beq $a2, 13, rabbit_decision_tree
     stack_pop
     return_from_decision_tree:
addi $s0, $s0, 1
j gameplay_round_cols
exit_gameplay_round_cols:
addi $s1, $s1, 1
li $s0, 0
j gameplay_round_rows
exit_gameplay_round_rows:
jr $ra


###################################     Rabbit Behavior Tree     ################################################################   
###################################                              ################################################################ 
rabbit_decision_tree:
stack_push
jal pull_wrappedAddresses

probe_random_within_wrappedAddressesR:
lw $0, 0($a1) # unwriting rabbit from current position

li $v0, 42
li $a1, 9 # random number between 0 and 8, choosing an index along the wrapped addresses
syscall

move $t3, $a1 # seizing wrapped address offset index into $t3
sll $t3, $t3, 3 # multiply by 8, index becomes true offset

s7wrappedAddresses
li $t4, 0
add $t4, $t3, $t4
add $t3, $s7, $t4 # now $t3 contains the address of the wrapped address position

prime2
lw $s1, 0($t3) # loading row index from wrapped address
addi $t3, $t3, 4
lw $s0, 0($t3) # loading column index 
jal convert_master_index_to_gameboard
unprime2
beq $a2, 11, probe_random_within_wrappedAddressesR
beq $a2, 13, probe_random_within_wrappedAddressesR

li $t3, 13        ### write a rabbit into the gameboard
sw $t3, 0($a1)

jal draw_9x9

stack_pop
j return_from_decision_tree
###################################      Lion Behavior Tree      ################################################################  
###################################                              ################################################################ 
lion_decision_tree:
stack_push
jal pull_wrappedAddresses

probe_random_within_wrappedAddressesL:
lw $0, 0($a1) # unwriting lion from current position


li $v0, 42
li $a1, 9 # random number between 0 and 8, choosing an index along the wrapped addresses
syscall
move $t3, $a1 # seizing wrapped address offset index into $t3
sll $t3, $t3, 3 # multiply by 8, index becomes true offset
s7wrappedAddresses
li $t4, 0
add $t4, $t3, $t4
add $t3, $s7, $t4 # now $t3 contains the address of the wrapped address position

prime2
lw $s1, 0($t3) # loading row index from wrapped address
addi $t3, $t3, 4
lw $s0, 0($t3) # loading column index 
jal convert_master_index_to_gameboard
unprime2

beq $a2, 11, probe_random_within_wrappedAddressesL
beq $a2, 14, probe_random_within_wrappedAddressesL

li $t3, 14        ### write a lion into the gameboard
sw $t3, 0($a1)

jal draw_9x9

stack_pop
j return_from_decision_tree
###################################           Draw 9X9           ################################################################  
###################################                              ################################################################ 

draw_9x9:
stack_push

jal pull_wrappedAddresses
s7wrappedAddresses

li $t5, 0 # t5


la $t7, wrappedAddresses
draw_9x9_linear_loop:
beq $t5, 72, end_draw_9x9_linear_loop
lw $s1, 0($t7) #row index
addi $t7, $t7,4
addi $t5, $t5, 4
lw $s0, 0($t7) # col index
addi $t7, $t7,4
addi $t5, $t5, 4

jal convert_master_index_to_gameboard
jal convert_gameboard_address_to_framePointer 
jal draw_from_entity_value
j draw_9x9_linear_loop

end_draw_9x9_linear_loop:
stack_pop
end_draw_9x9:
jr $ra