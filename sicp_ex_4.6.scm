((let? exp) (eval (let->combination exp) env))

(define (let? exp) (tagged-list? exp 'let))
(define (let-vars exp) (map car (cadr exp)))
(define (let-args exp) (map cadr (cadr exp)))
(define (let-body exp) (cddr exp))
(define (let->combination exp) 
    (cons   (make-lambda 
                (let-vars exp) 
                (let-body exp)) 
            (let-args exp)))
