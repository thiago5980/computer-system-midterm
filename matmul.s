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
    addi sp sp -52
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    sw s3 12(sp)
    sw s4 16(sp)
    sw s5 20(sp)
    sw ra 24(sp)
    sw s6 28(sp) 
    sw s7 32(sp)
    sw s8 36(sp)
    sw s9 40(sp)
    sw s10 44(sp)
    sw s11 48(sp)
   # Error if mismatched dimensions
    bne a2 a4 mismatched_dimensions

   # Prologue
    add s7 x0 x0
    add s9 x0 x0
    addi s1 x0 1
    slli s1 s1 2
    mv s5 a3

outer_loop_start:
    beq s7 a1 outer_loop_end
    
inner_loop_start:
    beq s9 a5 inner_loop_end
    
    addi sp sp -20
    sw a0 0(sp)
    sw a1 4(sp)
    sw a2 8(sp)
    sw a3 12(sp)
    sw a4 16(sp)
   # for dot.s
    mv s6 a0
    mv s10 a1
    mv s2 a2
    mv s3 a3
    mv s11 a4
    mv s4 a5
    
    mv a1 s3
    mv a2 s2
    li a3 1
    mv a4 s4

    jal ra dot
    mv s0 a0
   
    mv a0 s6
    mv a1 s10
    mv a2 s2
    mv a3 s3
    mv a4 s11
    mv a5 s4
    addi sp sp 20

    sw s0 0(a6)
    addi a6 a6 4
    
    addi s9 s9 1
    add a3 a3 s1
    j inner_loop_start

inner_loop_end:
    add s9 x0 x0
    mv a3 s5
    addi s7 s7 1
    mul s8 s1 a2
    add a0 a0 s8
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
    lw s6 28(sp) 
    lw s7 32(sp)
    lw s8 36(sp)
    lw s9 40(sp)
    lw s10 44(sp)
    lw s11 48(sp)
    addi sp sp 52
    ret


mismatched_dimensions:
    li a1 2
    jal exit2
