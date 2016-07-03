; Exercise 2.1
; Define a better version of `make-rat` that handles both positive and
; negative arguments: positive number => num and denom positive; negative
; number => neg num, positive denom

; Note that make-rat already handles the case of two negative components
; correctly: (gcd -1 -3) is -1, and dividing through by -1 makes everything
; positive. So we just need to handle the mixed-sign case.

; The function `sgn` returns +1 for positive input, 0 for zero, and -1 for negative input.
; So (sgn n*d) is exactly the sign that we should have in the numerator.

(define (make-rat n d) 
  (let ([g (gcd n d)]
        [num-sign (sgn (* n d))])
    (cons (* num-sign (/ n g)) 
          (/ d g))))

(= (numer (make-rat 1 -3)) -1) 
(= (numer (make-rat -1 -3)) 1) 
