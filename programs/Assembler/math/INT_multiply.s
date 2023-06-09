
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

.section .text

.global _start


_start:
    addi x10, x0, 8
    addi x11, x0, 16
    jal mult
inf_loop:
    jal inf_loop

mult:
    beq x10, x0, end
    beq x11, x0, end
    mv x5, x10
    xor x10, x10, x10
loop:
    add x10, x10, x11
    addi x5, x5, -1
    bne x5, x0, loop
    ret
end:
    xor x10, x10, x10
    ret
