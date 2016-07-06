; Exercise 2.18
; Define a procedure `reverse` that takes a list as argument and returns
; the reversed version of the list:

(define (my-reverse x)
  (if (null? x)
    x
    (append (my-reverse (cdr x)) (list (car x)))))

(my-reverse (list 1 4 9 16 25))
