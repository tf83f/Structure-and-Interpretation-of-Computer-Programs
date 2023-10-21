
(define (enumerate-interval low high)
    (if (> low high)
        nil
        (cons low (enumerate-interval (+ low 1) high))))

(define nil '())
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

(define (flatmap proc seq)
    (accumulate append nil (map proc seq)))

(define nil '())

 (define (unique-tuples n k) 
     (cond ((< n k) nil) 
           ((= k 0) (list nil)) 
           (else (append (unique-tuples (- n 1) k) 
                         (map (lambda (tuple) (cons n tuple)) 
                              (unique-tuples (- n 1) (- k 1))))))) 
  
 (define (triples-of-sum s n) 
     (filter (lambda (seq) (= (accumulate + 0 seq) s)) 
             (unique-tuples n 3))) 
(display (triples-of-sum 20 30))
  
