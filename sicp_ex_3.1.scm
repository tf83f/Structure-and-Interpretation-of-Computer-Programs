(define (make-accumulator balance)
    (define (accumulate x)
        (begin (set! balance (+ x balance)) balance))
    accumulate)

(define (make-accumulator-lambda balance)
   (lambda (x) (set! balance (+ balance x)) balance))

(define A (make-accumulator 5))
(display (A 10))
(newline)
(display (A 10))

(newline)
(newline)

(define B (make-accumulator-lambda 5))
(display (B 10))
(newline)
(display (B 10))


