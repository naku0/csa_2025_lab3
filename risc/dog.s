.data

input_addr:      .word 0x80
output_addr:     .word 0x84

.text 
.org 0x88

_start:

    lui     t0, %hi(input_addr)
    addi    t0, t0, %lo(input_addr)
    lw      t0, 0(t0) 
    lw      t1, 0(t0) 

    addi    t2, zero, 0
    addi    a0, zero, 1
    addi    a1, zero, 1
    addi    a3, zero, 32

    jal     ra, main
    j       exit

main:
    addi    sp, sp, -4
    sw      ra, 0(sp)
    jal     ra, count_zeros
    j       retur

count_zeros:
    addi    sp, sp, -4
    sw      ra, 0(sp)

    beqz    a3, retur

    and     t3, t1, a1
    bnez    t3, not_zero
    addi    t2, t2, 1
not_zero:
    srl     t1, t1, a0
    addi    a3, a3, -1
    j       count_zeros

retur:
    lw      ra, 0(sp)
    addi    sp, sp, 4
    jr      ra

exit:
    lui      t0, %hi(output_addr)   
    addi     t0, t0, %lo(output_addr)
    lw       t0, 0(t0)
    sw       t2, 0(t0)
    halt