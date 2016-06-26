; sin(x) = x, if x < 0.1 rad
;          3*sin(x/3) - 4*sin^3(x/3), else

(define (cube x) (* x x x))

(define (p x) (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
    angle
    (p (sine (/ angle 3.0)))))

; a) How many times is `p` applied when (since 12.15) is evaluated?
; (sine 25/2)
; (p (sine 25/6))
; (p (p (sine 25/18)))
; (p (p (p (sine 25/54))))
; (p (p (p (p (sine 25/162)))))
; (p (p (p (p (p (sine 0.05144))))))
; So `p` is applied 5 times total

; b) The relevant order of growth here is theta(log_3(n)).
; At each iteration, we chop the argument down by a factor of three.
; Said another way, we can scale the argument up by a factor of three and add
; just one more step.
