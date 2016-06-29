; Exercise 1.41
; Define a procedure double that takes a procedure of one argument as argument
; and returns a procedure that applies the original procedure twice.

(define (double f)
  (lambda (x) (f (f x))))

((double inc) 4)


(((double (double double)) inc) 5)

; This evaluates to 21, since (double double) gives a function that x4's its input,
; and doubling that gives a function that x16's its input. 16 incs to 5 => 21
