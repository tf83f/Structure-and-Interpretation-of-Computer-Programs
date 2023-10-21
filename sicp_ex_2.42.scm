(load "sicp_chap_2.scm")

 (define (queen col row) (list col row)) 
 (define (col x) (car x)) 
 (define (row x) (cadr x)) 
  
 (define (contains x list) 
         (cond ((null? list) #f) 
               ((equal? (car list) x) #t) 
               (else (contains x (cdr list))))) 
  
 (define (flatmap proc seq) (accumulate append nil (map proc seq))) 
  
 (define empty-board nil) 
  
 (define (adjoin-position k new-row rest-of-queens) 
   (cons (queen k new-row) rest-of-queens)) 
  
 (define (safe? k positions) 
   (let ((newqueen (car positions)) 
         (others (cdr positions))) 
     (cond 
      ((or 
        (contains (row newqueen) (map row others)) 
        (contains (- (col newqueen) (row newqueen)) (map (lambda (x) (- (col x) (row x))) others)) 
        (contains (+ (col newqueen) (row newqueen)) (map (lambda (x) (+ (col x) (row x))) others))) 
       #f) 
      (else #t)))) 
  
 (define (queens board-size) 
   (define (queen-cols k) 
     (if (= k 0) 
         (list empty-board) 
         (filter 
          (lambda (positions)  
            (safe? k positions)) 
          (flatmap 
           (lambda (rest-of-queens) 
             (map (lambda (new-row) 
                    (adjoin-position  
                     k 
                     new-row  
                     rest-of-queens)) 
                  (enumerate-interval  
                   1  
                   board-size))) 
           (queen-cols (- k 1)))))) 
   (queen-cols board-size)) 
   
(display (length (queens 8)))

