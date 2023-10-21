
;(define (first-denomination denominations) (car denominations)) 
;(define (except-first-denomination denominations) (cdr denominations)) 
;(define (no-more? denominations) (null? denominations)) 
  
(define no-more? null?) 
(define except-first-denomination cdr) 
(define first-denomination car) 

 (define (cc amount denominations) 
   (cond    ((= amount 0) 1) 
            ((or (< amount 0) (no-more? denominations)) 0) 
            (else (+    (cc amount (except-first-denomination denominations)) 
                        (cc (- amount (first-denomination denominations))denominations))))) 
  
(define (timed-cc amount coin-values)
  (let ((start-time (current-time)))
    (let ((result (cc amount coin-values)))
      (let ((end-time (current-time)))
        (- end-time start-time)))))

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))
(define uk-coins_reversed (list 0.5 1 2 5 10 20 50 100))


;(display (cc 100 us-coins))
(newline)
;(display (cc 100 uk-coins))
(newline)

(display  (timed-cc 100 uk-coins) )
(newline)
(display (timed-cc 100 (reverse uk-coins_reversed)))
(newline)
(display (timed-cc 100 (reverse uk-coins)))

