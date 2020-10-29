.import ../read_matrix.s
.import ../write_matrix.s
.import ../matmul.s
.import ../dot.s
.import ../relu.s
.import ../argmax.s
.import ../utils.s

 

.data
output_step1: .asciiz "\n**Step 1: hidden_layer = matmul(m0, input)**\n"
output_step2: .asciiz "\n**Step 2: NONLINEAR LAYER: ReLU(hidden_layer)** \n"
output_step3: .asciiz "\n**Step 3: Linear layer = matmul(m1, relu)** \n"
output_step4: .asciiz "\n**Step 4: Argmax ** \n"
.globl main

.text
main:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0: int argc
    #   a1: char** argv
    #
    # Usage:
    #   main.s <INPUT_PATH> <M0_PATH> <M1_PATH> <OUTPUT_PATH>

    # Exit if incorrect number of command line args
    addi s1,x0,4
    bne a0,s1,mismatched_dimensions

    # =====================================
    # LOAD MATRICES
    # =====================================

    mv s1,a0 
    mv s2, a1 

    # Load input matrix
    lw a0,4(s2)
    li a1,0
    li a2,0
    jal read_matrix
 
    mv s3,a0 
    mv s4,a1 
    mv s6,a2  
    lw s5,0(s4) 
    lw s7,0(s6) 
 
    # Load pretrained m0
    lw a0,8(s2)
    jal read_matrix

    mv s8,a0 
    mv s9, a1 
    mv s11,a2 
    lw s10,0(s9) 
    lw t0,0(s11) 

    # Load pretrained m1
    lw a0,12(s2)
    jal read_matrix

    mv s1, a0 
    mv t2, a1 
    mv t4, a2 
    lw t3,0(t2) 
    lw t5,0(t4) 

    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input

    mul t6, s10,s7
    mul t6,t6,t1
    addi t1, x0,4
    mv a0, t6
    jal malloc

    mv t6,a0 
    mv a0,s8
    mv a1,s10
    mv a2,t0
    mv a3,s3
    mv a4,s5
    mv a5,s7
    mv a6,a0
    
    jal matmul

    mv t6,a6  

    
    # Output of stage 1
    la a1, output_step1
    jal print_str

 

    ## FILL OUT

    mv a0,t6# Base ptr
    mv a1,s10 #rows
    mv a2,s7 #cols
    jal print_int_array


    # 2. NONLINEAR LAYER: ReLU(m0 * input)

    mv a0,t6
    mul t1,s10,s7
    mv a1, t1
    jal relu
    mv t6,a0 

 

    # Output of stage 1

    la a1, output_step2
    jal print_str

    ## FILL OUT

    mv a0, t6# Base ptr
    mv a1, s10#rows
    mv a2, s7#cols
    jal print_int_array

    mv a0,s3
    jal free
    mv a0,s8
    jal free

    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)

    addi s3,x0,4
    mul s8,t3,s7
    mul s3,s3,s8
    mv a0,s3
    jal malloc
    mv s3,a0 


    mv a0, s1
    mv a1,t3
    mv a2,t5
    mv a3,t6
    mv a4,s10
    mv a5,s7
    mv a6,s3
    jal matmul
    
    mv s3,a6

    # Output of stage 3

    la a1, output_step3
    jal print_str

 

    ## FILL OUT

    mv a0,s3 # Base ptr
    mv a1,t3 #rows
    mv a2,s7 #cols
    jal print_int_array

    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    lw a0 16(s0) # Load pointer to output filename

    lw a1,16(s2)
    li a2,1
    jal fopen
    mv a1,s8
    mv a2,t2
    mv s8,a0 
    li a3,1
    li a4,4
    jal fwrite

    mv a1,s8
    mv a2,t6
    li a3,1
    li a4,4
    jal fwrite
 
    mv a1,s8
    mv a2,s3
    add a3,x0,t3
    mul a3,a3,s7
    li a4,4
    jal fwrite

    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax

    mv a0, s3
    add a1,x0,t3
    mul a1,a1,s7
    jal argmax
    mv s3, a0

 # Print classification

 # Output of stage 3

    la a1, output_step4
    jal print_str

    ## FILL OUT

    mv a1, s3
    jal print_int

    # Print newline afterwards for clarity

    li a1 '\n'
    jal print_char


    jal exit

mismatched_dimensions:

    li a1 3
    jal exit2

