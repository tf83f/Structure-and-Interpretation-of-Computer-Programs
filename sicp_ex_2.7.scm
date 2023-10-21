(define (make-interval a b) (cons a b))

(define (lower-bound x) (if (< (car x) (cdr x)) (car x) (cdr x)))
(define (upper-bound x) (if (>= (car x) (cdr x)) (car x) (cdr x)))

(define x (make-interval 3 2))
(display (lower-bound x))
(newline)
(display (upper-bound x))