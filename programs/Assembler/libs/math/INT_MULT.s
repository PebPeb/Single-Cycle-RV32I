
# By: Bryce Keen    
# Date: 06/08/2023            

# INT_multiply.s
# ---------------------------------------------------
#   This lib is for the multiplication of two 32 bit
# integer values.
#                   A * B
#   x10 <- A
#   x11 <- B
#   results -> x10

.equ IS_NEG, 1

.section .text

.global INT_MULT

INT_MULT:
    beq a0, x0, return_zero         # If A == 0 
    beq a1, x0, return_zero         # If B == 0 

    xor t1, t1, t1                  # clear
    xor t2, t2, t2                  # clear
is_a_neg:
    blt zero, a0, is_b_neg          # Check if A is not negative
    li t1, IS_NEG
    neg a0, a0
is_b_neg:   
    blt zero, a1, optimize_loop     # Check if B is not negative
    li t2, IS_NEG
    neg a1, a1

optimize_loop:
    blt a1, a0, use_B               # B < A
    mv t0, a0                       # Use A for counter
    beq x0, x0, clr_return_reg            
use_B:
    mv t0, a1                       # Use B for counter
    mv a1, a0
clr_return_reg:
    xor a0, a0, a0                  # Wipe return register

loop:
    add a0, a0, a1
    addi t0, t0, -1
    bne t0, zero, loop
neg_check:                          
    beq t1, t2, return_program      # If t1 & t2 are the same then (+ * +) or (- * -) = +
    neg a0, a0                      # Else negate
return_program:
    ret
return_zero:
    xor x10, x10, x10
    ret
