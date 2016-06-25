; Define a produce that takes three numbers as arguments and returns the sum of
; the squares of the two larger numbers.
(define (version1 a b c)
  (define (square x) (* x x))
  (cond ((and (> a c) (> b c)) (+ (square a) (square b)))
        ((and (> a b) (> c b)) (+ (square a) (square c)))
        (else (+ (square b) (square c)))))

(define (version2 a b c)
  (define (square x) (* x x))
  (-
   (+ (square a) (square b) (square c))
   (square (min a b c))
   )
  )
