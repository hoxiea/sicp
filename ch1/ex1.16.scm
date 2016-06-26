; Design a procedure that evolves an iterative exponentiation process that uses
; successive squaring and uses a logarithmic number of steps.

(define (odd n) (= 1 (remainder n 2)))

(define (square x) (* x x))

; Compute b^n in log(n) steps
(define (exp-iter b n)
  (define (exp-iter-helper b n a)
    (cond ((= n 0) a)
          ((odd n) (exp-iter-helper b (dec n) (* a b)))
          (else (exp-iter-helper (square b) (/ n 2) a))))
  (exp-iter-helper b n 1))



; Example:
; Invariant: (b^n * a) == (b-orig)^n always
; (exp-iter-helper b 13 1)
; (exp-iter-helper b 12 b)
; (exp-iter-helper b^2 6 b)      ; halve power, double argument
; (exp-iter-helper b^4 3 b)      ; halve power, double argument
; (exp-iter-helper b^4 2 b^5)
; (exp-iter-helper b^8 1 b^5)
; (exp-iter-helper b^8 0 b^13)
; => b^13
