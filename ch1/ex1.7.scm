(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

; Claim: "good-enough? won't be effective for finding the roots of very small numbers."
; Explanation: In some sense, good-enough? is an absolute tolerance: sqrt will converge
; to a value that's within 0.001 of the true square root. But being off by 0.001 has
; different implications in different settings. 
;
; When finding sqrt(10000) == 100, being within 0.001 of 100 is equivalent to a
; relative error of 0.001%, which could be quite acceptable in many situations.
; 
; When finding sqrt(0.00001) ~= 0.003162278, being off by 0.001 is essentially
; a 31.62% relative error rate, which is likely to be unacceptable in most cases.


; Claim: "In most computers, arithmetic operations are almost always performed
; with limited precision. This makes our test inadequate for very large
; numbers."
; Explanation: If numerical precision is limited, and most of the numerical
; precision is being dedicated to the integer part of the number, then it's
; possible that we won't ever have enough precision in the decimal to be within
; 0.001 of the true value.
;
; (sqrt 10000000000000000) == (sqrt 10e16) finishes immediately with 10e8, as expected
; (sqrt 1000000000000000)  == (sqrt 10e15) runs indefinitely because it can't
; ever get close enough to converge


; An alternative strategy for implementing good-enough? is to watch how guess
; changes from one iteration to the next and stop when the change is a very
; small fraction of the guess. Design a square-root procedure that uses this
; kind of end test.
(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))

(define (new-good-enough? old-guess new-guess x)
  (< (/ (abs (- old-guess new-guess)) new-guess ) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter2 old-guess new-guess x)
  (if (new-good-enough? old-guess new-guess x)
    new-guess
    (sqrt-iter2 new-guess (improve new-guess x) x)))

(define (sqrt2 x)
  (sqrt-iter2 1.0 (improve 1.0 x) x))


; Input     Actual             sqrt                    sqrt2   
; 16        4                  4.0000006               4.0000006
; 17        4.123105626        4.123106                4.123106
; 0.00001   0.003162278        0.03                    0.003162278
; 1e17      316227766          ------                  316227766.02
