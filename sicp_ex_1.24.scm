(define (square a) (* a a))

(define (expmod base exp m)
    (cond   ((= exp 0) 1)
            ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
            (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
    (cond   ((= times 0) #t)
            ((fermat-test n) (fast-prime? n (- times 1)))
            (else #f)))

(define (prime? n) (fast-prime? n 12))

(define (runtime) (current-time))

(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

(define (even? n) (= (remainder n 2) 0))
(define (odd? n) (not (even? n)))

(define (search-for-primes start end)
  (if (even? start)
      (search-for-primes (+ 1 start) end)
      (cond ((> start end) (newline) (display "done"))
            (else (timed-prime-test start)
                  (search-for-primes (+ 2 start) end)))))


(search-for-primes 1000 1020)
(newline)
(search-for-primes 10000 10038)
(newline)
(search-for-primes 100000 100045)
(newline)
(search-for-primes 1000000 1000038)
(newline)