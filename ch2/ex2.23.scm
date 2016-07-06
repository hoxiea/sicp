; Exercise 2.23
; for-each just applies a function to each element in turn, left to right

(define (my-for-each f L)
  (map f L)
  #t)

(my-for-each
  (lambda (x) (newline) (display x))
  (list 1 2 3))
