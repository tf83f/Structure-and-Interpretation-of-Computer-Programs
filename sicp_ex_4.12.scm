
(define (lookup-variable-value var env)
    (env-loop   env 
                (lambda (env) (env-loop (enclosing-environment env)))
                (lambda (vals) (car vals))))

(define (set-variable-value! var val env)
    (env-loop   env 
                (lambda (env) (env-loop (enclosing-environment env)))
                (lambda (vals) (set-car! vals val))))

(define (define-variable! var val env)
    (env-loop env 
                   (lambda (env) (add-binding-to-frame!  
                                     var val (first-frame env))) 
                   (lambda (vals) (set-car! vals val))))

(define (env-loop env next match)
        (define (scan vars vals) 
            (cond ((null? vars) (next env))) 
                ((eq? var (car vars)) (match vals))
                (else (scan (cdr vars) (cdr vals)))))
        (if (eq? env the-empty-environment) 
            (error "Unbound variable" var) 
            (let ((frame (first-frame env)))
                (scan (frame-variables frame) (frame-values frame)))))
