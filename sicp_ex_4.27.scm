(define env the-global-environment) 
(actual-value '(define count 0) env) 
(actual-value '(define (id x) (set! count (+ count 1)) x) env) 
(actual-value '(define w (id (id 10))) env) 

it is the thunk that is bound to w, not the number 10.
(actual-value 'count env) ; 1 because that thunk is not forced until we call actual-value on w, and hence count has been incremented only once.
(newline)
(actual-value 'w env) ; 10 return 10 because we use the actual-value. if just use eval we would get the thunk
(newline)
 (actual-value 'count env) ; 2