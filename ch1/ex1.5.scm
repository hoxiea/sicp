; Ben Bitdiddle has invented a test to determine whether the interpreter he is
; faced with is using applicative-order evaluation or normal-order evaluation.
; He defines the following two procedures:
(define (p) (p))

(define (test x y)
  (if (= x 0)
    0
    y))

; Then he evaluates the expression
(test 0 (p))
; What behavior will he observe via applicative-order evaluation? Normal-order evaluation?


;;;;;;
; Function p is a recursive infinite loop: it's a function of no variables that
; simply calls itself when called, which will call itself, which will call
; itself...

; Normal-order evaluation involves fully expanding function calls and then
; reducing, essentially delaying evaluation until the values are actually needed.
;
; Applicative-order evaluation involves evaluating the arguments and then applying.
;
; In our case, (test 0 (p)) is a call to function `test`, with arguments 0 and
; the result of calling function `p`. If the interpreter immediately evaluates
; test, 0, and (p) as it will in applicative-order evaluation, then we'll hit
; the infinite loop of p. If the interpreter delays evaluation until values are
; needed, then we won't hit the infinite loop, because the 0 will cause us to
; take the first branch of the if statement in `test`.
;
; According to page 17, Lisp uses applicative-order evaluation, and indeed,
; running the above code causes an infinite loop, as predicted by our model.
