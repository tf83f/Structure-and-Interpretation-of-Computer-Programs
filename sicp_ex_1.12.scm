(define (pascal r c)
    (cond   ((= c r) 1)
            ((= c 1) 1)
            (else (+  (pascal (- r 1) (- c 1)) (pascal (- r 1) c)))))
                
                
(display (pascal 5 3))
(newline)
(display (pascal 5 2))