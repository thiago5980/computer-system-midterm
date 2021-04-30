.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    addi t2, x0, 1
    beq a1, x0, zro
    add t3, t3, t2
    blt a0, t3, exit
    mul a1, a1, t3
    j factorial
zro:
    addi a1, x0, 1
    j factorial
exit:
    add a0, a1, x0
    jr ra
