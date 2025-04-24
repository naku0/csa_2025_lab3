.data
input_addr:     .word 0x80
output_addr:    .word 0x84

.text
.org 0x85

_start:
    @p input_addr a! @ @+

    over                               
    make_desc                           // makin' input descending

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
    gcd                                // a:b -> a:b:a:b -> a-b:a:b -> if a-b >= 0 then straight to gcd else revert and gcd
    ;

ddup:
    over dup !b over dup @b over       // a:b -> a:b:a:b 
    ;

sub:
    over inv lit 1 + +                 // a:b -> a - b
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
    over gcd                           // Okay, now when i wrote that comment i understood that i could make it simpler, but hehe
    ;                                  //   a:b -> a:b:a:b -> a-b:a:b -> a:a-b:b -> a:a-b:a:a-b:b -> a-a-b:a:a-b:b -> if a-a-b == 0 then end else -> a:a-b:b -> a:a-b:a:a-b:b 
                                       //        -> a-a-b:a:a-b:b -> if a-a-b >= 0 then looping a-b:b else looping b:a-b 

zero_end:
    over
    @p output_addr a! ! 
    halt

end:
    @p output_addr a! ! 
    halt