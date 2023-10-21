(define nil '())

(define (square-list items)
    (if (null? items)
        nil 
        (cons (* (car items) (car items)) (square-list (cdr items)))))

(define (map proc items)
    (if (null? items)
        nil 
        (cons   (proc (car items))
                (map proc (cdr items)))))

(define (square-list_2 items)
    (map (lambda (x)  (* x x)) items))

(display (square-list (list 1 2 3 4)))
(newline)
(display (square-list_2 (list 1 2 3 4)))