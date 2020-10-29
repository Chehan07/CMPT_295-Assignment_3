.import ../read_matrix.s
.import ../utils.s

.data
file_path: .asciiz "./test_files/test_input.bin"

.text
main:
    # Read matrix into memory
    la a0,file_path
    la a1,file_path
    la a2,file_path

    jal read_matrix
    
    mv s2,a0
    mv s3,a1
    lw s4,0(s3) #rows in s4
    mv s5,a2
    lw s6,0(s5) #columns in s6

    # Print out elements of matrix
    mv a0,s2
    mv a1,s4
    mv a2,s6
    jal print_int_array

    mv a0,s2
    jal free
    mv a0,s6
    jal free
    mv a0,s4
    jal free

  
    # Terminate the program
    addi a0, x0, 10
    ecall