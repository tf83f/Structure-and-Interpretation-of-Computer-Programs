  (lambda (n)  
    ((lambda (fib) 
       (fib fib n)) 
     (lambda (f n) 
       (cond ((= n 0) 0) 
             ((= n 1) 1) 
             (else (+ (f f (- n 2)) (f f (- n 1)))))))) 
  

 (define (f x) 
   ((lambda (even? odd?) 
      (even? even? odd? x)) ; note above 
    (lambda (ev? od? n) 
      (if (= n 0) true (od? ev? od? (- n 1)))) 
    (lambda (ev? od? n) 
      (if (= n 0) false (ev? ev? od? (- n 1)))))) 
  