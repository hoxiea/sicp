; Exercise 1.17
; Suppose that we can add, double, and halve. Design a multiplication
; procedure analogous to fast-expt that uses a logarithmic number of steps.

(define (even n) (= 0 (remainder n 2)))
(define (double x) (* x 2))
(define (halve x) (/ x 2))

; Number of steps: theta(log_2(b))
(define (fast-mult a b)
  (cond ((= b 0) 0)
        ((even b) (fast-mult (double a) (halve b)))
        (else (+ a (fast-mult a (dec b))))))
