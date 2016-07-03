; Exercise 2.2
; Consider the problem of representing line segments in a plane. Each segment
; is represented as a pair of points: a starting point and an ending point.

; Point constructor and accessors
(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

; Line segment constructor and accessors
(define (make-segment p1 p2)
  (cons p1 p2))
(define (start-segment s)
  (car s))
(define (end-segment s)
  (cdr s))

; Functions that work with line segments
(define (average a b)
  (/ (+ a b) 2))

(define (midpoint-segment s)
  (let ([x-start (x-point (start-segment s))]
        [x-end   (x-point (end-segment s))]
        [y-start (y-point (start-segment s))]
        [y-end   (y-point (end-segment s))])
  (make-point (average x-start x-end)
              (average y-start y-end))))

; Testing it out
(define p1 (make-point 1 2))
(define p2 (make-point 5 4))
(print-point (midpoint-segment (make-segment p1 p2)))  ; (3,3)

(define p1 (make-point -3 -3))
(define p2 (make-point 3 3))
(print-point (midpoint-segment (make-segment p1 p2)))  ; (0,0)
