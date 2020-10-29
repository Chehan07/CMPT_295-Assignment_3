.globl relu
.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 is the pointer to the array
#	a1 is the # of elements in the array
# Returns:
#	None
# ==============================================================================


relu:
    # Prologue
    addi sp, sp, -28
    sw   ra, 0(sp)
    sw   t0, 4(sp)
    sw   s1, 8(sp)
    sw   s2, 12(sp)
    sw   s3, 16(sp)
    sw   s4, 20(sp)
    sw   s5, 24(sp)
    
   
    mv s1,a0
    mv s2,a1
    addi t0,x0,0
    

loop_start:
    beq t0,s2,loop_end
	slli s3,t0, 2
	add s4, s1,s3
	lw s5,0(s4)
	blt s5,x0,loop_continue	
	addi t0,t0,1
	j loop_start

loop_continue:
	sw x0, 0(s4)
	addi t0,t0,1
	jal loop_start

loop_end:
	
    lw   ra, 0(sp)
    lw   t0, 4(sp)
    lw   s1, 8(sp)
    lw   s2, 12(sp)
    lw   s3, 16(sp)
    lw   s4, 20(sp)
    lw   s5, 24(sp)
    addi sp, sp, -28
	jr ra

	# Epilogue

	ret
