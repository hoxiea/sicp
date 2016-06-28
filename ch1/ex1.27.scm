; Exercise 1.27
; Demonstrate that the Carmichael numbers listed in Footnote 47 really do
; fool the Fermat test.
; Numbers: 561, 1105, 1729, 2465, 2821, 6601


(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
           (square (expmod base (/ exp 2) m))
           m))
        (else
          (remainder
            (* base (expmod base (dec exp) m))
            m))))

; Fermat's test:
; If it fails, then n DEFINITELY isn't prime
; If it passes for a bunch of a values, then it probably is prime
(define (fermat-condition a n)
   (= (expmod a n n) a)))

; Use the fermat-condition a bunch of times to check for primality
(define (fermat-prime? n times)
  (cond ((= times 0) true)
        ((fermat-cond 
           (+ 1 (random (- n 1)))   ; random integer between 1 and n-1
           n) (fast-prime? n (dec times)))
        (else false)))

; Check to see if n satisfies the fermat-condition for all a in [1 .. n-1]
(define (fools-fermat n)
  (define (fool-fermat-helper current)
    (cond ((= current n) #t)
          ((fermat-condition current n) (fool-fermat-helper (inc current)))
          (else #f)))
  (fool-fermat-helper 1))

(map fools-fermat '(561 1105 1729 2465 2821 6601))   ; all true
