(define (square x) (* x x))

(define nil '())
(define (accumulate op initial sequence) 
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (map p sequence)
    (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

(define (append seq1 seq2)
    (accumulate cons seq2 seq1))

(define (length sequence)
    (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(define list1 (list 1 2 3 4 5))
(define list2 (list 6 7 8 9))
(display (map square list1))
(newline)
(display (append list1 list2))
(newline)
(display (length list2))

