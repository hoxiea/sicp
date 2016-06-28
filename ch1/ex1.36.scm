; Exercise 1.36
; Modify fixed-point so that it prints the sequence of approximations it generates,
; using the newline and display primitives. Then find a solution to x^x = 1000
; by finding the fixed point of x -> log(1000)/log(x). Compare the number of steps
; taken with and without average damping.

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess guess-number)
    (let ((next (f guess)))
      (display guess-number)
      (display ": ")
      (display guess)
      (newline)
      (if (close-enough? guess next)
        next
        (try next (inc guess-number)))))
  (try first-guess 1))

; No average damping
(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)  ; ans in 34 steps

; Yes average damping
(define (average x y)
  (/ (+ x y) 2))
(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 2.0)   ; ans in 9 steps!
