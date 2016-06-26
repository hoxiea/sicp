; Write a procedure that computes elements of Pascal's triangle by means of
; a recursive process.

(define (pascal-rec row pos)
  ; row: 1-indexed row of the triangle
  ; pos: 1-indexed position you're interested in, from the left
  ; Assumes 1 <= pos <= row
  (cond ((or (= pos 1) (= pos row)) 1)
        ((or (< pos 1) (> pos row)) 0)
        (else (+ (pascal-rec (dec row) (dec pos))
                 (pascal-rec (dec row) pos)))))
