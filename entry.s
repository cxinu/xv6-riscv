.section .text
.global _entry
_entry:
    la sp, stack0
    li a0, 4096
    csrr a1, mhartid
    addi a1, a1, 1
    mul a0, a0, a1
    add sp, sp, a0
    # sp = stack0 + (mhartid+1)*4096
    call main

spin:
    j spin
