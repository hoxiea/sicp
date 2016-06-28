;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Prime-checking machinery: Fermat edition ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (dec times)))
        (else false)))


;;;;;;;;;;;;;;;;;;;;;;
;; Timing machinery ;;
;;;;;;;;;;;;;;;;;;;;;;
(define (timed-prime-test n)
  ; Print n; check to see if n is prime
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 100)                           ; use `fast-prime?`, 100 tries
    (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))


;;;;;;;;;;;;;;;;;;;;;;;;;
;; Answer the question ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
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
; Times: 90 98 88

(search-for-primes 10000 10040)
; Times: 107 105 105

(search-for-primes 100000 100050)
; Times: 121 124 126

(search-for-primes 1000000 1000040)
; Times: 145 163 147 


; From one run to the next, we're increasing by a factor of 10.  And log(10n) =
; log(10) + log(n), so we should see a constant rate of increase from one level
; to the next. In actuality, the differences in successive sums are 
; 41, 54, and 84, so it's not quite constant.

