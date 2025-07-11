# Name: Vansh Joshi
# Date: 9/15/2024
# CS230 - First Assembly Program
# Overview: This program takes in integers and calculates the sum and the product

.section .text
.global sum_prod
sum_prod:
	# int32_t (a0)
    #     sum_prod
    #        const int32_t values[] (a0)
    #        uint64_t num_values    (a1)
    #        int32_t &product       (a2)
    # Rewritten:
    # a0      sum_prod (a0, a1, a2)
	
	# using temporary registers to store the iterator, sum, product
	li    t0, 0   # Use t0 for the sum
	li    t1, 1   # Use t1 for the product

	li    t2, 0   # Use t2 for i

1: # backwards
	bge     t2, a1, 1f

	slli    t3, t2, 2    # t3 = t2 * 4
	add     t3, t3, a0   # t3 = &values[i]
	
	# to derefrence use to load
	lw      t4, 0(t3)	 # t4 = values[i]

	add     t0, t0, t4	 # t0 (sum)     += t4 (values[i])
	mul     t1, t1, t4   # t1 (product) *= t4 (values[i])

	addi    t2, t2, 1    # i += 1
	j       1b           # jump back to the loop codition

1: # exit the loop/forwards
	mv      a0, t0       # return register a0 = t0 (accumulating sum)
	sw      t1, 0(a2)    # *product = t1 (accumulating product)

	ret
