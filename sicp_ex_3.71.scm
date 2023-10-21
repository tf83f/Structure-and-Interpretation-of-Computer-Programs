 (define (sum-of-cubes p) 
   (+ (cube (car p)) (cube (cadr p))))  
  
 (define ordered-sum-of-cubes 
   (stream-map sum-of-cubes (weighted-pairs integers integers sum-of-cubes))) 
  
 (define (ramanujan-stream s) 
   (let ((next (stream-cdr s))) 
     (if (= (stream-car s) (stream-car next)) 
         (cons-stream (stream-car s) 
                      (ramanujan-stream next)) 
         (ramanujan-stream next)))) 
  