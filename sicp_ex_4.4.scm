(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))


(define (and? exp) (tagged-list? exp 'and))
(define (or? exp) (tagged-list? exp 'or))

(define (predicates exp) (cdr exp))
(define (first-predicate seq) (car seq))
(define (rest-predicates seq) (cdr seq))
(define (no-predicate? seq) (null? seq))

 (define (eval-and exp env) 
     (cond ((no-predicates? exp) true) 
           ((not (true? (eval (first-predicate exp)))) false) 
           (else (eval-and (rest-predicates exp) env)))) 

(define (and->if exp) (expand-and-predicates (predicates exp)))

 (define (expand-and-predicates predicates) 
     (if (no-predicates? predicates) 
         'true 
         (make-if (first-predicate predicates) 
                  (expand-predicates (rest-predicates predicates)) 
                  'false))) 

 (define (eval-or exp env) 
     (cond ((no-predicates? exp) false) 
           ((true? (eval (first-predicate exp))) true) 
           (else (eval-or (rest-predicates exp) env)))) 

(define (or->if exp) (expand-or-predicates (predicates exp)))

 (define (expand-or-predicates predicates) 
     (if (no-predicate? predicates) 
         'false 
         (make-if (first-predicate predicates) 
                 'true 
                 (expand-predicates (rest-predicates predicates))))) 
