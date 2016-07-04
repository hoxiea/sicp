; Exercise 2.3
; Implement a representation for rectangle in a plane.
; Create procedures that compute the perimeter and the area of a 
; given rectangle.

; For simplicity, I implemented a representation of rectangles
; with sides parallel to the x and y axis. Rectangles of this type can be
; parameterized via two corner points:
;
;    --------------p2
;    |              |
;    |              |   vert-length
;    |              |
;    p1--------------
;
;        hor-length

; Point constructor and accessors, from Exercise 2.2
(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

; First implementation of rectangles, constructor and accessors
(define (make-rect p1 p2)
  (cons p1 p2))
(define (corner1 rect)
  (car rect))
(define (corner2 rect)
  (cdr rect))

(define (hor-length rect)
  (abs (- (x-point (corner1 rect)) (x-point (corner2 rect)))))
(define (vert-length rect)
  (abs (- (y-point (corner1 rect)) (y-point (corner2 rect)))))

(define (perimeter rect)
  (+ (* 2 (hor-length rect)) (* 2 (vert-length rect))))

(define (area rect)
  (* (hor-length rect) (vert-length rect)))

; Testing first implementation
(define p1 (make-point 1 2))
(define p2 (make-point 5 4))
(define rect1 (make-rect p1 p2))
(perimeter rect1)    ; 12
(area rect1)         ; 8

; Order of the points doesn't matter
(define rect2 (make-rect p2 p1))
(perimeter rect2)    ; 12
(area rect2)         ; 8



; Another way to parameterize a rectangle (parallel to x/y-axes) is by storing
; the bottom-left point, along with the horizontal and vertical distances.
(define (make-rect-alt bottom-left-point hor vert)
  (cons bottom-left-point (cons hor vert)))
(define (hor-length rect)
  (car (cdr rect)))          ; (cadr rect) works too
(define (vert-length rect)
  (cdr (cdr rect)))          ; (cddr rect) works too

(define p1 (make-point 1 2))
(define rect1-alt (make-rect-alt p1 4 2))
(perimeter rect1-alt)    ; 12
(area rect1-alt)         ; 8

; Negative distances work just fine
(define rect2-alt (make-rect-alt p1 -4 -2))
(perimeter rect1-alt)    ; 12
(area rect1-alt)         ; 8
