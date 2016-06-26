; A function f is defined by the rule that f(n) = n if n < 3 and f(n) = f(n-1)
; + 2f(n-2) + 3f(n-3) if n >= 3. Write a procedure that computes f by means of
; a recursive process. Write a procedure that computes f by means of an
; iterative process.

(define (a-plus-2b-plus-3c a b c)
  (+ a (* 2 b) (* 3 c)))


(define (f-recursive n)
  (if (< n 3)
    n
    (a-plus-2b-plus-3c (f-recursive (- n 1))
                       (f-recursive (- n 2))
                       (f-recursive (- n 3)))))


(define (f-iterative n)
  (define (f-iterative-helper n a b c)
    (if (= n 0)
        a
        (f-iterative-helper (dec n) b c (a-plus-2b-plus-3c c b a))))
  (f-iterative-helper n 0 1 2))

