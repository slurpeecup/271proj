


.data

lions_won .asciiz "Rabbits have gone extinct, Lions win." 
rabbits_won .asciiz "Lions have gone extinct, Rabbits win."


.text

gameboard_generation:

addi $sp, $sp, -1600 # initializing gameboard size on stack
la $sp, 0($s0) #assignment of base game board address to $s0 register
li $s1, 400 # assignment of all tile count to register $s1

add $t0, $zero, 0 #clearing value in $t0
init_tile_val: #initializes value of each tile
bne $t0, $s1, exit_init_tile_val # "while $t0 != 400



######################33 random number generated in this sub block
li $a1, 14
li $v0, 42
syscall
######################
sb $a0, ##t something offset from $SP

j init_tile_val

exit_init_tile_val:
