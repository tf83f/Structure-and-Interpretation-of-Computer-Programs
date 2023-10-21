(define (x-point p) (car p))

(define (y-point p) (cdr p))

(define (make-point x y) (cons x y))

(define (make-segment start_point end_point) (cons start_point end_point))

(define (start-segment s) (car s))

(define (end-segment s) (cdr s))

(define (midpoint s)
    (let (  (x 
                (/  (+ (x-point (start-segment s)) (x-point (end-segment s)))
                    2))
            (y 
                (/  (+ (y-point (start-segment s)) (y-point (end-segment s)))
                    2))
            )
            (make-point x y)
                     
                    
                    ))

(define (print-point p) 
    (newline)
    (display "(") 
    (display (x-point p)) 
    (display ",")
    (display (y-point p))
    (display ")"))

(define p1 (make-point 1 1))
(define p2 (make-point 5 3))
(define s1 (make-segment p1 p2))
(define p3 (midpoint s1))
(print-point p3)