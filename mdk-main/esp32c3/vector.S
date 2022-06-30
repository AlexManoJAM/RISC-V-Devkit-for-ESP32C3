    /* This is the vector table. MTVEC points here.
     *
     * Use 4-byte intructions here. 1 instruction = 1 entry of the table.
     * The CPU jumps to MTVEC (i.e. the first entry) in case of an exception,
     * and (MTVEC & 0xfffffffc) + (mcause & 0x7fffffff) * 4, in case of an interrupt.
     */
    .balign 0x100
    .global _vector_table
    .type _vector_table, @function
_vector_table:
    .option push // .option push/pop Pushes or pops the current option stack. These should be used whenever changing an option in line with assembly code in order to ensure the user’s command-line options are respected for the bulk of the file being assembled.
    .option norvc //Enables or disables the generation of compressed instructions. Instructions are opportunistically compressed by the RISC-V assembler when possible, but sometimes this behavior is not desirable, especially when handling alignments.
    j _panic_handler            /* exception handler, entry 0 */
    .rept 31
    j _interrupt_handler        /* 31 identical entries, all pointing to the interrupt handler */
    .endr
    .option pop
    .size _vector_table, .-_vector_table

    /* This should be the exception handler.
     * It doesn't do anything useful yet, but you can set a breakpoint here, to see if an exception happens.
     */
    .global _panic_handler
    .type _panic_handler, @function
_panic_handler:
    j _panic_handler
    .size  _panic_handler, .-_panic_handler

    /* This is the interrupt handler.
     * It is declared as a weak function, and can be overridden.
     */
    .global _interrupt_handler
    .weak _interrupt_handler
    .type _interrupt_handler, @function
_interrupt_handler:   
    //clear isr
    //APENAS PARA INTERRUPÇOES DO TIPO EDGE
    li      a5,1611407628   //A5<-ADDRESS OF CLEAR_ISR_REG
    lw      a4,0(a5)     //A4<- VALUE OF CLEAR_ISR_REG
    //sw      a4,0(a5)
    xori  a4,a4,2    // TOGLE AO BIT CORRESPONDENTE A INTERRUPÇAO 1 
    sw      a4,0(a5) // SAVE CLEAR_ISR_REG
   // xori  a4,a4,2
  //  sw      a4,0(a5)
    li      a5,0  // CLEAR REG A5
 
    li a5,1610629120
    addi    a5,a5,32
    lw      a4,0(a5)
    li      a5,1610629120
    addi    a5,a5,32
    andi    a4,a4,-3
    sw      a4,0(a5)
    li      a5,1610629120
    addi    a4,a5,32
    li      a5,1610629120
    addi    a5,a5,32
    lw      a4,0(a4)
    sw      a4,0(a5)
  //  li a7,1
    MRET 
    .size  _interrupt_handler, .-_interrupt_handler
