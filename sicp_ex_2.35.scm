
(define (accumulate op initial sequence) 
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (map proc items)
    (if (null? items)
        '() 
        (cons   (proc (car items))
                (map proc (cdr items)))))

(define (count-leaves t)
    (accumulate + 0 (map (lambda (t) ( cond ((null? t) 0)
                                            ((pair? t) (count-leaves t))
                                            (else 1))) t)))
(define tree (list 1 2 (list 3 4) (list 5 (list 6 7)))) 

(display (count-leaves tree))