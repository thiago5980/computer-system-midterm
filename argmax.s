.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 is the pointer to the start of the vector
#	a1 is the # of elements in the vector
# Returns:
#	a0 is the first index of the largest element
# =================================================================
argmax:
    # Prologue
   addi sp sp -16
   sw t0 0(sp)
   sw t1 4(sp)
   sw t2 8(sp)
   sw t3 12(sp)

   add t0 x0 x0
   lw t2 0(a0)

loop_start:
   beq a1 t0 loop_end
   addi t0 t0 1
   lw t1 0(a0)
   bge t1 t2 loop_continue
   addi a0 a0 4
   j loop_start

loop_continue:
   lw t2 0(a0)
   add t3 t0 x0
   addi a0 a0 4
   j loop_start

loop_end:
   addi a0 t3 -1

    # Epilogue
   lw t0 0(sp)
   lw t1 4(sp)
   lw t2 8(sp)
   lw t3 12(sp)
   addi sp sp 16
    ret
