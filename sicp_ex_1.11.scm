 (define (f_r n) 
    (cond ((< n 3) n) 
         (else (+ (f_r (- n 1)) 
                  (* 2 (f_r (- n 2))) 
                  (* 3 (f_r (- n 3))))))) 



(define (f_i n)
    (define (f_loop a b c count) 
        (cond   ((< n 3) n)
                ((= count n ) a)
                (else (f_loop (+ a (* 2 b) (* 3 c)) a b (+ count 1)))))
    (f_loop 2 1 0 2))
                
                

(display (f_r 5))
(newline)
(display (f_i 5))
