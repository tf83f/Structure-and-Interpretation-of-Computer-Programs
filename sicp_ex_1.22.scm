(define (square a) (* a a))

(define (divides? a b) (= (remainder b a) 0))

(define (find-divisor n test-divisor)
    (cond   ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n) (find-divisor n 2))

(define (prime? n) (= n (smallest-divisor n)))

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