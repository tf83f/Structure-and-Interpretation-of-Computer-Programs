(define dx 0.00001)

(define (square x) (* x x))

(define (compose f g) (lambda (x) (f (g x))))

(define (smooth f) (lambda (x)  (/ (+ (f x) (f (- x dx)) (f (+ x dx))) 3)))

(define (repeated-smooth f n) 
    (if (= n 1) 
        (smooth f)
        (compose (smooth f) (repeated-smooth f (- n 1)))))

(display ((repeated-smooth square 2) 5))
(newline)


(define (repeated f n) 
    (if (= n 1) 
        f
        (compose f (repeated f (- n 1)))))

(define (smooth-nth f n)
  ((repeated smooth n) f))


(define (smooth-nth f n)
    ((repeated smooth n) (lambda (x) (f x))))

(display ((smooth-nth square 2) 5))

