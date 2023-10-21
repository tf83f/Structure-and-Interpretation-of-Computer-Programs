; x = 1 + 1/x
; => x^2 = x + 1
; => x^2 - x - 1 = 0
; => we solve it and x = ( 1 + sqrt(5)) / 2

(define tolerance 0.0001)

(define (average x y) (/ (+ x y) 2))

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))

(display (fixed-point (lambda (x) (average x (+ 1 (/ 1 x)))) 1.0))