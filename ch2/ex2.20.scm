; Exercise 2.20
; (define (f x y . z) <body>) defines a function of two or more arguments.
; Any extra arguments are captured as a list z.
; Use this notation to write a procedure `same-parity` that takes one or more
; integers and returns a list of all the arguments that have the same
; even-odd parity as the first argument.
(define (has-same-parity a b) (= (remainder a 2) (remainder b 2)))

(define (same-parity first . rest)
  (define (same-parity-helper winners remaining)
    (cond ((null? remaining) winners)
          ((has-same-parity (car remaining) first) 
           (same-parity-helper (cons (car remaining) winners) (cdr remaining)))
          (else (same-parity-helper winners (cdr remaining)))))
  (cons first (same-parity-helper '() (reverse rest))))


(same-parity 1 2 3 4 5 6 7)

(same-parity 2 3 4 5 6 7)
