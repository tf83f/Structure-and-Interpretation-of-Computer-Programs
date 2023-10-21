(define (same-parity first . rest)
    (define (iter source result parity)
        (if (null? source)
            result
            (iter (cdr source) (if (= parity (remainder (car source) 2))
                                        (append result (list (car source)))
                                        result) parity)))
            
    (iter rest (list first) (remainder first 2)))

 (define (same-parity_with_reverse first . rest) 
   (let ((yes? (if (even? first) even? odd?))) 
     (define (iter items result) 
       (if (null? items) 
           (reverse result) 
           (iter (cdr items) (if (yes? (car items)) 
                                 (cons (car items) result) 
                                 result)))) 
     (iter rest (list first)))) 
    

(display (same-parity 1 2 3 4 5 6 7))
(newline)
(display (same-parity 2 3 4 5 6 7))
(newline)
(display (same-parity_with_reverse 1 2 3 4 5 6 7))
(newline)
(display (same-parity_with_reverse 2 3 4 5 6 7))



