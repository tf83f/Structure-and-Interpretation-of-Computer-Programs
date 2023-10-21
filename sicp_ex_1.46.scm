(define (iterative-improve good-enough? improve)
    (define (iter guess)
        (let ((next (improve guess)))
        (if (good-enough? next) 
            next
            (iter next))))
    (lambda (x) (iter x)))

(define (close-enough? v1 v2) (< (abs (- v1 v2)) tolerance))

(define (fixed-point f first-guess)
    ((iterative-improve (lambda (x) (close-enough? x (f x))) f) first-guess))
(define (square x) (* x x))

(define (average x y)
  (/ (+ x y) 2))

 (define (sqrt x) 
   ((iterative-improve 
     (lambda (y) 
       (< (abs (- (square y) x)) 
          0.0001)) 
     (lambda (y) 
       (average y (/ x y)))) 
    1.0)) 
  
(display (sqrt 9))
(newline)

