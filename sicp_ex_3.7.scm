(define (make-account balance password)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount)) balance)
            "Insufficient funds"))
    
    (define (deposit amount)
        (set! balance (+ balance amount)) balance)
    
    (define (dispatch p m)
        (cond   ((not (eq? p password)) (lambda(x) "Incorrect password" ))
                ((eq? m 'withdraw) withdraw)
                ((eq? m 'deposit) deposit)
                (else (error "Unknown request: MAKE-ACCOUNT" m))))
    dispatch)

(define (make-joint account password new-password)
    (define (dispatch p m)
        (cond   ((not (eq? p new-password)) (lambda(x) "Incorrect password" ))
                ((eq? m 'withdraw) withdraw)
                ((eq? m 'deposit) deposit)
                (else (error "Unknown request: MAKE-ACCOUNT" m))))

    (define (withdraw amount) ((account password 'withdraw) amount))
    (define (deposit amount) ((account password 'deposit) amount))
    
    (if (number? ((account password 'withdraw) 0))
        dispatch
        (lambda(x) "Incorrect password")))


(define peter-acc (make-account 100 'open-sesame))
(display ((peter-acc 'open-sesame 'withdraw) 40))
(newline)
(display ((peter-acc 'open-sesame 'deposit) 40))
(newline)
(display ((peter-acc 'some-other-password 'deposit) 50))
(newline)

(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))
(newline)
(display ((paul-acc 'rosebud 'withdraw) 40))
(newline)
(display ((paul-acc 'rosebud 'deposit) 40))
(newline)
(display ((paul-acc 'some-other-password 'deposit) 50))
(newline)
(newline)
