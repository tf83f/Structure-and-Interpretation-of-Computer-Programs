(define (expt b n) 
    (if (= n 0)
        1
        (* b (expt b (- n 1)))))

(controller
    (assign continue (label expt-done))
expt-loop
    (test (op =) (reg n) (const 0))
    (branch (label immediate-answer))

    (save continue)
    
    (assign n (op -) (reg n) (const 1))
    (assign continue (label after-expt))
    (goto (label expt-loop))

after-expt
    (restore continue)
    (assign val (op *) (reg val) (reg b))
    (goto (reg continue))
    
immediate-answer
    (assign val (const 1))
    (goto (reg continue))
    
expt-done)

(define (expt b n)
    (define (expt-iter counter product)
        (if (= counter 0) 
            product
            (expt-iter (- counter 1)
                        (* b product))))
        (expt-iter n 1))

(controller
    (assign val (const 1))

expt-loop
    (test (op =) (reg n) (const 0))
    (branch (label expt-done))
    (assign n (op -) (reg n) (const 1))
    (assign val (op *) (reg val) (reg b))
    (goto (expt-loop))

expt-done)