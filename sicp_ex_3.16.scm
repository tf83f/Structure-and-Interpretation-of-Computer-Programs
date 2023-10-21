(define (count-pairs x) 
    (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

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
