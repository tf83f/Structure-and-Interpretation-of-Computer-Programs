
(define f
    (let ((x 0))
        (lambda (y)
            (cond   ((> y x) (begin (set! x y) 0))
                    (else x)))))

;(display  (+ (f 0) (f 1)))
(newline)
(display  (+ (f 1) (f 0)))