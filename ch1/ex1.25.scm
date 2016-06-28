; Here's the expmod procedure we defined in Section 1.24
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

; Here's the proposed new exp-mod:
(define (expmod-lazy base exp m)
  (remainder (fast-expt base exp) m))

; fast-expt was a good algorithm, but the problem is that exponential functions
; grow extremely quickly. This proposed new solution is essentially a
; brute-force solution: actually take the exponential (using a good algorithm)
; and then calculate the remainder.

; In contrast, `expmod` uses math to reduce the size of the arguments, so we
; won't have to deal with large numbers, overflow issues, etc., which could
; absolutely be relevant when working with even moderate-sized primes.
