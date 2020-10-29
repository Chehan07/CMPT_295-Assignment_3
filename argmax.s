.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 is the pointer to the start of the vector
#	a1 is the # of elements in the vector
# Returns:
#	a0 is the first index of the largest element
# =================================================================
argmax:

    # Prologue

    lw s4, 0(a0)  
    addi s1, x0, 4                                       
    add s5, x0, x0  
    add s0, x0, x0              

loop_start:

    beq s0, a1, loop_end        
    mul s2, s1, s0              
    add s2, s2, a0              
    lw s3, 0(s2)                
    ble s3, s4, loop_continue   
    mv s4, s3                   
    mv s5, s0                  


loop_continue:

    addi s0, s0, 1
    j loop_start

loop_end:
    
    mv a0, s5

    # Epilogue


    ret
