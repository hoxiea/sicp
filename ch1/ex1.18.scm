; Using the results of exercises 1.16 and 1.17, devise a procedure that generates
; an iterative process for multiplying two integers in terms of adding, doubling,
; and halving that uses a logarithmic number of steps.

(define (double x) (* x 2))
(define (halve x) (/ x 2))
(define (even x) (= 0 (remainder x 2)))

; Loop invariant: (a-orig)(b-orig) = a*b + current
; This is why we use 0 in `iter-mult` below: 0 is the additive identity
(define (iter-mult-helper a b current)
  (cond ((= a 0) current)
        ((even a) (iter-mult-helper (halve a)    ; a-orig*b-orig = (1/2)a * (2b) + current
                                    (double b) 
                                    current))
        (else (iter-mult-helper (dec a)          ; a-orig*b-orig = (a-1)*b + b + current
                                b 
                                (+ current b)))))

(define (iter-mult a b)
  (iter-mult-helper a b 0))

