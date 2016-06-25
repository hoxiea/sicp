; Observe that our model of evaluation allows for combinations whose operators
; are compound expressions. Use this observation to describe the behavior of
; the following procedure:
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; As the name suggests, we're interested in a + |b|. 
; Mathematically, a + |b| = a + b if b > 0
;                         = a - b if b <= 0
;
; This mathematical definition inspires the behavior seen in a-plus-abs-b:
; a and b should be combined using either + or -, where the operator you use
; depends on the sign of b. Returning either the + or - built-in function is
; very functional and achieves the desired result very concisely.
