# Name: Vansh Joshi
# Date: 9/29/2024
# CS230 - Floating Point Program
# Overview: 

.section .text
.global map
map:
    # Need to save caller-saved registers that will be used across function calls
    addi    sp, sp, -48     # Make space for ra, s0-s5, fs0
    sd      ra, 40(sp)
    sd      s3, 32(sp)      # For mapping_func
    sd      s4, 24(sp)      # For num_values
    sd      s5, 16(sp)      # For loop counter i
    fsd     fs0, 8(sp)      # For map_value
    
    fmv.d   fs0, fa0       # Move map_value into fs0
    mv      s3,  a2        # mapping_func address is now in s3
    mv      s4, a1         # Move num_values into s4
    li      s5, 0          # uint64_t i
    
1:  
    bge     s5, s4, 1f       # Jump out if i >= num_values
    slli    t0, s5, 3       # i * 8 (for double offset)
    add     t0, a0, t0      # values + i*8
    
    fld     fa0, 0(t0)      # fa0 = *(double*)s0
    
    #  Setup fa0 (values[i])
    fmv.d   fa1, fs0      # Set double right = map_value
    jalr    s3            # mapping_func(fa0, fa1)
    
    slli    t0, s5, 3       # i * 8 (for double offset)
    add     t0, a0, t0      # values + i*8
    fsd     fa0, 0(t0)      # *(double*)s4 = ft0
    
    #  Store fa0, the return value, back into values[i]
    addi    s5, s5, 1     # i++
    j       1b            # Loop again
    
1:  
    # Restore saved registers
    ld      ra, 40(sp)
    ld      s3, 32(sp)
    ld      s4, 24(sp)
    ld      s5, 16(sp)
    fld     fs0, 8(sp)
    addi    sp, sp, 48
    ret

.global map_add
map_add:
    fadd.d  fa0, fa0, fa1
    ret

.global map_sub
map_sub:
    fsub.d  fa0, fa0, fa1
    ret

.global map_min
map_min:
    fmin.d  fa0, fa0, fa1
    ret

.global map_max
map_max:
    fmax.d  fa0, fa0, fa1
    ret
