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


; Exercise 2.10
; "It is not clear what it means to divide by an interval that spans zero."
; Modify Alyssa's code to check for this condition and to signal an error if it
; occurs.
(define (interval-includes-zero lower upper)
  (not (> (sgn (* lower upper)) 0)))

(define (div-interval x y)
  (if (interval-includes-zero x y)
      (error "Can't divide by an interval that includes zero")
      (mul-interval x
                    (make-interval
                     (/ 1.0 (upper-bound y))
                     (/ 1.0 (lower-bound y))))))

; Exercise 2.11
; "By testing the signs of the endpoints of the intervals, it is possible to break
; `mul-interval` into nine cases, only one of which requires more than two
; multiplications." Rewrite the procedure using this suggestion.

; Given the problem of (a,b) * (c,d), assume WLOG that a<b and c<d.
; Then there are indeed 9 possible sign configurations:
;
;   a   b   c   d   |   e      f
; -------------------------------------
;   +   +   +   +   |  ac      bd
;   -   +   +   +   |  ad      bd
;   +   +   -   +   |  bc      bd
;   -   -   +   +   |  ad      bc
;   +   +   -   -   |  bc      ad
;   -   -   -   +   |  ad      ac
;   -   +   -   -   |  bc      ad
;   -   -   -   -   |  bd      ac
;   -   +   -   +   |  alpha   beta,
; where alpha = min(ad, bc) and beta = max(ac, bd)
; Thus, only one case requires more than two multiplications.

; Implementing this is going to be ugly, and it's not clear that this is going to
; be a bottleneck in our program, so let's hold off on the implementation for now.

;;;;;;;;;;;;

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i)
        (upper-bound i))
     2))

(define (width i)
  (/ (- (upper-bound i)
        (lower-bound i))
     2))

; Exercise 2.12
; Define a constructor make-center-percent that takes a center and a percentage
; tolerance and produces the desired intervals. You must also define a selector
; `percent` that produces the percentage tolerance.
(define (make-center-percent c p)
  (let* ([proportion (/ p 100)]
         [width (* proportion c)])
    (make-center-width c width)))

(define (percent int)
  (let ([prop (/ (width int) (center int))])
    (* 100 prop)))


; Exercise 2.13
; Show that under the assumption of small percentage tolerances, there is a simple
; formula for the approximate percentage tolerance of the product of two intervals
; in terms of the tolerances of the factors. Assume all numbers positive.

; I chose to work in PROPORTIONS instead of PERCENTAGES, but the math holds either way.
; Consider two intervals:
; I1 with proportion tolerance p1:     a------------alpha------------b
; I2 with proportion tolerance p2:     c--------beta--------d
; Then b = (1 + p1)*alpha
;      a = (1 - p1)*alpha
;      d = (1 + p2)*alpha
;      c = (1 - p2)*alpha
;
; If all numbers are positive, then the product of I1 and I2 will be:
; ac------------------alpha*beta-------------------bd
;
; ac = (1 - p1)*alpha * (1 - p2)*beta
;    = (1 - p1)(1 - p2) alpha*beta
;    = [1 - (p1 + p2) + p1*p2] alpha*beta
;
; bd = (1 + p1)*alpha * (1 + p2)*beta
;    = (1 + p1)(1 + p2) alpha*beta
;    = [1 + (p1 + p2) + p1*p2] alpha*beta
;
; And if p1 and p2 are both small, then p1*p2 will be REALLY small, so
; ac ~= [1 - (p1 + p2)] * alpha*beta
; bd ~= [1 + (p1 + p2)] * alpha*beta
;
; So the proportion tolerance for the product is approximately (p1 + p2), a simple
; function of the proportion tolerances for the individual intervals.


; Exercise 2.14 - 2.16
; Eva Lu is right. Every time we use an uncertain number in our intervals, we
; add noise to the system. We can never remove noise from the system.
;
; So while 0 = R1 - R1 is algebraically true, there's absolutely no uncertainly
; on the quantity 0, while (R1 - R1) could have quite a deal of uncertainty.
; and (R1 - R1) + (R1 - R1) would be even worse.
