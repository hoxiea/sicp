; In this exercise, Alyssa P. Hacker tries to define if in terms of cond:
(define (new-if pred then-clause else-clause)
  (cond (pred then-clause)
        (else else-clause)))

; This works in simple cases:
(new-if (= 2 3) 0 5)   ; 5
(new-if (= 1 1) 0 5)   ; 0

; But it will fail when used to redefine sqrt-iter. Why?
;
; We learned in the previous exercise that Lisp uses applicative-order
; evaluation when evaluating FUNCTION calls: first, it evaluates its arguments,
; and then it applies the results. 
;
; But the `if` that's built into the language isn't a function; it's a special
; form. And the thing that's really special about it is that it doesn't just
; immediately evaluate all its arguments. Instead, it evaluates the predicate
; and then evaluates EITHER the then-clause or the else-clause, depending on
; the value of the predicate.
;
; The value of this behavior becomes quite evident in a case like sqrt-iter:
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

; Calling (sqrt-iter 1.0 9) will immediately dump us into a call to new-if.
; new-if is a function and not a special form, so Lisp evaluates all three inputs:
; (good-enough? guess x), guess, and (sqrt-iter (improve guess x) x).
; But that last input, another call to sqrt-iter, will result in another call to
; new-if, which is still a plain-old function, so it'll evaluate its inputs.
; These, of course, include a call to sqrt-iter, which includes a call to sqrt-iter,
; which means we hit another infinite loop.
