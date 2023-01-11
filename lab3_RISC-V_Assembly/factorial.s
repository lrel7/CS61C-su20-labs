.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0) #a0 gets n
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
    # YOUR CODE HERE
    li s0, 1 #result
    li s1, 1 #used to compare with a0
loop:
    ble a0, s1, loop_end #if a0<1, exit
    mul s0, s0, a0 #s0*=a0
    addi a0, a0, -1 #a0--
    jal x0, loop
loop_end:
    mv a0, s0
    jr ra
