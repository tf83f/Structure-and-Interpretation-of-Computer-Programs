 (define (count-pairs x) 
   (let ((encountered '())) 
     (define (helper x) 
       (if (or (not (pair? x)) (memq x encountered)) 
         0 
         (begin 
           (set! encountered (cons x encountered)) 
           (+ (helper (car x)) 
              (helper (cdr x)) 
              1)))) 
   (helper x))) 

(define list3 '(a b c))
(define end '(end))
(define x (cons end end))
(define list4 (list x))
(define list7 (cons x x))

(display (count-pairs list3))
(newline)
(display (count-pairs list4))
(newline)
(display (count-pairs list7))
(newline)