(define (reverse items) 
   (if (null? (cdr items)) 
       items 
       (append (reverse (cdr items)) 
               (list (car items))))) 
(display (reverse (list 1 4 9 16 25)))