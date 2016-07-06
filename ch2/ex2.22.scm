; Exercise 2.22
(define (square x) (* x x))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))

; This indeed will produce the answer list in the reverse order.
; It processes items from head to tail, but when it conses the result of
; squaring head, that will be the last element to appear in the answer list.

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square 
                     (car things))))))
  (iter items nil))

; This gets the squared values in the correct order, but at the expense of producing
; a weird set of nested cons pairs.
(square-list (list 1 2 3 4 5))    ; {{{{{() . 1} . 4} . 9} . 16} . 25}
