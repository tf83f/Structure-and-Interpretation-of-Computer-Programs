(define (double a) (+ a a))

(define (halve a) (/ a 2))

(define (mul_iter a b total)
    (cond   ((= b 1) total)
            ((= (remainder b 2) 1) (mul_iter a (- b 1) (+ total a)))
            (else (mul_iter a (halve b) ( +(double a)total)))))


(define (mul_iter a b total)
    (cond   ((= b 1) total)
            ((= (remainder b 2) 1) (mul_iter a (- b 1) (+ total a)))
            (else (mul_iter a (halve b) ( +(double a)total)))))






(define (mul a b)
    (cond   ((= b 0) 0)
            ((= b 1) a)
            (else (mul_iter a b 0))))

(display (mul 3 0))
(newline)
(display (mul 3 1))
(newline)
(display (mul 3 2))
(newline)
(display (mul 3 3))
