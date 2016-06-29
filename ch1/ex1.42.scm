; Exercise 1.42
; Let f and g be two one-argument functions. The composition f after g is
; defined to be the function x -> f(g(x)). Define a procedure `compose` that
; implements composition.
(define (compose f g)
  (lambda (x) (f (g x))))

(define (square x) (* x x))
((compose square inc) 6)      ; 49

; Using compose, we can also redefine `double` from Exercise 1.41:
(define (double f)
  (compose f f))
(((double (double double)) inc) 5)    ; 21, as before
