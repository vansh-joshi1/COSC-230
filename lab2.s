# Name: Vansh Joshi
# Date: 9/29/2024
# CS230 - Functions Program
# Overview: This program returns a random number between a minimum and a maximum number

.section .text
.global get_rand
get_rand:
    # int64_t get_rand(int64_t mn, int64_t mx) {
    #    return mn + rand() % (mx - mn + 1);
    # }

    # Registers:
    # a0 get_rand(a0 mn, a1 mx) {
    #    return mn + rand() % (mx - mn + 1);
    # }

    # allocate stack space and save registers
    addi    sp, sp, -32      # ra + s0 + s1 = 24 bytes aligned to 32
    sd      ra, 0(sp)        # Save return address
    sd      s0, 8(sp)        # Save old s0
    sd      s1, 16(sp)       # Save old s1

    # save arguments to saved registers
    mv      s0, a0           # minimum
    mv      s1, a1           # maximum

    call     rand             # rand()

    # perform calculations
    sub      t0, s1, s0      # t0 = mx - mn
    addi     t0, t0, 1       # t0 = mx - mn + 1
    rem      t1, a0, t0       # t1 = rand() % (mx - mn + 1)
    add      a0, s0, t1       # a0 = mn + rand() % (mx - mn + 1)

    # restore saved registers and deallocate stack
    ld       ra, 0(sp)         # restore return address
    ld       s0, 8(sp)         # restore original s0
    ld       s1, 16(sp)        # restore original s1
    addi      sp, sp, 32       # Move stack back (deallocate)

    ret