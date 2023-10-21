(define (make-rat n d)
    (let    (   (g (gcd n d))
                (n_sign (> n 0))
                (d_sign (> d 0)))
            (cond   ((and n_sign d_sign) (cons (/ n g) (/ d g)))
                    ((and (not n_sign) (not d_sign)) (cons (-(/ n g)) (-(/ d g))))
                    ((and (not n_sign) d_sign) (cons (/ n g) (/ d g)))
                    ((and n_sign (not d_sign)) (cons (-(/ n g)) (-(/ d g))))
                    )))


(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x) 
    (newline)
    (display (numer x)) 
    (display " / ") 
    (display (denom x)))


(print-rat (make-rat 6 9)) 
(print-rat (make-rat -6 9)) 
(print-rat (make-rat 6 -9)) 
(print-rat (make-rat -6 -9))