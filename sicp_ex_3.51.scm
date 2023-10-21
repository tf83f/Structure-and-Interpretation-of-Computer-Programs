 (define delay (lambda (proc) (memo-proc (lambda () proc)))) 

(define (memo-proc proc)
    (let ((already-run? false) (result false))
        (lambda ()
            (if (not already-run?)
                (begin (set! result (proc)) (set! already-run? true)
                                result)
                        result))))

(define false #f)
(define true #t)
(define (stream-ref s n)
    (if (= n 0)
        (stream-car s)
        (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
    (if (stream-null? s)
        the-empty-stream
        (cons-stream    (proc (stream-car s))
                        (stream-map proc (stream-cdr s)))))

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-enumerate-interval low high)
    (if (> low high)
        the-empty-stream
        (cons-stream low (stream-enumerate-interval (+ low 1) high))))

(define (cons-stream a b) (cons a (delay b)))

(define the-empty-stream '())

(define (stream-null? stream) (null? stream))

(define (display-line x) (newline) (display x))


(define (show x)

    (display-line x)
    x)

(define x
    (stream-map show (stream-enumerate-interval 0 10)))

(stream-ref x 5)