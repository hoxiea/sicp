; Use the formula on page 26 to implement a cube-root procedure.

; This implementation uses new-good-enough? from Exercise 1.7; it stops when
; the change from one guess to the next is a small fraction of the guess.

(define (square x)
  (* x x))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3)) 

(define (good-enough? old-guess new-guess x)
  (< (/ (abs (- old-guess new-guess)) new-guess ) 0.001))

(define (cube-root-iter old-guess new-guess x)
  (if (good-enough? old-guess new-guess x)
    new-guess
    (cube-root-iter new-guess (improve new-guess x) x)))

(define (cube-root x)
  (cube-root-iter 1.0 (improve 1.0 x) x))

; Comparing this code with the solution to Exercise 1.7 and noting the
; similarities, it does seem like we should be able to abstract some of this
; out, which we'll apparently do in section 1.3.4.
