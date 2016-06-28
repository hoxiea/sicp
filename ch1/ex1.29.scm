; Exercise 1.29
; Define a procedure that takes as arguments f, a, b, and n,
; and returns the Simpson's Rule approximation of int_a^b f, with n subintervals.

; int_a^b f(x) dx is approx (h/3) [y0 + 4y1 + 2y2 + ... +2y_n-2 + 4y_n-1 + y_n]
;              which equals (h/3) * sum_{k=0)^n coeff(k) * f(a + kh)
; It's this sum that's captured below

(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))


(define (simpson f a b n)
  (define (make-even n)
    (if (even? n) n (inc n)))   ; +1: err on the side of more subintervals
  (define (coeff k n)
    (cond ((or (= k 0) (= k n)) 1)
          ((even? k) 2)
          (else 4)))
  (let ([h (/ (- b a) (make-even n))])
    (define (term k)
      (* (coeff k n) (f (+ a (* k h)))))
    (* (/ h 3)
       (sum term 0 inc n))
    ))

(define (cube x) (* x x x))
(simpson cube 0 1 100)    ; 1/4, as desired
