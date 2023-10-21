(define (for-each proc items)
    (proc (car items))
    (if (not (null? (cdr items))) (for-each proc (cdr items))))

(define nil '()) 

(define (for-each_2 proc items) 
   (cond ((null? items) nil) 
         ((null? (cdr items)) (proc (car items))) 
         (else (proc (car items)) (for-each_2 proc (cdr items)))))

(for-each (lambda (x) (newline)
            (display x))
          (list 57 321 88))


(newline)

(for-each_2 (lambda (x) (newline)
            (display x))
          (list 57 321 88))

