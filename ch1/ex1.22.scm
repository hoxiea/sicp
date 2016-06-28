;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Prime-checking machinery ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (inc test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))


;;;;;;;;;;;;;;;;;;;;;;
;; Timing machinery ;;
;;;;;;;;;;;;;;;;;;;;;;
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


;; Exercise 1.22
(define (odd n) (= (remainder n 2) 1))

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
; Times: 1 1 2 

(search-for-primes 10000 10040)
; Times: 4 4 4

(search-for-primes 100000 100050)
; Times: 12 11 11

(search-for-primes 1000000 1000040)
; Times: 35 34 35

; As the instructions point out, `prime?` is theta(sqrt(n)), so increasing
; the size of the inputs by a factor of 10 should increase the runtime
; by a factor of approximately sqrt(10) == 3.16. And that's exactly what we see:
; 1 -> 4 -> 12 -> 35

