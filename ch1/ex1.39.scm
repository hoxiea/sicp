; Exercise 1.37
; Continuous fraction estimation of the tangent function

(define (cont-frac n d num-terms)
  (define (cf-helper current-index)
    (if (> current-index num-terms)
        0   ; additive identity
        (/
         (n current-index)
         (+ (d current-index) (cf-helper (inc current-index))))
      ))
  (cf-helper 1))


; The cf expression given for tangent has:
; numer(i) = x if i == 1 else -x^2
; denom(i) = 2i - 1

(define (tan-cf x num-terms)
  (define (square x) (* x x))
  (define (numer i) (if (= i 1) x (- (square x))))
  (define (denom i) (- (* 2 i) 1))
  (cont-frac numer denom num-terms))

(tan-cf (/ pi 4) 10)       ; 1.0, as expected
(tan-cf (- (/ pi 4)) 10)   ; -1.0, as expected
(tan-cf 0 10)              ; 0, as expected
(tan-cf (* 2 pi) 10)       ; -0.00085927
(tan-cf (* 2 pi) 100)      ; -2.8271597168564594e-16

