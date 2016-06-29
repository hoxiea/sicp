; Exercise 1.43
; Write a procedure that takes as inputs a procedure that computes f and a
; positive integer n and returns the procedure that computes the nth repeated
; application of f.
(define (compose f g)
  (lambda (x) (f (g x)))) 

(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (dec n)))))

(define (square x) (* x x))

((repeated square 2) 5)    ; 625, since 5^4 == 625
