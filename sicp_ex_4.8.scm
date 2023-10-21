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


(define (named-let? expr) (and (let? expr) (symbol? (cadr expr)))) 
 (define (named-let-name exp) (cadr exp)) 
 (define (named-let-body expr) (cdddr expr)) 
 (define (named-let-vars exp) (map car (caddr exp))) 
 (define (named-let-args exp) (map cadr (caddr exp))) 
  
 (define (named-let->func exp) 
     (list 'define  
           (cons (named-let-name expr) (named-let-vars exp)) 
           (named-let-body exp))) 
  
 (define (let->combination exp) 
     (if (named-let? exp) 
         (sequence->exp 
           (list (named-let->func exp) 
                 (cons (named-let-name exp) (named-let-args exp)))) 
         (cons (make-lambda 
                    (let-vars expr) 
                    (let-body expr))
               (let-args exp)))) 
          