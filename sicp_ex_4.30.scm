(define (eval-sequencce exps env)
    (cond   ((last-exp? exps) (eval (first-exp exps) env))
            (else   (actual-value (first-exp epxs) env)
                    (eval-sequence (rest-exps exps) env))))

;a the for-each proocedure will force an actual-value for each item of 
; the sequence because of the use of a primitivie procedure (display)

;b
;original   => (1 . 2) 
            => (1 . ) (set! x (cons x '(2))) (a thunk) won't be forced
; Cy => (1 . 2)
     => (1 . 2) because (set! x (cons x '(2))) will be forced to be evaluated immediately

;c Cy method force all the expression using actual-value 

; Cy method seems to go against the goal of lazy evaluation.

