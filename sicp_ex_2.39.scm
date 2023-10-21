(define (fold-left op initial sequence) 
    (define (iter result rest)
        (if (null? rest) result
                (iter (op result (car rest))
                    (cdr rest))))
    (iter initial sequence))

(define (fold-right op initial sequence) 
    (if (null? sequence)
        initial
        (op (car sequence)
            (fold-right op initial (cdr sequence)))))

(define nil '())
(define (reverse-using-right sequence)
    (fold-right (lambda (x y) (append y (list x))) nil sequence))
(define (reverse-using-left sequence)
    (fold-left (lambda (x y) (cons y x)) nil sequence))

(define items (list 1 2 3 4 5)) 
(display (reverse-using-right items))
(newline) 
(display (reverse-using-left items))