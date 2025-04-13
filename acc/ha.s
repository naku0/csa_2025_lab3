.data
buff:           .byte '________________________________'
letter:         .word 0x00          ; Variable to store the current letter
i:              .word 0
diff:           .word 0x20          ; Difference between uppercase and lowercase
const_1:        .word 0x01          ; Constant 1
small_a:        .word 0x61          ; ASCII value for 'a'
small_z:        .word 0x7A          ; ASCII value for 'z'
new_line:       .word 0x0A          ; ASCII value for '\n'
input_addr:     .word 0x80          ; Address of input data
output_addr:    .word 0x84          ; Address for output data
mask:           .word 0xFF
error_msg:      .word 0xCCCC_CCCC

.text
.org 0x85

_start:
    load_imm    buff
    store       i
    
read_loop:
    load_ind    input_addr
    beqz        read_end
    
    and         mask
    sub         new_line
    beqz        read_end
    add         new_line
    
    store       letter
    sub         small_a
    ble         write_char
    load        letter
    sub         small_z
    bgt         write_char
    load        letter
    
    sub         diff
    store       letter
    
write_char:
    load        letter
    store_ind   i
    load        i
    add         const_1
    store       i
    
    jmp         read_loop
    
read_end:
    load_imm    0x5f5f5f00
    store_ind   i
    
    load_imm    buff
    store       i
    
print_loop:
    load_ind    i
    and         mask
    beqz        end
    store_ind   output_addr
    load        i
    add         const_1
    store       i
    jmp         print_loop
    
end:
    halt

error:
    load        error_msg
    store_ind   output_addr
    halt