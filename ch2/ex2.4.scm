; Exercise 2.4
; Here's an alternative representation of pairs:

(define (cons-alt x y)
  (lambda (m) (m x y)))

(define (car-alt z)
  (z (lambda (p q) p)))

(define (cdr-alt z)
  (z (lambda (p q) q)))

(define x (cons-alt 2 4))
(car-alt x)  ; 2
(cdr-alt x)  ; 4
