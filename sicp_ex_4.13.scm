
 (define (make-unbound! var) (list 'unbound! var))                
 (define (unbound? exp) (tagged-list? exp 'unbound!)) 
 (define (unbound-variable expr env) (make-unbound (cadr expr) env)) 

(define (make-unbound! var env) 
     (let ((frame (first-frame env))) 
         (define pairs  
             (filter (lambda (pair) (not (eq? (car pair) var-target))) 
                     (map cons (car frame) (cdr frame)))) 
         (set-car! frame (map car pairs)) 
         (set-cdr! frame (map cdr pairs)))) 