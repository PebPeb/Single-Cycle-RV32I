
.section .text

.global _start


_start:
    li a0, 10
    li a1, 10
    jal ra, INT_MULT

inf_loop:
    jal inf_loop
