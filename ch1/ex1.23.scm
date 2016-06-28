; Exercise 1.23
; The smallest-divisor procedure from last time does a bunch of needless
; testing: after checking 2, you don't need to check larger even numbers.
; So instead, we'll check 2, 3, 5, 7, 9, ...
(define (next n)
  (if (= n 2) 3 (+ n 2)))

; Changed to use `next`
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

; Same as before
(define (divides? a b)
  (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))
(define (smallest-divisor n)
  (find-divisor n 2))

(define (timed-prime-test n)
  ; Print n; check to see if n is prime
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
    (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))


(define (odd n) (= (remainder n 2) 1))
(define (square x) (* x x))

(define (next-odd n)
  (if (odd n)
    n
    (inc n)))

(define (search-for-primes a b)
  (if (> a b)
      (begin
       (newline)
       (display 'DONE)
       )
      (begin
       (let ([val-to-test (next-odd a)])
         (timed-prime-test val-to-test)
         (search-for-primes (+ 2 val-to-test) b)
         ))
    ))

(search-for-primes 1000 1020)
; Times: 1 1 1   (old: 1 1 2)      : ratio = 0.75

(search-for-primes 10000 10040)
; Times: 2 3 2   (old: 4 4 4)      : ratio = 0.58333

(search-for-primes 100000 100050)
; Times: 7 7 7   (old: 12 11 11)   : ratio = .6176

(search-for-primes 1000000 1000040)
; Times: 21 21 22   (old: 35 34 35)   : ratio = 0.61538

; So our new find-divisor doesn't quite get us a 2x speed-up (which would be a 
; ratio of 0.5 above). We're definitely trying almost exactly half as many divisors,
; so clearly those tests must be taking a little bit longer for some reason. 
; 
; That reason is likely the fact that we switched from using a very simple
; primitive operation `+` to a user-defined function `next` that has to evaluate
; an if statement every time it's called.
