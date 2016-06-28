; We've seen many times at this point that the default Scheme interpreter
; evaluates expressions as it goes. So when Louis calls
; (* (expmod base (/ exp 2) m) (expmod base (/ exp 2) m)),
; We generate two recursive calls, not one like we do when we use 
; (square (expmod base (/ exp 2) m)).
;
; But the whole reason that halving gives us a log(n) algorithm is because
; at each step, we're able to chop the input size in half. With the two
; duplicated calls, that isn't happening; what's instead happening is a ton
; of duplicated work at every step of the way.
