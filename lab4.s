# Name: Vansh Joshi
# Date: 10/27/2024
# CS230 - Structures Program
# Overview: This program calculates the hypotenuse and angles of a triangle
# Worked with: Grant

.section .text
.global make_triangle
make_triangle:
    # save registers
    addi    sp, sp, -16
    sd      ra, 0(sp)
    sd      s0, 8(sp)
    mv      s0, a0

    # store s0 (side0)
    fsw     fa0, 0(s0)

    # store s1 (side1)
    fsw     fa1, 4(s0)

    # calculate hypotenuse = sqrtf(side0 * side0 + side1 * side1)
    fmul.s  ft0, fa0, fa0   # side0 * side0
    fmul.s  ft1, fa1, fa1   # side1 * side1
    fadd.s  fa0, ft0, ft1   # fa0 = side0^2 + side1^2
    call    sqrtf
    fsw     fa0, 8(s0)

    # calculate theta0 = asinf(side0 / hypotenuse)
    flw     ft0, 0(s0)      # load side0
    flw     ft1, 8(s0)      # load hypotenuse
    fdiv.s  fa0, ft0, ft1   # fa0 = fa0 / fs1
    call    asinf           # fa0 = asinf(fa0)
    fsw     fa0, 12(s0)     # rt.theta0 = asinf(fa0)

    # calculate theta1 = asinf(side1 / hypotenuse)
    flw     ft0, 4(s0)      # load side1
    flw     ft1, 8(s0)      # load hypotenuse
    fdiv.s  fa0, ft0, ft1   # fa0 = fa0 / fs1
    call    asinf           # fa0 = asinf(fa0)
    fsw     fa0, 16(s0)     # rt.theta1 = asinf(fa0)

    # restore registers
    mv      a0, s0        
    ld      ra, 0(sp)     
    ld      s0, 8(sp)   
    addi    sp, sp, 16    
    ret
