

(define (new-if predicate then-clause else-clause)
    (cond   (predicate then-clause)
            (else else-clause)))

(define (sqrt-iter guess x)
    (new-if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))

; using the applicative order and noting that (new-if) is a function and not a special form,  
; we can see that predicate (good-enough?), then-clause (guess) and else-clause  (sqrt-iter (improve guess x) x) have to be evaluated before applying the procedure.
; However else-clause (sqrt-iter (improve guess x) x) will call itself recursivel, creating an infinite loop.