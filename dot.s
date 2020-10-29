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
    addi sp, sp, -68
    sw   ra, 0(sp)
    sw   s2, 4(sp)
    sw   s3, 8(sp)
    sw   s4, 12(sp)
    sw   s5, 16(sp)
    sw   s6, 20(sp)
    sw   s7, 24(sp)
    sw   s8, 28(sp)
    sw   s9, 32(sp)
    sw   s10, 36(sp)
    sw   t0, 40(sp)
    sw   t1, 44(sp)
    sw   t2, 48(sp)
    sw   t3, 52(sp)
    sw   t4, 56(sp)
    sw   t5, 60(sp)
    sw   t6, 64(sp)
    
    mv t0, a0 
    mv t1, a1 
    mv t2, a2 
    mv t3, a3 
    mv t4, a4 
    li t5, 0 
    li t6, 0 
    li s2, 0 
    li s10,0 

loop_start:
	slli s6,t5, 2 
	add s8, t0, s6 
	slli s7,t6, 2 
	add s9, t1, s7 
	beq s10, t2, loop_end 
	lw s3, 0(s8) 
	lw s4, 0(s9)
	mul s5, s3, s4 
	add s2,s2,s5 
	li s3, 2
	mul s4, t3, s3
	mul s5, t4, s3
	sll s6, t5, s4 
	sll s7, t6, s5 
	add s8, t0, s6 
	add s9, t1, s7 
	add t5, t5, t3
	add t6, t6, t4
	addi s10,s10,1 

	j loop_start

loop_end:
	mv a0, s2

    lw   ra, 0(sp)
    lw   s2, 4(sp)
    lw   s3, 8(sp)
    lw   s4, 12(sp)
    lw   s5, 16(sp)
    lw   s6, 20(sp)
    lw   s7, 24(sp)
    lw   s8, 28(sp)
    lw   s9, 32(sp)
    lw   s10, 36(sp)
    lw   t0, 40(sp)
    lw   t1, 44(sp)
    lw   t2, 48(sp)
    lw   t3, 52(sp)
    lw   t4, 56(sp)
    lw   t5, 60(sp)
    lw   t6, 64(sp)
    addi sp, sp, 68
	
	jr ra

    # Epilogue

    
    ret
