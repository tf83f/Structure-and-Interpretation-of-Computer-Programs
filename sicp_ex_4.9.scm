;(define (while? exp) (tagged-list? exp 'while))
;(define (while-predicate exp) (cadr exp))
;(define (while-body exp) (cddr exp))

 ; (while (< i 100)  
 ;     (display i)  
 ;     (set! i (+ i 1)))  


 ((lambda (i)
    (define (while-procedure)
        (if (< i 100)
            (begin
                (display i)
                (newline)
                (set! i (+ i 1))
                (while-procedure))))
    (while-procedure)) 90)



