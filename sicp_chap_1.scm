(define (square x) 
    (* x x))

(define (sum-of-squares x y) 
    (+ 
        (square x) 
        (square y)))

(define (f a)
    (sum-of-squares 
        (+ a 1) 
        (* a 2)))

(define (abs x)
    (cond   ((> x 0) x)
            ((= x 0) 0)
            ((< x 0) (- x))))

(define (abs_2 x)
    (cond   ((< x 0) (-x))
            (else x)))

(define (abs_3 x)
    (if (< x 0)
        (- x)
        x))

(define (>= x y) 
    (or 
        (< x y)
        (= x y)))

(define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))

(define (improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
    (sqrt-iter 1.0 x))


(define (sqrt_1 x)
    (define (good-enough? guess x)
        (< (abs (- (square guess) x)) 0.001))
    (define (improve guess x)
        (average guess (/ x guess)))
    (define (sqrt-iter guess x)
        (if (good-enough? guess x)
            guess
            (sqrt-iter (improve guess x) x)))
    (sqrt-iter 1.0 x))

(define (sqrt_2 x)
    (define (good-enough? guess) 
        (< (abs (- (square guess) x)) 0.001))
    (define (improve guess)
        (average guess (/ x guess)))
    (define (sqrt-iter guess)
        (if (good-enough? guess)
            guess
            (sqrt-iter (imrpove guess))))
    (sqrt-iter 1.0))

(define (factorial_recur n)
    (if (= n 1)
        1
        (* n (factorial_recur (- n 1)))))

(define (fact-iter product counter max-count)
    (if (> counter max-count)
        product
        (fact-iter (* counter product) (+ counter 1) max-count)))

(define (factorial n)
    (define (iter product counter)
        (if (> counter n)
            product
            (iter (* counter product) (+ counter 1))))
    (iter 1 1))

(define (factorial n)
    (fact-iter 1 1 n))

(define (fib-recur n)
    (cond   ((= n 0) 0)
            ((= n 1) 1)
            (else (+    (fib-recur (- n 1))
                        (fib-recur (- n 2))))))

(define (fib-iter a b count)
    (if (= count  0)
        b
        (fib-iter (+ a b) a (- count 1))))

(define (fib  n)
    (fib-iter 1 0 n))

(define (count-change amount) (cc amount 5))

(define (cc amount kinds-of-coins)
    (cond   ((= amount 0) 1)
            ((or (< amount 0) (= kinds-of-coins 0)) 0)
            (else (+    (cc amount (- kinds-of-coins 1))
                        (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
    (cond   ((= kinds-of-coins 1) 1) 
            ((= kinds-of-coins 2) 5)
            ((= kinds-of-coins 3) 10)
            ((= kinds-of-coins 4) 25)
            ((= kinds-of-coins 5) 50)))


(define (expt_r b n)
    (if (= n 0)
        1
        (* b expt_r b (- n 1))))

(define (expt b n)
    (expt-iter b n 1))

(define (expt-iter b counter product)
    (if     (= counter 0)
            product
            (expt-iter b (- counter 1) (* b product))))

(define (even? n)
    (= (remainder n 2) 0))

(define (fast-expt b n)
    (cond   ((= n 0) 1)
            ((even? n) (square (fast-expt b (/ n 2))))
            (else (* b  (fast-expt b (- n 1))))))

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

(define (divides? a b) (= (remainder b a) 0))

(define (find-divisor n test-divisor)
    (cond   ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n) (find-divisor n 2))

(define (prime? n) (= n (smallest-divisor n)))

(define (expmod base exp m)
    (cond   ((= exp 0) 1)
            ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
            (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
    (cond   ((= times 0) true)
            ((fermat-test n) (fast-prime? n (- times 1)))
            (else false)))

(define (cube x) (* x x x))

(define (inc n) (+ n 1))

(define (identity x) x)

(define (sum-integers a b)
    (sum identity a inc b))

(define (sum-cubes a b)
    (sum cube a inc b))

(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a) (sum term (next a) next b))))

(define (pi-sum a b)
    (define (pi-term x)
        (/ 1.0 (* x (+ x 2))))
    (define (pi-next x) (+ x 4))
    (sum pi-term a pi-next b))

(define (integral f a b dx) 
    (define (add-dx x) (+ x dx))
    (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(define (pi-sum-lambda a b)
    (sum    (lambda (x) (/ 1.0 (* x (+ x 2)))) 
            a
            (lambda (x) (+ x 4))
            b))

(define (integral-lambda f a b dx) 
    (* (sum f (+ a (/ dx 2.0)) (lambda (x) (+ x dx)) b) dx))   


(define (f x y)
    (define (f-helper a b)
        (+  (* x (square a))
            (* y b)
            (* a b)))
    (f-helpter  (+ 1 (* x y))
                (- 1 y))) 

(define (f-let x y)
    (let    ((a (+ 1 (* x y)))
            (b (- 1 y)))
    (+  (* x (square a))
        (* y b)
        (* a b))))  

(define (close-enough? x y) (< (abs (- x y)) 0.001))

(define (search f neg-point pos-point)
    (   let ((midpoint (average neg-point pos-point)))
        (if (close-enough? neg-point pos-point)
            midpoint
            (let ((test-value (f midpoint)))
                (cond   ((positive? test-value) (search f neg-point midpoint))
                        ((negative? test-value) (search f midpoint pos-point))
                        (else midpoint))))))

(define (half-interval-method f a b)
    (let    ((a-value (f a))
            (b-value (f b)))
        (cond   ((and (negative? a-value) (positive? b-value)) (search f a b))
                ((and (negative? b-value) (positive? a-value)) (search f b a))
                (else (error "Values are not of opposite sign" a b)))))

(define tolerance 0.0001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))

(define (sqrt_improved x) (fixed-point (lambda (y) (average y (/ x y))) 1.0))

(define (average-damp f)
    (lambda (x) (average  x (f x))))

(define (cube-root x)
    (fixed-point (average-damp (lambda (y) (/ x (square y)))) 1.0))

(define dx 0.00001)

(define (deriv g) (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define (newton-transform g)
    (lambda (x) (-  x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess))

(define (sqrt-newton x)
    (newtons-method (lambda (y)  (- (square y x)) 1.0)))

;(display ((deriv cube)  5))
