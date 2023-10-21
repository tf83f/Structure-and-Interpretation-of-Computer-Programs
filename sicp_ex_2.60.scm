 ; Theta(n) but n could be large due to duplicates (the "new" n can be up to 2 "old" n). Previously Theta(n) with no duplicates. 
 (define (element-of-set? x set) 
   (cond ((null? set) false) 
         ((equal? x (car set)) true) 
         (else (element-of-set? x (cdr set))))) 
  
 ; Theta(1). Previously Theta(n). 
 (define (adjoin-set x set) (cons x set)) 
  
 ; Theta(n). Previously Theta(n^2). 
 (define (union-set set1 set2) (append set1 set2)) 
  
 ; Theta(n^2) but n could be large due to duplicate (the "new" n can be up to 2 "old" n). Previously Theta(n^2). 
 (define (intersection-set set1 set2) 
   (cond ((or (null? set1) (null? set2)) '()) 
         ((element-of-set? (car set1) set2) 
          (cons (car set1) (intersection-set (cdr set1) set2))) 
         (else (intersection-set (cdr set1) set2)))) 