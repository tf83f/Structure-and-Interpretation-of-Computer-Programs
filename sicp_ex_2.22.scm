(define nil '())

(define (square x) (* x x))

(define (square-list items) (define (iter things answer)
    (if (null? things) answer
            (iter (cdr things)
                (cons (square (car things)) answer))))
    (iter items nil))

; it is in reverse because we join (cons) in the wrong order.
; with cons we put the "new answer" before the "old answers"

(display (square-list (list 1 2 3 4 5)))
(newline)

(define (square-list_2 items) (define (iter things answer)
    (if (null? things) answer
            (iter (cdr things)
                (cons answer (square (car things))))))
    (iter items nil))

(display (square-list_2 (list 1 2 3 4 5)))
(newline)

; this changes nothing because answer is a list, so it will (list (list ...))