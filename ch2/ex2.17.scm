; Exercise 2.17
; Define a procedure last-air that returns the list that contains only the last
; element of a given nonempty list:
(define (last-pair x)
  (let ([tail (cdr x)])
    (if (null? tail)
        x
        (last-pair tail))))

(last-pair (list 23 72 149 34))     ; (34)
