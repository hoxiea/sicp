(define (plus-v1 a b)
  (if (= a 0)
    b
    (inc (plus-v1 (dec a) b))))

; This is a linear recursive process:
; (plus-v1 4 5)
; (inc (plus-v1 3 5))
; (inc (inc (plus-v1 2 5)))
; (inc (inc (inc (plus-v1 1 5))))
; (inc (inc (inc (inc (plus-v1 0 5)))))
; (inc (inc (inc (inc 5))))
; (inc (inc (inc 6)))
; (inc (inc 7))
; (inc 8)
; 9
; In addition to the state variables, you also need to know how many calls are
; currently on the stack.

(define (plus-v2 a b)
  (if (= a 0)
    b
    (+ (dec a) (inc b))))

; This is a linear iterative process:
; (plus-v2 4 5)
; (plus-v2 3 6)
; (plus-v2 2 7)
; (plus-v2 1 8)
; (plus-v2 0 9)
; 9
; All information needed is contained in the state variable inputs.
