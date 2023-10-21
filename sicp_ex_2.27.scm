(define (reverse items)
    (if (null? (cdr items))
        items
        (append (reverse (cdr items)) (list (car items)))))

(define nil '()) 

(define (map proc items)
    (if (null? items)
        nil 
        (cons   (proc (car items))
                (map proc (cdr items)))))

 (define (deep-reverse x) 
   (if (list? x) 
       (reverse (map deep-reverse x)) 
       x)) 

 (define (fake-deep-reverse x) 
   (if (list? x) 
       (reverse (map reverse x)) 
       x)) 



(define x (list (list 1 2) (list 3 4)))
(define x2 (list (list 1 2) (list 3 (list 4 5))))
(display (reverse x))
(newline)
(display (deep-reverse x))
(newline)
(display (deep-reverse x2))
(newline)
(display (fake-deep-reverse x))

