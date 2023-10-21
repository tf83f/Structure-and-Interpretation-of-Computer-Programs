(define (accumulate op initial sequence) 
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

 (define (accumulate-n op init sequence) 
   (define nil '()) 
   (if (null? (car sequence)) 
       nil 
       (cons (accumulate op init (map car sequence)) 
             (accumulate-n op init (map cdr sequence)))))

(define (dot-product v w)
    (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v) 
    (map (lambda (w) (dot-product v w)) m))

(define (transpose m) 
   (accumulate-n cons () m)) 
  
 (define (matrix-*-matrix m n) 
   (let ((cols (transpose n))) 
     (map (lambda (v) (matrix-*-vector cols v)) m))) 