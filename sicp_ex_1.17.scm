(define (double a)
    (+ a a))

(define (halve a)
    (/ a 2))

(define (mul a b)
    (cond   ((= b 0) 0)
            ((= b 1) a)
            ((= (remainder b 2) 1) (+ a (mul a (- b 1))))
            (else (mul (double a) (halve b)))))

(display (mul 3 0))
(newline)
(display (mul 3 1))
(newline)
(display (mul 3 2))
(newline)
(display (mul 3 3))
