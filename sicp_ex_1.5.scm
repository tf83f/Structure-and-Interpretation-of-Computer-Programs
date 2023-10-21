(define (p) (p))

(define (test x y)
    (if (= x 0) 0 y))

(display (test 0 (p)))

;In the applicative order, we first need to evaluate the argument. 
;The procedure will never end because (p) will keep evaluating (calling) itself.
;    (test 0 (p))
;=>  (test 0 (p))
;=>  (test 0 (p))
;=>  ...

;In the normative order we "fully expand and then reduce". 
;The test will be run (#t) and will give back 0 without trying to evaluate (p).
;    (test 0 (p))
;=>  (if (= 0 0) 0 (p))
;=>  (if #t 0 (p))
;=> 0