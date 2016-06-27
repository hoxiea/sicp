; Exercise 1.19
; This problem looks scary, but it's actually not bad at all.

; Transformation T: (b, a) -> (a, a + b)
; generates the Fibonacci numbers if you start with b=0 and a=1
; So T^n gives you Fib(n+1) and Fib(n).

; We've worked with exponentiation previously, and seen that it's often
; possible to do it in a logarithmic number of steps, using smart squaring.

; Unfortunately, squaring T doesn't immediately yield something we can work with:
; T^2: (b, a) -> (a + b, 2a + b)

; To get around this issue and quickly compute T^n, we note that T is a special
; case (with p=0 and q=1) of:
; Transformation T_pq: (b, a) -> (bp + aq, bq + aq + ap)
; With those extra coefficients, we should be able to capture T^2.

; Applying T_pq twice and doing a bunch of trivial algebra, we have:
; T_pq^2: (b, a) -> (b(p^2 + q^2) + a(2pq + q^2), 
;                    b(2pq + q^2) + a(2pq + q^2 + a(p^2 + q^2)))
;
; So letting p' = p^2 + q^2 and q' = 2pq + q^2, we see that T_pq^2 stays within 
; this family of transformations.

; Plugging these expressions into the provided code allows us to compute
; Fibonacci numbers using a logarithmic number of steps, which is quite cool.
