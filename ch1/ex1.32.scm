; Exercise 1.32
; Show that `sum` and `product` are both special cases of a still more general
; notion called `accumulate` that combines a collection of terms, using some
; general accumulation function

(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

(sum (lambda (x) x) 1 inc 10)      ;; 55, as desired
(product (lambda (x) x) 1 inc 6)   ;; 720, as desired

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (combiner result (term a)))))
  (iter a null-value))

