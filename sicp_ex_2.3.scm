
(define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))

(define (improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
    (sqrt-iter 1.0 x))

(define (square x) (* x x))

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-rectangle p1 p2)
    (cond   ((= (x-point p1) (x-point p2)) (error "x coordinates of the two points are the same))
            ((= (y-point p1) (y-point p2)) (error "y coordinates of the two points are the same))
            (else (cons p1 p2))))


(define (area r)
    (sqrt (+    (square (- (x-point(cdr r)) (x-point(car r))))
                (square (- (y-point(cdr r)) (y-point(car r)))))))