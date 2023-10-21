(define (f g) (g 2))

(define (square x) (* x x))

(display (f square))
(newline)
(display (f (lambda (z) (* z (+ z 1)))))
(newline)
;(display (f f))
; The  f procedure will try to apply the argument 2 to the procedure defined as the arguement of f.
; Here (f f) f (the procedure) will try to apply the argument 2 to the f procedure (the argument of the first f).
; we then have (f 2) which is (2 2) and doesn't mean anything because 2 is of the wrong type (not a procedure)
; In summary :
;    => (f f)
;    => (f 2)
;    => (2 2)