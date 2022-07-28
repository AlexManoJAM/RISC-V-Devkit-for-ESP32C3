    .section .text.reset
    .type _reset, @function
    .global _reset

     
 _reset:
          addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        addi    s0,sp,32
        lui     a5,%hi(_sbss)//lui+addi  for loading a 32-bit constant into a register. Used to surpass the signed problem of a single addi
        addi    a5,a5,%lo(_sbss)
        sw      a5,-20(s0)
        j       .L2
.L3:
        lw      a5,-20(s0)
        addi    a4,a5,1
        sw      a4,-20(s0)
        sb      zero,0(a5)
.L2:
        lw      a4,-20(s0)
        lui     a5,%hi(_ebss)
        addi    a5,a5,%lo(_ebss)
        bltu    a4,a5,.L3
        //call    soc_init
        li      a5,1611399168
        addi    a5,a5,8
        lw      a4,0(a5)
        li      a5,1611399168
        addi    a5,a5,8
        andi    a4,a4,-4
        sw      a4,0(a5)
        li      a5,1611399168
        addi    a5,a5,8
        lw      a4,0(a5)
        li      a5,1611399168
        addi    a5,a5,8
        ori     a4,a4,5
        sw      a4,0(a5)
        li      a5,1611399168
        addi    a5,a5,88
        li      a4,688128
        addi    a4,a4,1024
        sw      a4,0(a5)
        csrw   mstatus, 0x8
        li      a5,1073741824
        addi    a5,a5,1416
        li      a0,160
        jalr    a5
        lui     a5,%hi(_vector_table)
        addi    a5,a5,%lo(_vector_table)
        sw      a5,-20(s0)
        lw      a5,-20(s0)
        csrrw zero, mtvec, a5
        csrr a5, mtvec
        sw      a5,-24(s0)
        //
        //wtd disable
         li      a5,1610645504
        addi    a5,a5,168
        li      a4,1356349440
        addi    a4,a4,-1375
        sw      a4,0(a5)
        li      a5,1610645504
        addi    a5,a5,144
        sw      zero,0(a5)
        li      a5,1610645504
        addi    a5,a5,140
        sw      zero,0(a5)
        li      a5,1610645504
        addi    a5,a5,176
        li      a4,-1893912576
        addi    a4,a4,298
        sw      a4,0(a5)
        li      a5,1610645504
        addi    a5,a5,172
        lw      a3,0(a5)
        li      a5,1610645504
        addi    a5,a5,172
        li      a4,-2147483648
        or      a4,a3,a4
        sw      a4,0(a5)
        li      a5,1610645504
        addi    a5,a5,180
        sw      zero,0(a5)
        li      a5,1610739712
        addi    a5,a5,252
        lw      a4,0(a5)
        li      a5,1610739712
        addi    a5,a5,252
        andi    a4,a4,-513
        sw      a4,0(a5)
        li      a5,1610739712
        addi    a5,a5,72
        sw      zero,0(a5)
        li      a5,1610743808
        addi    a5,a5,72
        sw      zero,0(a5)
        li      a5,0
        //
        call    main
.L4:
        j       .L4
