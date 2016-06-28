; Exercise 1.34
; Suppose we define
(define (f g)
  (g 2))

; What happens if we ask the interpreter to evaluate the combination (f f)?
(f f)

; It crashes! f calls its argument with argument 2. So on its third iteration:
; (f f)
; (f 2)
; (2 2)    ; error: 2 is not a function!
