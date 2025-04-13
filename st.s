.data

input_addr:     .word 0x80          
output_addr:    .word 0x84
array_size:     .word 0x02

.text

_start:
    set_size
    @
    -if write
    if end

set_size:
    @p array_size >r
    next loop


write:
    @p input_addr b!
    @b
    @p output_addr b!
    !b
    
loop:
    write

    loop ;

end:
    halt
