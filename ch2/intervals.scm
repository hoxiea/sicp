(define (add-interval x y)
  (make-interval (+ (lower-bound x)
                    (lower-bound y))
                 (+ (upper-bound x)
                    (upper-bound y))))

(define (mul-interval x y)
  (let ([p1 (* (lower-bound x) (lower-bound y))]
        [p2 (* (lower-bound x) (upper-bound y))]
        [p3 (* (upper-bound x) (lower-bound y))]
        [p4 (* (upper-bound x) (upper-bound y))])
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval
                  (/ 1.0 (upper-bound y))
                  (/ 1.0 (lower-bound y)))))

; Exercise 2.7
(define (make-interval a b) (cons a b))
(define (upper-bound int) (cdr int))
(define (lower-bound int) (car int))

; Exercise 2.8
; When considering x-y, the outcome is smallest with x's lower value and y's upper value
;                                  and largest  with x's upper value and y's lower value
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

; Exercise 2.9
; width == radius of interval
; Show that the width of a sum or difference is a function only of the widths
; of the inputs. Give examples to show that this is not the case for
; multiplication/division.

; If x is interval a-------alpha-------b with width w1
;    y is interval c-----------beta-----------d with width w2,
; then x + y is interval e----------------gamma-----------------f, where
;   gamma = alpha + beta
;   e = gamma - (w1 + w2)
;   f = gamma + (w1 + w2)
; Thus, x + y has width (w1 + w2), which is a function only of the widths of x and y.
; And subtraction can be expressed directly in terms of addition, so it should be true
; for subtraction too.

; To prove that this doens't hold for multiplication, we need two sets of intervals
; with the same widths that produce products that have different widths. Two such
; pairs of intervals are:
; (-3, 3) x (4, 6)  = (-18, 18) => width = 18
; (1, 7) x (4, 6)   = (4, 42)  =>  width = 19
; Since the widths of the inputs were the same, but the widths of the resulting
; products differed, there must be more to the story than just the widths of
; the inputs.  And division is expressed directly in terms of multiplication,
; so we would expect that to be the case here as well.

