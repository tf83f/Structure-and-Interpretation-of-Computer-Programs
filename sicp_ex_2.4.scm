(define (cons x y)
    (lambda (m) (m x y)))

(define (car z)
    (z (lambda (p q) p)))


; with z as (cons x y)

; (car z)
; (car (cons x y))
; => (car (lambda (m) (m x y)))
; => ((lambda (m) (m x y)) (lambda (p q) p))
; => ((lambda (p q) p) x y )
; => x

(define (cdr z)
    (z (lambda (p q) q))))