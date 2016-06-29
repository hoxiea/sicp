; Exercise 1.38
; Euler gives us a continued fraction expansion for e - 2:
; - num(i) = 1
; - denom(i) = 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ...
; Use cont-frac to approximate e

; From Exercise 1.37
(define (cont-frac n d num-terms)
  (define (cf-helper current-index)
    (if (> current-index num-terms)
        0   ; additive identity
        (/
         (n current-index)
         (+ (d current-index) (cf-helper (inc current-index))))
      ))
  (cf-helper 1))

; The trick for this problem is to define a function that returns the appropriate
; denominator value, as a function of the index. One such rule is as follows:
; if remainder(i, 3) == 2:
;     which_non_one_value = floor(i/3) + 1  # 1 for first, 2 for second, etc.
;     return which_non_one_value * 2
; else:
;     return 1
(define (numer i) 1.0)
(define (denom i)
  (if (= 2 (remainder i 3))
    (let ([which-non-one-value (inc (floor (/ i 3)))]) 
      (* 2 which-non-one-value))
    1))
(+ 2 (cont-frac numer denom 20))   ; 2.71828(1828459045)
