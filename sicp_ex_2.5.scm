(define (my_exp base n)
    (define (iter_exp total n)
        (cond ((> n 0) (iter_exp (* total base) (- n 1)))
                (else total)))
   (iter_exp 1 n))

(define (my_modulo base n)
    (define (iter base total)
        (if (= (remainder base n) 0) (iter (/ base n) (+ total 1)) total))
    (iter base 0))

(define (my_cons a b)
    (* (my_exp 2 a) (my_exp 3 b)))

(define (my_car z) (my_modulo z 2))
(define (my_cdr z) (my_modulo z 3))

(display (my_cons 13 4))
(newline)
(display (my_car(my_cons 13 4)))
(newline)
(display (my_cdr(my_cons 13 4)))
(newline)

