.data
input_addr:     .word 0x80          ;; Address of input data
output_addr:    .word 0x84          ;; Address for output data
letter:         .word 0x00          ;; Variable to store the current letter
diff:           .word 0x20          ;; Difference between uppercase and lowercase letters in ASCII table (0x61 is 'A' and 0x81 is 'a') 
const_1:        .word 0x01          ;; Constant 1
small_a:        .word 0x61          ;; ASCII value for 'a'
small_z:        .word 0x7A          ;; ASCII value for 'z'
null_word:      .word 0x00          ;; Null terminator for the output string

.text

_start:
    jmp         loop                ;; Jump to the main loop
    
loop:
    load_ind    input_addr          ;; acc <- mem[mem[input_addr]]
    beqz        end                 ;; if acc == 0 then end

    store       letter              ;; letter <- acc
    load        letter              ;; acc <- letter

    sub         small_a             ;; if acc - 0x61 < 0 then it is not lowercase letter => saving
    ble         store_value         

    load        letter              ;; letter <- acc

    sub         small_z             ;; if acc - 0x7A > 0 then it is not lowercase letter => saving
    bgt         store_value

    load        letter              ;; letter <- acc
    sub         diff                ;; acc - 0x20 or make lowercase uppercased
    store       letter              ;; letter <- acc
    jmp         store_value         ;; storing our uppercased letter

store_value:    
    load        letter              ;; acc <- letter 
    store_ind   output_addr         ;; mem[mem[output_addr]] <- acc
    jmp         loop                ;; going back to the cycle


end:
    load         null_word          ;; acc <- 0x00
    store_ind    output_addr        ;; mem[mem[output_addr]] <- acc
    halt                            
    