
(define (sum-weight p) (+ (car p) (cadr p)))

(define (merge-weighted s1 s2 proc)
    (cond   ((stream-null? s1) s2)
            ((stream-null? s2) s1)
            (else
                (let    ((s1-weight (proc s1))
                        (s2-weight (proc s2)))
                    (cond   ((< s1-weight s2-weight) (cons-stream (stream-car s1) (merge (stream-cdr s1) s2 proc)))
                            ((> s1-weight s2-weight) (cons-stream (stream-car s2) (merge s1 (stream-cdr s2) proc)))
                            (else (cons-stream (stream-car s1) (merge (stream-cdr s1) (stream-cdr s2) proc))))))))

 (define (weighted-pairs s1 s2 proc) 
   (cons-stream 
    (list (stream-car s1) (stream-car s2)) 
    (merge-weighted 
        (stream-map (lambda (x) (list (stream-car s1) x)) (stream-cdr s2)) 
        (weighted-pairs (stream-cdr s1) (stream-cdr s2) proc) 
        proc))) 

(define (not-divisible? dividend divisor) (not (= 0 (remainder dividend divisor))))

(define (compound-not-divisible? dividend x y z)
    (and    (not-divisible? dividend x)
            (not-divisible? dividend y)
            (not-divisible? dividend z)))

(define filtered-integers
    (stream-filter (lambda (x) (compound-not-divisible? x 2 3 5)) integers))

(define ordered-conditional-pairs 
   (weighted-pairs filtered-integers filtered-integers weight)) 
  