; Exercise 2.25
; Pick 7
(define l1 '(1 3 (5 7) 9)) 
(define l2 '((7))) 
(define l3 '(1 (2 (3 (4 (5 (6 7))))))) 

(car (cdr (car (cdr (cdr l1)))))

(car (car l2))

(cadr (cadr (cadr (cadr (cadr (cadr l3))))))


; This last one threw me off a little bit.
; Considering a slightly simpler version of l3: (1 (2 (3 4))),
; it seems like the car of that should be 1 (it is)
;           and the cdr of that should be (2 (3 4)) (it's NOT)
; The cdr of that is actually ((2 (3 4))), i.e. the thing it "should" be in another list
; 
; One way to intuit this in hindsight is to notice that (cdr (1 2 3))
; is (2 3). So even when all list elements are at the top level, the cdr
; is still a list. So when the second element is a LIST, then the cdr will
; be a list within a list, which is what we see here.
