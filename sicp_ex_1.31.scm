(define (product term a next b)
    (if (> a b)
        1
        (* (term a) (product term (next a) next b))))

(define (product-iter term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (* result (term a)))))
    (iter a 1))

(define (factorial a)
    (define (identity x) x)
    (define (add-one x) (+ x 1))
    (product identity 1 add-one a))

(define (factorial-iter a)
    (define (identity x) x)
    (define (add-one x) (+ x 1))
    (product-iter identity 1 add-one a))

(display (factorial 1))
(newline)
(display (factorial-iter 1))
(newline)
(display (factorial 2))
(newline)
(display (factorial-iter 2))
(newline)
(display (factorial 3))
(newline)
(display (factorial-iter 3))
(newline)
(display (factorial 4))
(newline)
(display (factorial-iter 4))
(newline)

(define (even? n) (= 0 (remainder n 2)))

(define (pi-term n) 
        (if (even? n) 
            (/ (+ n 2) (+ n 1)) 
            (/ (+ n 1) (+ n 2))))

(define (next-pi x) (+ x 1)) 

(define pi
    (* (product pi-term 1 next-pi 10000) 4.0))

(display pi)
(newline)