(define (make-vect x y) (cons x y))
(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))

(define (add-vect v1 v2)
    (let    ((x (+ (xcor-vect v1) (xcor-vect v2)))
             (y (+ (ycor-vect v1) (ycor-vect v2))))
        (make-vect x y))) 

(define (sub-vect v1 v2)
    (let    ((x (- (xcor-vect v1) (xcor-vect v2)))
             (y (- (ycor-vect v1) (ycor-vect v2))))
        (make-vect x y))) 

(define (scale-vect v a)
    (let    ((x (* (xcor-vect v) a))
             (y (* (ycor-vect v) a)))
        (make-vect x y))) 

(define (make-segment start-point end-point)
  (cons (make-vect (xcor-vect start-point) (ycor-vect start-point))
        (make-vect (xcor-vect end-point) (ycor-vect end-point))))


(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))