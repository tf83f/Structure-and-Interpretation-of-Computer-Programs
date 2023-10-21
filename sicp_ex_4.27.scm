(define count 0)
(define (id x) (set! count (+ count 1)) x)

(define w (id (id 10))) ; it is the thunk that is bound to w, not the number 10.
(display count) ; 1 because that thunk is not forced until we call actual-value on w, and hence count has been incremented only once.
(newline)
(display w) ; 10
(newline)
(display count) ; 2