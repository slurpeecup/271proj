.data
        frameBuffer : .space 0x40000 ##4 byte spaces = 256 bytes per 32 elements per rows * 32 rows. 256 * 32 * 32 = 262144 byte or 0x40000 bytes
        gameboard : .word 0 : 1023 ##32 * 32 x 4 byte words = the range of words from 0 to 1024
        surroundingBuffer : .space 0x50
        wrappedAddresses : .space 0x50
        rabbit_brain : .space 0x50
        registerStack1 : .space 0x50
        index_within_decision_tree_loop : .space 0x4        #less effort than restructuring
 
  .macro stash_t_registers1
        la $s7, registerStack1 # setting pointer control to register stack 1
        sw $t0, 0($s7)
        sw $t1, 4($s7)
        sw $t2, 8($s7)
        sw $t3, 12($s7)
        sw $t4, 16($s7)
        sw $t5, 20($s7)  ## storing all tempregs
        sw $t6, 24($s7)
        sw $t7, 28($s7)
        sw $t8, 32($s7)
        sw $t9, 36($s7)
  .end_macro
 
  .macro pull_t_registers1
        la $s7, registerStack1 # setting pointer control to register stack 1
        lw $t0, 0($s7)
        lw $t1, 4($s7)
        lw $t2, 8($s7)
        lw $t3, 12($s7)
        lw $t4, 16($s7)
        lw $t5, 20($s7)  ## storing all tempregs
        lw $t6, 24($s7)
        lw $t7, 28($s7)
        lw $t8, 32($s7)
        lw $t9, 36($s7)
  .end_macro
 
  .macro RST_FRAMEPTR ### this macro resets the value of $a3 to the frame pointer
        la $a3, frameBuffer ### this trick is useful in functions where $a3 is a parameter
        .end_macro ### indexing the location in memory of a dataword w / respect to its distance
        ### from the initial frame buffer
 
        .macro RST_TICKER ### utilizing $t9 as a designated incrementer for painting onto the bitmap display
        li $t9, 0 ### this macro resets said incrementer to 0
  .end_macro
 
  .macro RST_TICKER_2 ### utilizing $t8 as a designated incrementer for
        li $t8, 0 ### painting onto the bitmap display.This macro resets
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
 
  .macro s7wrappedAddresses
        la $s7, wrappedAddresses
  .end_macro
 
  .macro s7surroundingBuffer
        la $s7, wrappedAddresses
  .end_macro
 
  .macro s7registerStack1
        la $s7, registerStack1
  .end_macro
 
  .macro wraparound_rowconst
        addi $t5, $t1, 0 ## this was honestly just too trivial to turn into a function,
  .end_macro       ## but a necessary abstraction for the sake of consistency
 
  .macro wraparound_colconst
        addi $t4, $t1, 0 ## this was honestly just too trivial to turn into a function,
  .end_macro       ## but a necessary abstraction for the sake of consistency

            ####################### CONSOLE OUTPUT SHIT, PROBABLY DEPRECATED ################################
    lions_won:.asciiz "Rabbits have gone extinct, Lions win."
    rabbits_won : .asciiz "Lions have gone extinct, Rabbits win."
    simulation_begin : .asciiz "Starting simulation\n"

    .text


  main :
  ######## s3, s4 reserved for end game conditions.
      li $t0, 0 # loop incrementer
      li $t1, 0 # pos tracker 4 array
      la $s0, gameboard  #load initial address of gameboard label into a persistent point
      la $t2, gameboard
      jal game_init ### sets initial conditions into the gameboard array
      
      la $a0, simulation_begin
      li $v0, 4
      syscall

    jal paint_full_grid


    endgame_condition_not_met_reset:
      s7gameboard
        li $t0, 0
        li $t1, 0
          stack_push
              jal play_a_unit ### assuming $t0 is colindex and $t1 is rowindex.
          stack_pop


  jal count_all_rabbits

  bne $s3, 0, endgame_condition_not_met_reset # are lions == 0 ?
  bne $s4, 0, endgame_condition_not_met_reset # are rabbits == 0 ?

  li $v0, 10
  syscall

  ########################################################
  game_init : # initialize the values in the gameboard
     bge $t0, 1024, init_done # while board is not filled
       li $a1, 15 #limit for RNG, to be replaced w / LFSR altho discuss w arnie.
       li $v0, 42 # syscall for rng
           syscall
       move $t1, $a0 #store RNG value into a tempreg
     bgt $t1, 10, ctne_fr_norm #if equal to or below 10, normalize to 0,
        # indicating an open space for the player. else, continue from norm.
        addi $t1, $zero, 0 ## normalizes the value
     j ctne_fr_norm
   ctne_fr_norm :
     sw $t1, 0($t2) # stores the RNG value into the address indicated by $t2
     addi $t2, $t2, 4 # offsets $t2 for the next element, heap grows up
     addi $t0, $t0, 1 # increments counter
   j game_init ### jump to top until condition is met
  init_done :

  ############SPRITE PAINT FUNCTIONS#########

  paint_background:
     RST_FRAMEPTR
     addi $a2, $zero, 0xffe6ba ## color : sand
     li $t1, 0x40000 ### loading into $t1 the size of the framebuffer, consider this an xmax value
     s7framePointer #setting the value of s7 to the frame pointer
     add $t1, $t1, $s7 ### s7 holds the address of the frame pointer
     li $t0, 0 ### loading into $t0 0, $t0 will increment up to the xmax of the framebuffer
  start_paint_pixel :
     beq $a3, $t1, exit_paint_pixel
       sw $a2, 0($a3) #$a2 will generally store a color value BY THE TIME this function is called
       addi $a3, $a3, 4 #increment to the next address that we'll store a color into 
     j start_paint_pixel ### jump back to the top of the loop until conditions are met
  exit_paint_pixel :
     jr $ra

  paint_L :
       RST_TICKER ## resets counter variable
       addi $a2, $zero, 0xff6e7f # writes color to $a3
     beq $a3, $t1, exit_paint_L ## until framePTR = maxFrame
  vertical_line_loop :
     bgt $t9, 5, vertical_line_loop_end ### t2 used as increment CTR
       sw $a2, 0($a3) ### writes the color stored into $a2 to the location on the bitmap frame
       addi $a3, $a3, 4 # increments to the next position on the bitmap frame
       sw $a2, 0($a3) #writes color, again, for a width of now 2px
       addi $a3, $a3, 1020 ### skip row - 1 because of the length of the width of L stem
       sw $a2, 0($a3) #writes again 1 px
       addi $t9, $t9, 1 ## incrementing small ticker
     j vertical_line_loop
  vertical_line_loop_end : ### stem drawn
     li $t9, 0
  horizontal_line_loop:
     addi $t9, $t9, 1 ### incrementing ticker again, register - conservey but annoying
  horizontal_line_loop_row : ### draws the two long sides of the L
     beq $t9, 8, row_loop_end # end condition ticker
     beq $t9, 18, horizontal_line_loop_end # sub_end condition
       addi $a3, $a3, 4 # increment
       sw $a2, 0($a3) #write
       addi $t9, $t9, 1 # increment interior ticker
     j horizontal_line_loop_row
  row_loop_end :
     addi $a3, $a3, 992 # jump row
     addi $t9, $t9, 1 #increment exterior ticker
     j horizontal_line_loop
  horizontal_line_loop_end :
  exit_paint_L:
     RST_TICKER
     jr $ra

  paint_X :
      addi $a3, $a3, 7168 #### jumps to bottom right corner of bmp 8px * 8px sprite region
      addi $a2, $zero, 0xff0000 ### write color
      RST_TICKER # reset ticker
     forward_slash :
       beq $t9, 8, forward_slash_done ### end condition from bottom right to top left of X
         sw $a2, 0($a3) #write
       beq $t9, 3, skip_center_up_done
         addi $a3, $a3, 4 # increment
         sw $a2, 0($a3) #write
     skip_center_up_done : # skip upwards in diagonal fashion
       addi $a3, $a3, -1024 # skip up one row in BMP
       addi $t9, $t9, 1 # increment a ticker of some fucking sort
       j forward_slash
     forward_slash_done :
       RST_TICKER
       addi $a3, $a3, 996 # jump ahead from neg incrementation,
       ## corrective measure for an algorithmic deficiency that i do not care
       ##  enough to correct at this time
     back_slash :
       beq $t9, 8, back_slash_done ## conditional branch
       sw $a2, 0($a3) ## writing color
       beq $t9, 3, skip_center_down_done # conditional branch
       addi $a3, $a3, 4 # increment to next position
       sw $a2, 0($a3) #write
     skip_center_down_done :
       addi $a3, $a3, 1024 #same as above.
       addi $t9, $t9, 1
       j back_slash
     back_slash_done :
  exit_paint_X:
  RST_TICKER
  jr $ra

  paint_S :
     RST_TICKER
     RST_TICKER_2
       addi $a2, $zero, 0x919191 # loads color into $a2
   paint_S_row_loop :
     beq $t8, 8, paint_S_row_loop_end # conditional branch
     RST_TICKER
   paint_S_column_loop :
     beq $t9, 8, paint_S_column_loop_end # conditional branch
       sw $a2, 0($a3) # writing color into frame position
       addi $a3, $a3, 4 # increment to next position on frame
       addi $t9, $t9, 1 ## increment ticker
     j paint_S_column_loop
   paint_S_column_loop_end :
       addi $a3, $a3, 992 # jump to next row - offset of 32 for byte width of square row
       addi $t8, $t8, 1 # increment ticker
     j paint_S_row_loop
   paint_S_row_loop_end :
     RST_TICKER
     RST_TICKER_2
  exit_paint_S :
  jr $ra

  paint_F :
     addi $a3, $a3, 2048 ## set initial position
     addi $a2, $zero, 0x57d5de
   RST_TICKER
  paint_F_flat_top :
     beq $t9, 6, paint_F_flat_top_end ### draws the first row of the 'pill' shape
        addi $a3, $a3, 4
        sw $a2, 0($a3)
        addi $t9, $t9, 1
     j paint_F_flat_top
  paint_F_flat_top_end : ## end of top row
        addi $a3, $a3, 996
     RST_TICKER
     RST_TICKER_2
  paint_F_BODY : ### draws three rows of pill
     RST_TICKER
    beq $t8, 3, paint_F_BODY_exit
       body_width :
       beq $t9, 8, paint_f_body_width_end
       addi $a3, $a3, 4
       sw $a2, 0($a3)
       addi $t9, $t9, 1
     j body_width
   paint_f_body_width_end :
       addi $a3, $a3, 992
       addi $t8, $t8, 1
   j paint_F_BODY
  paint_F_BODY_exit : ## end draw three rows
     RST_TICKER
   addi $a3, $a3, 4 ### shunt forward 1 px to give rounded edge
  paint_F_flat_bottom : ### draw bottom row of pill
     beq $t9, 6, paint_F_flat_bottom_end
        addi $a3, $a3, 4
        sw $a2, 0($a3)
        addi $t9, $t9, 1
     j paint_F_flat_bottom
  paint_F_flat_bottom_end :
  exit_paint_F:
     RST_TICKER
     RST_TICKER_2
  jr $ra


  paint_R :
  RST_TICKER
  RST_TICKER_2
  addi $a2, $zero, 0xfcba47
  paint_R_stem :
      beq $t8, 8, paint_R_stem_end
      RST_TICKER
      paint_R_stem_width_loop :
    beq $t9, 3, paint_R_stem_width_loop_end
      sw $a2, 0($a3)
      addi $a3, $a3, 4
      addi $t9, $t9, 1
   j paint_R_stem_width_loop
  paint_R_stem_width_loop_end :
    addi $a3, $a3, 1012
    addi $t8, $t8, 1
   j paint_R_stem
  paint_R_stem_end :
    RST_TICKER
    RST_TICKER_2
     addi $a3, $a3, -8180
  paint_R_top_loop :
    beq $t9, 4, paint_R_top_loop_end
      sw $a2, 0($a3)
      addi $a3, $a3, 4
      addi $t9, $t9, 1
    j paint_R_top_loop
  paint_R_top_loop_end :
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
  paint_R_middle_loop_end :
     addi $a3, $a3, 1004
     RST_TICKER
  paint_R_leg_down :
   beq $t9, 4, paint_R_leg_down_end
     addi $a3, $a3, 4
     sw $a2, 0($a3)
     addi $a3, $a3, 4
     sw $a2, 0($a3)
     addi $a3, $a3, 1020
     addi $t9, $t9, 1
   j paint_R_leg_down
  paint_R_leg_down_end :
    RST_TICKER
    RST_TICKER_2
  paint_R_exit :
    jr $ra

  erase_char :
   RST_TICKER
   RST_TICKER_2
    addi $a2, $zero, 0xffe6ba
     stack_push
       jal paint_S_row_loop
       return_from_paint_S :
     stack_pop
  jr $ra

  ###########################################
  ###########################################
  paint_unit:
   bne $a2, 27, exit_set_combat_X############# BIG WARNING CUS I DIDN'T DOCUMENT ANYTHING
    #$a2 ONLY STORES COLOR VALUE AFTER ENTITY TYPE IS DETERMINED
  set_combat_X :
    stack_push
      jal paint_X
    stack_pop
   j paint_unit_complete
  exit_set_combat_X :

    bne $a2, 14, exit_lion_X
  set_lion_X :
     stack_push
       jal paint_L
     stack_pop
   j paint_unit_complete
  exit_lion_X :

    bne $a2, 13, exit_rabbit_X
  set_rabbit_X :
     stack_push
      jal paint_R
     stack_pop
    j paint_unit_complete
  exit_rabbit_X :

    bne $a2, 12, exit_food_X
  set_food_X :
    stack_push
     jal paint_F
    stack_pop
   j paint_unit_complete
  exit_food_X :

    bne $a2, 11, exit_stone_X
  set_stone_X :
  stack_push
  jal paint_S
  stack_pop
  j paint_unit_complete
  exit_stone_X :

    bne $a2, 0, paint_unit_complete
  set_empty_char_x :
  stack_push
  jal erase_char
  stack_pop
  paint_unit_complete :
  jr $ra
  ################################
  paint_full_grid :
      li $a2, 0
      li $a3, 0
      li $t0, 0 ## resetting tickers if not already handled
      li $t1, 0 ## designating $t1 as row ticker
      la $t3, gameboard
      RST_TICKER
      RST_TICKER_2

      paint_per_array_row :

  beq $t1, 32, exit_paint_per_array_row
  li $t0, 0
  paint_per_array_col :
      beq $t0, 32, exit_paint_per_array_col

      sll $a3, $t1, 5
      add $a3, $a3, $t0
      sll $a3, $a3, 2
      s7gameboard
      add $a3, $a3, $s7

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
  exit_paint_per_array_col :
      addi $t1, $t1, 1 ### incrementing the row counter
      j paint_per_array_row
  exit_paint_per_array_row :
  exit_paint_full_grid:
      jr $ra
  ###################################
  # assuming iterative looping through the array
  # we will have a row index, a column index, and
  # we know we have a fixed number of columns because
  # fuck dynamically allocating that lmao.
  # lets assume $t0 is our column index, and $t1
  # is our row index.

  # given these parameters, we can easily write a suite of functions

  # suite A : gauge surroundings::universal to both lionsand rabbits

  # if a lion or rabbit is encountered, its surroundings are logged into the
  # surroundingBuffer.First, we will need to overcome wraparound.


  wraparound_rowminus:
    # laboring under the assumption that $t1 is our row index
    addi $t5, $t1, 0 #t4 contains the new row index
    addi $t5, $t5, 31 # (rowIndex - 1 + 32)
    div $t5, $s5 # div w / intent to access remainder from mfhi, effectively mod32
    mfhi $t5 # $t5 mod 32
  end_wraparound_rowminus:
    jr $ra

  wraparound_rowplus :
    # laboring under the assumption that $t1 is our row index
    addi $t5, $t1, 0 #t5 contains the new row index
    addi $t5, $t5, 33 # (rowIndex + 1 + 32)
    div $t5, $s5 # div w / intent to access remainder from mfhi, effectively mod31
    mfhi $t5 # $t4 mod 32
  end_wraparound_rowplus:
    jr $ra

  wraparound_colminus :
    #laboring under the assumption that $t0 is our column index
    addi $t4, $t0, 0 # $t4 = col index
    addi $t4, $t4, 31 # (colindex - 1 + 32)
    div $t4, $s5 #mod
    mfhi $t4 #mod
  end_wraparound_colminus :
    jr $ra

  wraparound_colplus :
    #laboring under the assumption that $t0 is our column index
    addi $t4, $t0, 0 # $t4 = col index
    addi $t4, $t4, 31 # (colindex - 1 + 32)
    div $t4, $s5 #mod
    mfhi $t4 #mod
  end_wraparound_colplus :
    jr $ra

  row_major_address_calc :
    s7gameboard
    ### at this point, consolidate everything into $t5.other tempregs now free after use
    ### the value of $t5 // $t4 governed by the wraparound funcs
    mul $t5, $t5, $s5 #(row_index * numcols)
    add $t5, $t5, $t4 # (row_index * numcols) + col Index)
    sll $t5, $t5, 2 # [(row_index * numcols) + col Index] << bytewidth
    add $t5, $t5, $s7 # base address + { [(row_index * numcols) + col Index] << bytewidth}
  end_row_major_address_calc:
    jr $ra
  ### at this point, we have accounted for that shitty, annoying wraparound
  ### time to store the surroundings of the entity


  pull_address_pos1 :
    stack_push
      jal wraparound_colminus  ## arr[X - 1][Y - 1]
      jal wraparound_rowminus
      jal row_major_address_calc # the address we want is stored in $t5
    stack_pop
  exit_pull_address_pos1 :
    jr $ra

  pull_address_pos2 :
    stack_push
      wraparound_colconst ## arr[X - 1][Y]
      jal wraparound_rowminus
      jal row_major_address_calc # the address we want is stored in $t5
    stack_pop
  exit_pull_address_pos2 :
      jr $ra

  pull_address_pos3 :
    stack_push
      jal wraparound_colplus  ## arr[X - 1][Y + 1]
      jal wraparound_rowminus
      jal row_major_address_calc # the address we want is stored in $t5
    stack_pop
  exit_pull_address_pos3 :
    jr $ra
 
  pull_address_pos4 :
    stack_push
      jal wraparound_colminus  ## arr[X][Y - 1]
      wraparound_rowconst
      jal row_major_address_calc # the address we want is stored in $t5
    stack_pop
  exit_pull_address_pos4 :
    jr $ra

  pull_address_pos5 :
    stack_push
      wraparound_colconst  ## arr[X][Y]
      wraparound_rowconst
      jal row_major_address_calc # the address we want is stored in $t5
    stack_pop
      exit_pull_address_pos5 :
  jr $ra

  pull_address_pos6 :
    stack_push
      jal wraparound_colplus  ## arr[X][Y + 1]
      wraparound_rowconst
      jal row_major_address_calc # the address we want is stored in $t5
    stack_pop
  exit_pull_address_pos6 :
    jr $ra

  pull_address_pos7 :
    stack_push
      jal wraparound_colminus ## arr[X + 1][Y - 1]
      jal wraparound_rowplus
      jal row_major_address_calc # the address we want is stored in $t5
    stack_pop
  exit_pull_address_pos7 :
     jr $ra

  pull_address_pos8 :
    stack_push
       wraparound_colconst  # arr[X + 1][Y]
       jal wraparound_rowplus
       jal row_major_address_calc # the address we want is stored in $t5
    stack_pop
  exit_pull_address_pos8 :
      jr $ra

  pull_address_pos9 :
    stack_push
       jal wraparound_colplus  # arr[X + 1][Y + 1]
       jal wraparound_rowplus
       jal row_major_address_calc # the address we want is stored in $t5
    stack_pop
  exit_pull_address_pos9 :
    jr $ra

  load_wrapped_addresses :
     s7wrappedAddresses # set $s7 to wrapped address microstack
     addi $s5, $s5, 32
     add $t7, $s7, $0 # write $s7 into $t7, wiper across the microstack
   stack_push
      jal pull_address_pos1
         sw $t5, 0($t7) # store pos_address into corresponding pos of microstack
         addi $t7, $t7, 4 # move up 1 pos in the microstack
      jal pull_address_pos2
         sw $t5, 0($t7) # store pos_address into corresponding pos of microstack
         addi $t7, $t7, 4 # move up 1 pos in the microstack
      jal pull_address_pos3
         sw $t5, 0($t7) # store pos_address into corresponding pos of microstack
         addi $t7, $t7, 4 # move up 1 pos in the microstack
      jal pull_address_pos4
         sw $t5, 0($t7) # store pos_address into corresponding pos of microstack
         addi $t7, $t7, 4 # move up 1 pos in the microstack
      jal pull_address_pos5
         sw $t5, 0($t7) # store pos_address into corresponding pos of microstack
         addi $t7, $t7, 4 # move up 1 pos in the microstack
      jal pull_address_pos6
         sw $t5, 0($t7) # store pos_address into corresponding pos of microstack
         addi $t7, $t7, 4 # move up 1 pos in the microstack
      jal pull_address_pos7
         sw $t5, 0($t7) # store pos_address into corresponding pos of microstack
         addi $t7, $t7, 4 # move up 1 pos in the microstack
      jal pull_address_pos8
         sw $t5, 0($t7) # store pos_address into corresponding pos of microstack
         addi $t7, $t7, 4 # move up 1 pos in the microstack
      jal pull_address_pos9
         sw $t5, 0($t7) # store pos_address into corresponding pos of microstack
         addi $t7, $t7, 4 # move up 1 pos in the microstack
   stack_pop # done populating the microstack
  end_load_wrapped_addresses : ## after these functions have ran their course, $t4 - 7 are free
      jr $ra
  ### surrounding info stack formatted as follows->address pos 1[+4] value pos 1 ... address pos 9[+4] value pos 9
  load_surroundings:
      s7wrappedAddresses #ensure s7 set to desired value
      addi $s5, $zero, 32 #ensure division control register is set to proper value
    stack_push
      jal load_wrapped_addresses # load wrapped addresses into their microstack
    stack_pop
        #$t4 - 7 are free
        addi $t4, $s7, 0 #$t4 will wipe across wrappedAddresses
        s7surroundingBuffer #ensure ptr control reg set to desired value
        addi $t5, $s7, 0 # $t5 will be the surroundingBuffer wiper
        li $t7, 0
  surroundings_fill_loop:
      beq $t7, 9, exit_surroundings_fill_loop # run this 9 times
        sw $t4, 0($t5)   # currently, $t4 holds address
        addi $t5, $t5, 4 # add one word to $t5
        lw $t6, 0($t4) # load value stored at offset from wrappedAddresses address into $t6
        sw $t6, 0($t5) # store value $t4 @ current address into the word above the address
        addi $t4, $t4, 4 # push forward microstack wiper by a dataword
        addi $t7, $t7, 1
      j surroundings_fill_loop
  exit_surroundings_fill_loop :
  ### $t4 - $t7 should free again after this point
  end_load_surroundings :
      jr $ra

  ########### now, let's consider the structure of our player behavior tree

  death_by_hunger:
    li $a1, 100  #random int from 0 - 99
    li $v0, 42
      syscall
   blt  $a0, 70, end_death_by_hunger
     s7wrappedAddresses #accessing the address of the player efficiently
     sw $zero, 16($s7)  # writing the value of 0 into
  end_death_by_hunger :
     jr $ra

  ### a preliminary note on rabbit_brain
  ###rabbit_brain is a microstack
  #0xn(+0) = empty flag set increment 1, 2->when 2, jump to empty loc 1
  #0xn(+4) = empty location - current empty location, overwritten each time
  #0xn(+8) = lion flag - sets flag for lion, avoid
  #0xn(+12) = lion location - writes lion location


  rabbit_decision_tree :
  ### allowing T registers to be overwritten and currently held values recalled upon returning to the main game array loop
   stash_t_registers1 # $t registers now cool to overwrite
          li $t9, 44  ### initial offset to l6
  position_in_surBufferR :
   s7surroundingBuffer
          la $s6, index_within_decision_tree_loop  ### a funky trick to combat poor register management, store& load one value
          sw $t9, 0($s6)                           ### pertaining to the index along the surrounding address buffer so that $t9
                                                   ### can be overwritten later
  
          beq $t9, 68, rst_t9R #$t9 at a 64 offset PLUS 8 from bottom
          add $s7, $s7, $t9 #position v6 is offset 4bytes * 5 * 2 words[loc] + 4 bytes(value) from surBuffer
         
          lw $t4, 0($s7) # adding directly to control pointer such that the offset on the buffer is closer to parametric
          la $s5, rabbit_brain # load the address of the rabbit brain
      j top_of_treeR
  rst_t9R :
          li $t9, 4 # resetting $t9 to FOUR, since we are looking at VALUES and decrementing from value to location
      j position_in_surBufferR
  top_of_treeR :
  lw $t3, 0($s7)
  ###############################################################################
  bne $t3, 14, exit_lion_decisionR #not a lion
  ###############################################################################

     s7surroundingBuffer ## redundance is the virtue of those with memory
     ### $t5 is brain pos control, #t3 flag control.
     lw $t9, 8($s5) # loading lion_flag from rabbit_brain # this can be a fixed value, static position.
  beq $t5, 1, lion_flag_onR # if lion flag is on, ugh damn gotta program
     addi $t4, $zero, 1 # set lion flag
     addi $t9, $t9, -4 #move pointer to lion location
     sw $t9, 12($s5) ## storing into location the offset to rabbit brain
  j lion_flag_offR
  lion_flag_onR :
     s7surroundingBuffer
          li $t9, 32  ### player location is offset by 32 from label
          add $s7, $s7, $t9
          lw $t3, 0($s7) # loading player current location into $t3
          sw $zero, 0($t3) # clearing the value in player current location
          lw $t3, 12($s5) # assuming the lion flag is on, load location of lion
          li $t2, 27 # can obliterate $t2 after this
          sw $t2, 0($t3) # store COMBAT value into the location of lion
    ## pass #t3 into the combat function.
      stack_push
         jal animal_combat
         jal draw9x9
      stack_pop
    j decision_madeR
  lion_flag_offR :
  #################################################################################
  exit_lion_decisionR:

  ###############################################################################
  bne $t4, 13, exit_rabbit_decision #rabbit
  ###############################################################################

  #given: $t4 contains the fact that we are looking @ a rabbit
    stack_push
       jal count_all_rabbits
  bgt $s4, 25, rabbit_moves_away #if rabbits more than 25
        jal find_random_empty_gameboard
          sw $t4, 0($s4) # write rabbit into random loc
        jal draw_by_address
  rabbit_moves_away :
        jal force_empty_position
         sw $t4, 0($s7) #store rabbit into the known empty slot
   s7surroundingBuffer   #### ready to purge rabbit from its current location in memory
        sw $zero, 32($s7) ### player location is offset by 32 from label
      jal draw9x9
    stack_pop
   j decision_madeR
  exit_rabbit_decision :


  ###############################################################################
  bne $t4, 12, exit_food_decisionR #food
  ###############################################################################

  food_decision_R:
     bne $t4, 11, stone_decisionR #stone
         addi $t9, $t9, -4 #### moving from value of food to location of the food
         li $t4, 13 ## prep to write rabbit
         sw $t4, 0($t3) ## writing rabbit into new location
     s7wrappedAddresses # shifting ptr to s7, need to un - write rabbit from curPos
         lw $t4, 16($s7) # offset by 5, address of player
         sw $0, 0($t4) # unwriting rabbit from the player position
      jal draw9x9
     j decision_madeR
  exit_food_decisionR :
  ###############################################################################

  stone_decisionR:
  beq $t4, 0, empty_space_decisionR
  j exit_space_decisionR
  exit_stone_decisionR :
  
  empty_space_decisionR:
   s7surroundingBuffer
      addi $t9, $t9, -4 #### moving from value of food to location of the empty
      li $t4, 13 ## prep to write rabbit
      add $t9, $t9, $s7
      sw $t4, 0($t9) ## writing rabbit into new location
    s7wrappedAddresses # shifting ptr to s7, need to un - write rabbit from curPos
      sw $0, 16($s7) # offset by 5, address of player
                     # unwriting rabbit from the player position
    jal draw9x9
  exit_space_decisionR :
      lw $t9, 0($s6)
      addi $t9, $t9, 8
    j position_in_surBufferR
  decision_madeR :
  end_rabbit_decision_tree:
      pull_t_registers1 # reset T registers to their former behavior
    jr $ra
    
    
    
    
    
  lion_decision_tree:
  end_lion_decision_tree:


  animal_combat:
  #use reg t2 cus fuck it
       li $v0, 42
       li $a1, 100
       syscall
    bgt $a0, 70, bias_against_rabbit # lion is most likely to win the fight
       li $t2, 14    # lion won the fight.
    j writing_combat_results
  bias_against_rabbit :
       li $t2, 13    # rabbit won the fight.
  writing_combat_results:
       sw $t2, 0($t9) #load winner value into the space.
  end_animal_combat:
       jr $ra

  count_all_rabbits :
      s7gameboard
      addi $t7, $s7, 4096 #xmax
  counting_rabbits :
    beq $s7, $t7, end_rabbit_count # if xmax, end
       lw $t6, 0($s7) # load val @ t7
    bne $t6, 13, no_rabbit # do not increment $s4 if rabbit
       addi $s4, $s4, 1 ## s4 rabbit count
  no_rabbit :
       addi $s7, $s7, 4 # push wiper forward
    j counting_rabbits
  end_rabbit_count :
       jr $ra


  count_all_lions :
    s7gameboard
       addi $t7, $s7, 4096 #xmax
  counting_lions :
    beq $s7, $t7, end_lion_count # if xmax, end
       lw $t6, 0($s7) # load val @ t7
    bne $t6, 13, no_rabbit # do not increment $s4 if rabbit
       addi $s4, $s4, 1 ## s4 rabbit count
  no_lion :
       addi $s7, $s7, 4 # push wiper forward
    j counting_lions
  end_lion_count :
       jr $ra

  find_random_empty_gameboard :
      s7gameboard
      li $v0, 42  #loading params for RNG
      li $a1, 1024
  probe_for_empty:
       syscall
       add $t8, $zero, $a0 ### set value to rng
       sll $t8, $t8, 2 ### multiply by 4 to account for bytewidth
       add $t8, $t8, $s7 ### add label
       add $s4, $0, $t8 ## i know this is a misuse of the persistent label, but idgaf
       lw $t8, 0($t8) ### probe position
    bne $t8, 0, probe_for_empty # if not empty, go again.
  exit_find_random_empty_gameboard:
       jr $ra


  force_empty_position :
    s7surroundingBuffer
  probe_for_empty_force :
       addi $s7, $s7, 8 # increment to next position
       lw $t8, 0($s7) #load position
    beq $t8, 12, empty_found_force #if not food
    bne $t8, $0, probe_for_empty_force # and not empty, try again.
  empty_found_force:
       addi $s7, $s7, -8 #correct for overshoot
  jr $ra


  #passing in s4 as an address
  draw_by_address :
       la $t4, gameboard ### setting $t4 to address
       sub $t4, $s4, $t4 # $t4 now equals distance WRT to label
       addi $t5, $0, 256
       div $t4, $t5 # how many rows + bytewidth
       mflo $t4 #t4 is quotient(row index)
       mfhi $t5 #t5 is remainder(col index)
    
       ### now ready for row major
       sll $t5, $t5, 3 # shifting col index
       sll $t4, $t4, 11 ## rowindex * scale * numcols
    
       add $t5, $t5, $t4 ## ((rowIndex * scale * numCols) + col Index * scale)
       sll $t5, $t5, 2 # mul by data byte width
    s7framePointer
       add $t5, $t5, $s7 # set address to framePointer
       add $a2, $0,$s4 # load into argument for paint_unit the value of the entity @ the poked addr
   stack_push
     jal paint_unit
   stack_pop
  end_draw_by_address :
      jr $ra

  draw9x9 :
    s7wrappedAddresses
       add $t6, $0, $s7 #t6 is the base ptr for wrapped addresses here
    stack_push
       ############
       addi $t9, $0, 0 # resetting t9 to be ticker

  looping_9x9 :
    beq $9, 9, done_with_9x9_draw
       lw $s4, 0($t6)
    jal draw_by_address
       addi $t6, $t6, 4
       addi $t9, $t9, 1
    j looping_9x9
  done_with_9x9_draw :
    stack_pop
  end_draw9x9 :
      jr $ra

  #li $t0, 0
  #li $t1, 0

  play_a_unit:

  gameplay_unit:

  unit_loop_row:
    stack_push
    beq $t1, 32, exit_unit_loop_row # row index incrementer maxsize
       li $t0, 0
  unit_loop_column:
    beq $t0, 32, exit_unit_loop_column # column index incrementer maxsize
  ## ((rowIndex * scale * numCols) + col Index * scale)
       add $t2, $0, $t1 # rowIndex in $t2
       mul $t2, $t2, 32 # #rowIndex * numcols
       add $t2, $t0, $t2 # rowIndex* ncols + colIndex
       sll $t2, $t2, 2  # rowIndex * ncols + colIndex ) << bytewidth
       add $t2, $t2, $s0 # #rowIndex * ncols + colIndex << bytewidth
       lw $t2, 0($t2) # load into $t2 the value @ t2

  beq $t2, 13, rabbit_in_unit_func
  beq $t2, 14, lion_in_unit_func
  bne $t2, 14, skip_in_unit_func

  in_unit_function_next :
       addi $t0, $t0, 1
    j unit_loop_column

  rabbit_in_unit_func :
    jal rabbit_decision_tree
    j in_unit_function_next
  lion_in_unit_func :
  #jump to lion, but not rn lollll
  skip_in_unit_func :
    j in_unit_function_next

  exit_unit_loop_column :
       addi $t1, $t1, 1
    j unit_loop_row
  exit_unit_loop_row :

    stack_pop
  exit_the_unit :
      jr $ra
  ################################################################################## TODO

  ##### play_round
  #### loop through each array element individually, left to right top to bottom.
  #### if value is correspondent to a lion or rabbit, branch to death by hunger
  ### if death by hunger does not return 0, branch to animals decision tree selector
  ### if death by hunger does return 0, return to position in loop_through_array

  ##### decision
  #### if value in tile is correspondent to a rabbit, jump to rabbit decision tree
  #### if value in tile is correspondent to a lion, jump to lion decision tree


  ##### rabbit_decision_tree
  ### Look counter - clockwise, starting @ pos 5
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
  ### if find empty, store value.Jump to subsequent empty or food.


  ############################# 
