(define (cube x) (* x x x))

(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a) (sum term (next a) next b))))

(define (integral f a b dx) 
    (define (add-dx x) (+ x dx))
    (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(define (simpson f a b n) 
    (define h (/ (- b a) n))
    (define (add-2h x) (+ x h h))
    (*  (/ h 3)
        (+  (f a)
            (* 2 (sum f (+ a h h) add-2h b))
            (* 4 (sum f (+ a h) add-2h b))
            (f b)))
  )


(display (integral cube 0 1 0.01))
(newline)
(display (simpson cube 0.0 1.0 100))
(newline)
(display (simpson cube 0.0 1.0 1000))
