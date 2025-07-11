# Name: Vansh Joshi
# Date: 11/10/2024
# CS230 - Mud Program
# Overview: This program is a MUD game
# Worked with: Grant Buchanan

.section .rodata
exit_string: .asciz "%s\n%s\nExits: "
n_string:   .asciz "n "
e_string:   .asciz "e "
s_string:   .asciz "s "
w_string:   .asciz "w "
newline:    .asciz "\n"

.section .text
.global look_at_room
look_at_room:
    addi    sp, sp, -16           # Allocate stack space
    sd      ra, 0(sp)
    sd      s0, 8(sp)
    mv      s0, a0

    ld      a1, 0(s0)             # You will need to load the title
    ld      a2, 8(s0)             # You will need to load the description
    la      a0, exit_string       # Load the address of exit_string into a0
    call    printf

    lw      t0, 16(s0)            # Loading the exit array
    li      t1, -1                # Loading -1 to compare
    la      a0, n_string
    beq     t0, t1, check_east    # If exits[0] == -1 go to east
    call    printf

check_east:
    lw      t0, 20(s0) 
    li      t1, -1
    la      a0, e_string
    beq     t0, t1, check_south
    call    printf

check_south:
    lw      t0, 24(s0) 
    li      t1, -1
    la      a0, s_string
    beq     t0, t1, check_west
    call    printf

check_west:
    lw      t0, 28(s0)   
    li      t1, -1
    la      a0, w_string
    beq     t0, t1, 1f
    call    printf

1:
    la      a0, newline            # load the newline
    call    printf
    ld      ra, 0(sp)
    ld      s0, 8(sp)
    addi    sp, sp, 16
    ret

.global look_at_all_rooms
look_at_all_rooms:
    addi    sp, sp, -32         
    sd      s0, 0(sp)           # rooms array pointer
    sd      s1, 8(sp)           # num_rooms
    sd      s2, 16(sp)          # loop counter
    sd      ra, 24(sp)

    mv      s0, a0
    mv      s1, a1
    li      s2, 0

    1:
        bge     s2, s1, 1f      # exit if counter >= number of rooms

        slli    t1, s2, 5       # i * 32
        add     a0, t1, s0
        call    look_at_room
        la      a0, newline     # load newline
        call    printf

        addi    s2, s2, 1
        j       1b              # jump back to loop start

    1:
        # Restore registers
        ld      s0, 0(sp)
        ld      s1, 8(sp)
        ld      s2, 16(sp)
        ld      ra, 24(sp)
        addi    sp, sp, 32
        ret 

.global move_to
move_to:
    mv      t0, a1          # current room
    mv      t1, a2          # direction
    addi    t0, t0, 16      # current + 16
    slli    t3, t1, 2       # direction * 4
    add     t3, t3, t0    
    lw      t3, 0(t3)  
    li      t4, -1     
    beq     t3, t4, 1f      # if exits[direction] == -1 go to forward
    slli    t3, t3, 5       # exits[direction] * room struct size
    add     a0, a0, t3      # rooms + current->exits[direction]
    ret    
    
    1:
    mv      a0, zero        # return nullptr
    ret
    