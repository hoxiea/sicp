; Exercise 1.31
; Now let's capture the idea of `product` like we did with `sum`
(define (product term a next b)
  (if (> a b)
    1   ; multiplicative identity
    (* (term a) (product term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (* result (term a)))))
  (iter a 1))

(define (factorial n)
  (product-iter (lambda (n) n) 1 inc n))


; And let's use an infinite product to approximate pi - thanks, John Wallis!
(define (pi-approx num-terms)
  (define (term k)
    (if (even? k)
        (/ (+ k 2) (+ k 1))
        (/ (+ k 1) (+ k 2))))
  (* 4 (product term 1.0 inc num-terms)))

(pi-approx 10000)   ; 3.141749
