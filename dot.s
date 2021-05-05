.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
dot:
	
    # Prologue
    addi sp sp -32
    sw t0 0(sp)
    sw t1 4(sp)
    sw t2 8(sp)
    sw t3 12(sp)
    sw t4 16(sp)
    sw t5 20(sp)
    sw t6 24(sp)
    sw ra 28(sp)

    slli t0 a3 2
    slli t1 a4 2
    add t2 x0 x0
    add t6 x0 x0

loop_start:
    beq t2 a2 loop_end
    addi t2 t2 1
    lw t4 0(a0)
    lw t5 0(a1)
    mul t3 t4 t5
    add a0 a0 t0
    add a1 a1 t1
    add t6 t6 t3
    j loop_start

loop_end:
    mv a0 t6
    lw t0 0(sp)
    lw t1 4(sp)
    lw t2 8(sp)
    lw t3 12(sp)
    lw t4 16(sp)
    lw t5 20(sp)
    lw t6 24(sp)
    lw ra 28(sp)
    addi sp sp 32
    # Epilogue

    
    ret
