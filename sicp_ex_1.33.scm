(define (filtered-accumulate combiner null-value term a next b filter)
    (define (filtered-term a)
        (if (filter a) 
            (term a) 
            null-value))
    (if (> a b)
        null-value
        (combiner (filtered-term a) (filtered-accumulate combiner null-value term (next a) next b filter))))

(define (square x) (* x x))

(define (divides? a b) (= (remainder b a) 0))

(define (find-divisor n test-divisor)
    (cond   ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n) (find-divisor n 2))

(define (prime? n) (= n (smallest-divisor n)))

(define (add-one x) (+ x 1))

(define (sum-of-squares-primes a b)
    (filtered-accumulate + 0 square a add-one b prime?))

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))



(define (product-of-relative-prime a)
    (define (relative-prime? i) (= (gcd i a) 1))
    (filtered-accumulate * 1 identity 1 add-one a relative-prime?))

(display (sum-of-squares-primes 2 10))
(newline)
(display (product-of-relative-prime 10))