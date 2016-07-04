; Exercise 2.5
; Show that we can represent pairs of nonnegative integers using only numbers
; and arithmetic operations if we reperesent the pair a and b as the integer
; that is the product 2^a * 3^b. Give the corresponding definitions of the
; procedures cons, car, and cdr.

; 2 and 3 are coprime, so there's a one-to-one mapping between (a, b) and 2^a * 3^b.
(define (cons-alt a b) 
  (* (expt 2 a) (expt 3 b))) 

; To find a, we keep dividing by 2 until we can't anymore.
; The number of times we COULD divide by 2 must be a.
; Did this one as a linear iterative process.
(define (car-alt x)
  (define (car-alt-helper current num-times)
    (if (> (remainder current 2) 0)  ; can't divide by 2 anymore
      num-times
      (car-alt-helper (/ current 2) (inc num-times))))
  (car-alt-helper x 0))

; Same deal for b, except now we divide by 3.
; Did this one as a linear recursive process.
(define (cdr-alt x)
  (define (cdr-alt-helper current)
    (if (> (remainder current 3) 0)  ; can't divide by 3 anymore
      0
      (+ 1 (cdr-alt-helper (/ current 3)))))
  (cdr-alt-helper x)) 

; Using it
(define x (cons-alt 4 5))
(car-alt x)   ; 4
(cdr-alt x)   ; 5
