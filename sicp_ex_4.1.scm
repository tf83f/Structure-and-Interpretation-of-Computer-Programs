(define (list-of-values exps env)
    (if (no-operands? exps)
        '()
        (cons (eval (first-operand exps) env)
                    (list-of-values (rest-operands exps) env))))

(define (list-of-values-lr exps env)
    (if (no-operands? exps)
        '()
        (let ((left (eval (first-operand exps) env)))
            (let ((right (list-of-values-lr (rest-operands exps) env)))
                (cons left right)))))

(define (list-of-values-rl exps env)
    (if (no-operands? exps)
        '()
        (let ((right (list-of-values-rl (rest-operands exps) env)))
            (let ((left (eval (first-operand exps) env)))
                (cons left right)))))


