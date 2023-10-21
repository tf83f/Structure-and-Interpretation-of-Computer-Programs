(define (average x y) (/ (+ x y) 2))

(define (average-damp f)
    (lambda (x) (average  x (f x))))

(define tolerance 0.0001)

(define (close-enough? x y) (< (abs (- x y)) 0.001))

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))

(define (power x n)
  (if (= n 1)
      x
      (* x (power x (- n 1)))))

(define (nth-root x nth)
  (fixed-point 
    ((repeated average-damp (floor (log nth))) 
    (lambda (y) 
      (/ x (power y (- nth 1)))))
   1.0))

(display (nth-root 2 258))