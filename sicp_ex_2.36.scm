(define (accumulate op initial sequence) 
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (map proc items)
    (if (null? items)
        nil 
        (cons   (proc (car items))
                (map proc (cdr items)))))
                
 (define (accumulate-n op init sequence) 
   (define nil '()) 
   (if (null? (car sequence)) 
       nil 
       (cons (accumulate op init (map car sequence)) 
             (accumulate-n op init (map cdr sequence)))))

(define s (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
(display (accumulate-n + 0 s))