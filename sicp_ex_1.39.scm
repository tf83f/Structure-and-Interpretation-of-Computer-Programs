

(define (cont-frac-iterative n d k)
    (define (iter total k)
        (if     (= k 0)
                total
                (iter (/ (n k) (+ (d k) total)) (- k 1))))
    (iter 0 k))

(define (tan-cf x k) (cont-frac-iterative (lambda (i) (if (= i 1) x (* x x -1))) (lambda (i)  (+ 1.0 (* 2 (- i 1)))) k))

(display (tan-cf 2  10))
(newline)
(display (tan-cf 1 8)) 