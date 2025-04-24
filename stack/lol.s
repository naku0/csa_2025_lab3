.data
input_addr:     .word 0x80
output_addr:    .word 0x84

.text
.org 0x85

_start:
    @p input_addr a! @ @+

    over
    make_desc

    @p output_addr a!   
    halt

revert:
    over
    ;

make_desc:
    ddup
    sub
    -if gcd
    revert 
    gcd
    ;

ddup:
    over dup !b over dup @b over
    ;

sub:
    over inv lit 1 + +
    ;

gcd:
    ddup 
    sub
    over
    ddup
    sub
    if end
    drop
    ddup
    sub
    -if gcd
    over gcd
    ;

zero_end:
    over
    @p output_addr a! ! 
    halt

end:
    @p output_addr a! ! 
    halt