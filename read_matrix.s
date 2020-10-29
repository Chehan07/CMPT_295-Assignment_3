.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 is the pointer to string representing the filename
#   a1 is a pointer to an integer, we will set it to the number of rows
#   a2 is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 is the pointer to the matrix in memory
# ==============================================================================
read_matrix:

    # Prologue
    addi sp,sp,-24
    sw ra,0(sp)
    sw s2,4(sp)
    sw s3,8(sp)
    sw s4,12(sp)
    sw s5,16(sp)
    sw s6,20(sp)

    mv a1,a0
    li a2,0
    jal fopen
    mv s2,a0 
    mv a1,a0
    jal ferror
    
    bne a0,zero,eof_or_error
    li a0,4
    jal malloc
 
    mv s3,a0
    mv a1,s2
    mv a2,s3 
    li a3,4
    jal fread  
    
    li a0,4
    jal malloc
   
    mv s4,a0 
    mv a1,s2
    mv a2,s4
    li a3,4
    jal fread 

    lw s5,0(s3) 
    lw s6, 0(s4) 
    mul s5,s5,s6 
    addi s6,x0,4  
    mul s5,s6,s5  

    mv a0,s5
    jal malloc
    
    mv s6,a0 
    mv a1,s2
    mv a2,s6
    mv a3,s5
    jal fread 

    mv a0,s6
    mv a1,s3
    mv a2, s4


    # Epilogue
    lw ra,0(sp)
    lw s2,4(sp)
    lw s3,8(sp)
    lw s4,12(sp)
    lw s5,16(sp)
    lw s6,20(sp)
    addi sp,sp,24
    
    ret

eof_or_error:
    li a1 1
    jal exit2