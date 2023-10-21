(define (map proc items)
    (if (null? items)
        #nil 
        (cons   (proc (car items))
                (map proc (cdr items)))))

(define (subsets s)
    (if (null? s)
        (list '())
        (let ((rest (subsets (cdr s))))
            (append rest (map (lambda (x) (cons (car s) x)) rest)))))

(define x (list 1 2 3))
(display (subsets x))