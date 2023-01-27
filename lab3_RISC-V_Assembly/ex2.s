.data
#int source[]={3,1,4,1,5,9,0}
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
#int dest[10]
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
main:
    addi t0, x0, 0 #int k=0
    addi s0, x0, 0 #int sum=0
    la s1, source #s1 gets the beginning of source
    la s2, dest #s2 gets the beginning of dest
loop:
    slli s3, t0, 2 #4*k
    add t1, s1, s3 #t1 gets 4*k(s1), i.e. the address of source[k]
    lw t2, 0(t1) #t2 gets source[k]
    beq t2, x0, exit #if source[k]==0, exit
    add a0, x0, t2 #a0 gets source[k]
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t2, 4(sp)
    jal square
    lw t0, 0(sp)
    lw t2, 4(sp)
    addi sp, sp, 8
    add t2, x0, a0 #t2 gets fun(source[k])
    add t3, s2, s3 #t3 gets 4*k(s2), i.e. the address of dest[k]
    sw t2, 0(t3) #store fun(source[k]) to dest[k]
    add s0, s0, t2 #sum+=dest[k]
    addi t0, t0, 1 #k++
    jal x0, loop
square:
    add t0, a0, x0
    add t1, a0, x0
    addi t0, t0, 1 #x+1
    addi t2, x0, -1 #-1
    mul t1, t1, t2 #-1*x
    mul a0, t0, t1 #a0 gets x*(x+1)
    jr ra
exit:
    add a0, x0, s0
    add a1, x0, x0
    ecall # Terminate ecall