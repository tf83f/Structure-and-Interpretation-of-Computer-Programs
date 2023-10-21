(define (cont-frac-iterative n d k)
    (define (iter total k)
        (if     (= k 0)
                total
                (iter (/ (n k) (+ (d k) total)) (- k 1))))
    (iter 0 k))

(display (cont-frac-iterative  (lambda (i) 1.0) (lambda (i) 1.0) 11))
(newline)

; k must be at least 11

(define (cont-frac-recursive n d k)
  (define (recur i)
    (if (= k i)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (recur (+ 1 i))))))
  (recur 1))

(display (cont-frac-recursive (lambda (i) 1.0) (lambda (i) 1.0) 11))
(newline)

