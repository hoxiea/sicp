; Exercise 1.30
; The `sum` procedure generates a linear recursion:
(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a) (sum term (next a) next b))))

; Let's define an iterative version by keeping a running total of the sum
; and returning that running total when we're at the end
(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (+ result (term a)))))
  (iter a 0))

(sum-iter (lambda (x) x) 1 inc 10)    ; 55, as desired
