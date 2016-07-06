; Exercise 2.19
; Building a better coin-counter

(define (cc amount coin-values)
  (cond ((= amount 0) 
         1)
        ((or (< amount 0) 
             (no-more? coin-values)) 
         0)
        (else
         (+ (cc 
             amount
             (except-first-denomination 
              coin-values))
            (cc 
             (- amount
                (first-denomination 
                 coin-values))
             coin-values)))))

(define (first-denomination coins) (car coins))
(define (except-first-denomination coins) (cdr coins))
(define (no-more? coins) (null? coins))

(define us-coins 
  (list 50 25 10 5 1))

(cc 100 (reverse us-coins))   ; 292

; Order of the coins doesn't matter, since the recursive argument still holds:
; the number of ways to make change for `amount` using `coin-values` is the
; number of ways to do it without using the first coin, plus the number of ways
; to make change for the (difference of amount and the first coin) using all
; coins.  There's no reason we have to consider the coins in
; increasing/decreasing/any order.
