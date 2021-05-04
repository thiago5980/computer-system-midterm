.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 is the pointer to the array
#	a1 is the # of elements in the array
# Returns:
#	None
# ==============================================================================
relu:
    # Prologue  

    addi sp, sp, -8
    sw t0, 0(sp)
    sw t1, 4(sp)
    add t0, a1, x0

loop_start:
    beq t0, x0, loop_end
    addi t0, t0, -1
    lw t1, 0(a0)
    addi a0, a0, 4
    bge t1, x0, loop_start

loop_continue:
    sw x0, -4(a0)
    j loop_start


loop_end:

    lw t0, 0(sp)
    lw t1, 4(sp)
    addi sp, sp, 8
    # Epilogue
    ret
