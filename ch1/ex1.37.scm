; Exercise 1.37
; Continuous fractions are cool

(define (cont-frac n d num-terms)
  (define (cf-helper current-index)
    (if (> current-index num-terms)
        0   ; additive identity
        (/
         (n current-index)
         (+ (d current-index) (cf-helper (inc current-index))))
      ))
  (cf-helper 1))


; Use cont-frac to estimate 1/phi == 0.6180(344478216819)
; How many terms needed for four digits of accuracy?
(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 10)   ; 0.6179775
(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 100)   ; 0.61803
(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 11)   ; 0.6180(55555555)


; And an iterative version:
; Note that we build up from the last term, since that's what we can
; first get our hands on, back to the first term
(define (cont-frac-iter n d num-terms)
  (define (cfi-helper current-index total)
    (if (< current-index 1)
      total
      (cfi-helper (dec current-index) 
                  (/ (n current-index) (+ total (d current-index))))))
  (cfi-helper num-terms 0))
(cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 11)   ; 0.6180(55555555)
