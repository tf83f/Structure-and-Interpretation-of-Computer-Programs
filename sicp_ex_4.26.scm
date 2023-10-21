

 (define (unless? expr) (tagged-list? expr 'unless)) 
 (define (unless-predicate expr) (cadr expr)) 
 (define (unless-consequnce expr) 
   (if (not (null? (cdddr expr))) 
       (cadddr expr) 
       'false)) 
 (define (unless-alternative expr) (caddr expr)) 
  
 (define (unless->if expr) 
   (make-if (unless-predicate expr) (unless-consequence expr) (unless-alternative expr))) 