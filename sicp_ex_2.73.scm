(define (variable? x) (symbol? x)) 

(define (same-variable? x y) (and (variable? x) (variable? y) (eq? x y))) 

(define (deriv exp var)
    (cond   ((number? exp) 0)
            ((variable? exp) (if (same-variable? exp var) 1 0))
            (else ((get 'deriv (operator exp)) (operands exp) var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

; a) Because number? and variable? are simply predicate without any tags.

(define table (list )) 

(define (put op type proc) 
  (set! table (append table (list (list op type proc)))) 
  ) 

(define (get op type) 
  (define (search op type t) 
   (cond ((null? t) #f) 
    ((and (eqv? (caar t) op) (eqv? (cadar t) type)) 
         (caddar t) 
    ) 
    (else (search op type (cdr t))) 
   ) 
  ) 
  (search op type table) 
  ) 

(define (install-sum-package) 

  (define (addend s) (car s)) 
  
  (define (augend s) (cadr s)) 
  
  (define (make-sum a b) 
    (cond 
        ((eq? a 0) b) 
        ((eq? b 0) a) 
        ((and (number? a) (number? b)) (+ a b)) 
        (else (list '+ a b)) 
        ) 
    ) 
  
  (define (deriv-sum s v) 
   (make-sum (deriv (addend s) v) (deriv (augend s) v)) 
  ) 
  
  (put 'deriv '+ deriv-sum) 
 'done) 

 (define (install-product-package) 
  (define (multiplier s) (car s)) 
  (define (multiplicand s) (cadr s)) 
  (define (make-product a b) 
   (cond 
    ((or (eq? a 0) (eq? b 0)) 0) 
    ((eq? a 1) b) 
    ((eq? b 1) a) 
    ((and (number? a) (number? b)) (* a b)) 
    (else '(* a b)) 
   ) 
  ) 
  (define (make-sum a b) 
   (cond 
    ((eq? a 0) b) 
    ((eq? b 0) a) 
    ((and (number? a) (number? b)) (+ a b)) 
    (else (list '+ a b)) 
   ) 
  ) 
  (define (deriv-product s v) 
   (make-sum 
    (make-product (deriv (multiplier s) v) (multiplicand s) ) 
    (make-product (multiplier s) (deriv (multiplicand s) v)) 
   ) 
  ) 
  (put 'deriv '* deriv-product) 
 'done) 

 (define (install-product-package) 
  (define (multiplier s) (car s)) 
  (define (multiplicand s) (cadr s)) 
  (define (make-product a b) 
   (cond 
    ((or (eq? a 0) (eq? b 0)) 0) 
    ((eq? a 1) b) 
    ((eq? b 1) a) 
    ((and (number? a) (number? b)) (* a b)) 
    (else '(* a b)) 
   ) 
  ) 
  (define (make-sum a b) 
   (cond 
    ((eq? a 0) b) 
    ((eq? b 0) a) 
    ((and (number? a) (number? b)) (+ a b)) 
    (else (list '+ a b)) 
   ) 
  ) 
  (define (deriv-product s v) 
   (make-sum 
    (make-product (deriv (multiplier s) v) (multiplicand s) ) 
    (make-product (multiplier s) (deriv (multiplicand s) v)) 
   ) 
  ) 
  (put 'deriv '* deriv-product) 
 'done) 

(define (install-product-package) 
  
  (define (multiplier s) (car s)) 
  
  (define (multiplicand s) (cadr s)) 
  
  (define (make-product a b) 
   (cond 
    ((or (eq? a 0) (eq? b 0)) 0) 
    ((eq? a 1) b) 
    ((eq? b 1) a) 
    ((and (number? a) (number? b)) (* a b)) 
    (else '(* a b)) 
   ) 
  ) 
  (define (make-sum a b) 
   (cond 
    ((eq? a 0) b) 
    ((eq? b 0) a) 
    ((and (number? a) (number? b)) (+ a b)) 
    (else (list '+ a b)) 
   ) 
  ) 
  (define (deriv-product s v) 
   (make-sum 
    (make-product (deriv (multiplier s) v) (multiplicand s) ) 
    (make-product (multiplier s) (deriv (multiplicand s) v)) 
   ) 
  ) 
  (put 'deriv '* deriv-product) 
 'done) 

(install-sum-package) 
(install-product-package) 

(display (deriv '(+ (* x 3) (* y x)) 'x))
(newline)
(display (deriv '(* 3 x) 'x))
