(define (expt b n)
    (define (expt_iter a b n)
        (cond   ((= n 0) a)
                ((= (remainder n 2) 1) (expt_iter (* a b) b (- n 1)))
                (else (expt_iter a (* b b) (/ n 2)))))
    (expt_iter 1 b n))


(display (expt 2 3))
