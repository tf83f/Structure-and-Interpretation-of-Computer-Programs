(define (cont-frac-iterative n d k)
    (define (iter total k)
        (if     (= k 0)
                total
                (iter (/ (n k) (+ (d k) total)) (- k 1))))
    (iter 0 k))

(define (n i) 1.0)

(define (d-cont i s n t) 
    (cond   ((and (= i s) (< n 2)) 1)
            ((and (= i s) (= n 2)) t)
            ((< n 2) (d-cont i (+ s 1) (+ n 1) t))
            ((= n 2) (d-cont i (+ s 1) 0 (+ t 2)))))
(define (d i) 
    (cond   ((= 1 i) 1)
            ((= 2 i) 2)
            (else (d-cont i 3 0 4)))) 

(display (+ 2 (cont-frac-iterative n d 11)))
