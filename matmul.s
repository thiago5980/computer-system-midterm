.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:
# 	a0 is the pointer to the start of m0
#	a1 is the # of rows (height) of m0
#	a2 is the # of columns (width) of m0
#	a3 is the pointer to the start of m1
# 	a4 is the # of rows (height) of m1
#	a5 is the # of columns (width) of m1
#	a6 is the pointer to the the start of d
# Returns:
#	None, sets d = matmul(m0, m1)
# =======================================================
matmul:
    addi sp sp -28
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    sw s3 12(sp)
    sw s4 16(sp)
    sw s5 20(sp)
    sw ra 24(sp)
   # Error if mismatched dimensions
    bne a2 a4 mismatched_dimensions

   # Prologue
    add t1 x0 x0
    add t3 x0 x0
    addi s1 x0 1
    slli s1 s1 2
    mv s5 a3

outer_loop_start:
    beq t1 a2 outer_loop_end
    
inner_loop_start:
    beq t3 a4 inner_loop_end
    
    addi sp sp -20
    sw a0 0(sp)
    sw a1 4(sp)
    sw a2 8(sp)
    sw a3 12(sp)
    sw a4 16(sp)
   # for dot.s
    add a0 a0 x0
    mv s2 a2
    mv s3 a3
    mv s4 a5
    
    mv a1 s3
    mv a2 s2
    li a3 1
    add a4 s4 x0

    jal ra dot
    mv s0 a0
   
    lw a0 0(sp)
    lw a1 4(sp)
    lw a2 8(sp)
    lw a3 12(sp)
    lw a4 16(sp)
    addi sp sp 20

    sw s0 0(a6)
    addi a6 a6 4
    
    addi t3 t3 1
    add a3 a3 s1
    j inner_loop_start

inner_loop_end:
    add t3 x0 x0
    mv a3 s5
    addi t1 t1 1
    mul t2 s1 a2
    add a0 a0 t2
    j outer_loop_start

outer_loop_end:  
   # Epilogue
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    lw s5 20(sp)
    lw ra 24(sp)
    addi sp sp 28
    ret


mismatched_dimensions:
    li a1 2
    jal exit2
