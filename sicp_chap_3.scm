(load "sicp_chap_1.scm")
(define balance 100)

(define (withdraw amount) 
    (if (>= balance amount)
        (begin (set! balance (- balance amount)) balance)
        "Insufficient funds"))


(define new-withdraw 
    (let ((balance 100))
        (lambda (amount)
            (if (>= balance amount)
                (begin (set! balance (- balance amount)) balance)
                "Insufficient funds"))))

(define (make-withdraw balance)
    (lambda (amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount)) balance)
            "Insufficient funds")))

(define (make-account balance)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount)) balance)
            "Insufficient funds"))
    
    (define (deposit amount)
        (set! balance (+ balance amount)) balance)
    
    (define (dispatch m)
        (cond   ((eq? m 'withdraw) withdraw)
                ((eq? m 'deposit) deposit)
                (else (error "Unknown request: MAKE-ACCOUNT" m))))
    dispatch)

(define random-init 1)

(define rand (let ((x random-init))
    (lambda ()
        (set! x (rand-update x))
        x)))

(define (estimate-pi trials)
    (sqrt (/ 6 (monte-carlo trials cesaro-test))))

(define (cesaro-test)
    (= (gcd (rand) (rand)) 1))

(define (monte-carlo trials expirement)
    (define (iter trials-remaining trials-passed)
        (cond   ((= trials-remaining 0) (/ trials-passed trials))
                ((expirement) (iter (- trials-remaing 1) (+ trials-passed 1)))
                (else (iter (- trials-remaining 1) trials-passed))))
    (iter trials 0))

(define (random-gcd-test trials initial-x)
    (define (iter trials-remaining trials-passed x)
        (let ((x1 (rand-update x)))
            (let ((x2 (rand-update x1)))
                (cond   ((= trials-remaining 0) (/ trials-passed trials))
                        ((= (gcd x1 x2) 1) (iter (- trials-remaining 1) (+ trials-passed 1) x2))
                        (else (iter (- trials-remaining 1) trials-passed x2))))))
    (iter trials 0 initial-x))

(define (set-to-wow! x) (set-car! (car x) 'wow) x)


(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))
(define (empty-queue? queue) (null? (front-ptr queue)))
(define (make-queue) (cons '() '()))

(define (front-queue queue)
    (if (empty-queue? queue)
        (error "FRONT called with an empty queue" queue)
        (car (front-ptr queue))))

(define (insert-queue! queue item)
    (let ((new-pair (cons item '())))
        (cond   ((empty-queue? queue) (set-front-ptr! queue new-pair) (set-rear-ptr! queue new-pair) queue)
                (else (set-cdr! (rear-ptr queue) new-pair) (set-rear-ptr! queue new-pair) queue))))

(define (delete-queue! queue) 
    (cond ((empty-queue? queue)
        (error "DELETE! called with an empty queue" queue)) 
        (else (set-front-ptr! queue (cdr (front-ptr queue))) queue)))

(define (lookup key table)
    (let ((record (assoc key (cdr table))))
        (if record
            (cdr record)
            false)))

(define (assoc key records)
    (cond   ((null? records) false)
            ((equl? key (caar records)) (car records))
            (else (assoc key (cdr records)))))

(define (insert! key value table)
    (let ((records (assoc key (cdr table))))
        (if record
            (set-cdr! record value)
            (set-cdr! table (cons (cons key value) (cdr table)))))
    'ok)

(define (make-table)
    (list '*table*))

(define (lookup key-1 key-2 table)
    (let ((subtable (assoc key-1 (cdr table))))
        (if subtable 
            (let ((record (assocc key-2 (cdr subtable))))
                (if record
                    (cdr record)
                    false))
            false)))

(define (insert! key-1 key-2 value table)
    (let ((subtable (assoc key-1 (cdr table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
                (if record  
                    (set-cdr! record value)
                    (set-cdr! subtable
                                (cons   (cons key-2 value)
                                        (cdr subtable)))))
            (set-cdr! table
                    (cons (list key-1
                                (cons key-2 value))
                            (cdr table)))))
            'ok)

(define (make-table)
    (let ((local-table (list '*table*)))
        (define (lookup key-1 key-2) 
            (let ((subtable (assoc key-1 (cdr local-table)))) 
                (if subtable
                    (let ((record (assoc key-2 (cdr subtable))))
                        (if record 
                            (cdr record) 
                            false)) 
                    false)))
        (define (insert! key-1 key-2 value) 
            (let ((subtable (assoc key-1 (cdr local-table)))) 
                (if subtable
                    (let ((record (assoc key-2 (cdr subtable))))
                        (if record
                            (set-cdr! record value) 
                            (set-cdr! subtable
                                (cons (cons key-2 value)
                                  (cdr subtable)))))
                            (set-cdr! local-table
                                (cons (list key-1 (cons key-2 value))
                                    (cdr local-table)))))
                'ok)
        (define (dispatch m)
            (cond   ((eq? m 'lookup-proc) lookup)
                    ((eq? m 'insert-proc!) insert!)
                    (else (error "Unknown operation: TABLE" m))))
        dispatch))
        
(define operation-table (make-table)) 
(define get (operation-table 'lookup-proc)) 
(define put (operation-table 'insert-proc!))

(define (half-adder a b s c)
    (let ((d (make-wire)) (e (make-wire)))
        (or-gate a b d)
        (and-gate a b c)
        (inverter c e)
        (and-gate d e s)
        'ok))

(define (full-adder a b c-in sum c-out)
    (let ((s (make-wire)) (c1 (make-wire)) (c2 (make-wire)))
        (half-adder b c-in s c1)
        (half-adder a s sum c2)
        (or-gate c1 c2 c-out)
        'ok))

(define (inverter input output)
    (define (invert-input)
        (let ((new-value (logical-not (get-signal input))))
            (after-delay inverter-delay (lambda() (set-signal! output new-value)))))
    (add-action! input invert-input)  'ok)

(define (logical-not s)
    (cond   ((= s 0) 1)
            ((= s 1) 0)
            (else (error "Invalid signal" s))))


(define (and-gate a1 a2 output) 
    (define (and-action-procedure)
        (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
            (after-delay and-gate-delay (lambda () (set-signal! output new-value)))))
    (add-action! a1 and-action-procedure)
    (add-action! a2 and-action-procedure)
    'ok)

 (define (logical-and s1 s2) 
   (if (or (= s1 1) (= s2 1)) 
         1 
         0)) 
 
 (define (or-gate a1 a2 output) 
   (define (or-action-procedure) 
         (let ((new-value (logical-or (get-signal a1) (get-signal a2)))) 
           (after-delay or-gate-delay (lambda () (set-signal! output new-value))))) 
   (add-action! a1 or-action-procedure) 
   (add-action! a2 or-action-procedure)) 
 
 (define (logical-or s1 s2) 
   (if (or (= s1 1) (= s2 1)) 
         1 
         0)) 

(define (make-wire)
    (let ((signal-value 0) (action-procedures '()))
        (define (set-my-signal! new-value) 
            (if (not (= signal-value new-value))
                (begin (set! signal-value new-value) 
                    (call-each action-procedures)) 'done))
        (define (accept-action-procedure! proc)
            (set! action-procedures
                (cons proc action-procedures))
                (proc))
        (define (dispatch m)
            (cond   ((eq? m 'get-signal) signal-value)
                    ((eq? m 'set-signal!) set-my-signal!)
                    ((eq? m 'add-action!) accept-action-procedure!) (else (error "Unknown operation: WIRE" m))))
                dispatch))

(define (call-each procedures)
    (if (null? procedures) 
        'done
        (begin ((car procedures))
            (call-each (cdr procedures)))))

(define (get-signal wire) (wire 'get-signal)) 

(define (set-signal! wire new-value)
    ((wire 'set-signal!) new-value))

(define (add-action! wire action-procedure)
  ((wire 'add-action!) action-procedure))

(define (after-delay delay action)
    (add-to-agenda! (+ delay (current-time the-agenda))
                    action
                    the-agenda))

(define (propagate)
    (if (empty-agenda? the-agenda)
        'done
        (let ((first-item (first-agenda-item the-agenda)))
            (first-item)
            (remove-first-agenda-item! the-agenda)
            (propagate))))

(define (probe name wire)
    (add-action! wire   
                (lambda ()
                    (newline)
                    (display name) (display " ")
                    (display (current-time the-agenda))
                    (display " New-value = ")
                    (display (get-signal wire)))))


(define (make-time-segment time queue) (cons time queue))
(define (segment-time s) (car s))
(define (segment-queue s) (cdr s))

(define (make-agenda) (list 0))
(define (current-time agenda) (car agenda))
(define (set-current-time! agenda time) (set-car! agenda time))
(define (segments agenda) (cdr agenda))
(define (set-segments! agenda segments) (set-cdr! agenda segments))
(define (first-segment agenda) (car (segments agenda)))
(define (rest-segments agenda) (cdr (segments agenda)))
(define (empty-agenda? agenda) (null? (segments agenda)))

(define (add-to-agenda! time action agenda)
    (define (belongs-before? segments)
        (or (null? segments)
            (< time (segment-time (car segments)))))
    (define (make-new-time-segment time action)
        (let ((q (make-queue)))
            (insert-queue! q action)
            (make-time-segment time q)))
    (define (add-to-segments! segments)
        (if (= (segment-time (car segments)) time)
            (insert-queue! (segment-queue (car segments)) action)
            (let ((rest (cdr segments)))
                (if (belongs-before? rest)
                    (set-cdr! segments (cons (make-new-time-segment time action) (cdr segments)))
                    (add-to-segments! rest)))))
    (let ((segments (segments agenda)))
        (if (belongs-before? segments)
            (set-segments! agenda (cons (make-new-time-segment time action) segments))
            (add-to-segments! segments))))

(define (remove-first-agenda-item! agenda)
    (let ((q (segment-queue (first-segment agenda))))
        (delete-queue! q)
        (if (empty-queue? q)
            (set-segments! agenda (rest-segments agenda)))))

(define (first-agenda-item agenda)
    (if (empty-agenda? agenda)
        (error "Agenda is empty: FIRST-AGENDA-ITEM")
        (let ((first-seg (first-segment agenda)))
            (set-current-time! agenda (segment-time first-seg))
            (front-queue (segment-queue first-seg)))))

(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))


(half-adder input-1 input-2 sum carry)
(set-signal! input-1 1)
(set-signal! input-2 1)

(define (adder a1 a2 sum) 
    (define (process-new-value)
        (cond   ((and (has-value? a1) (has-value? a2)) 
                    (set-value! sum (+ (get-value a1) (get-value a2)) me))
                ((and (has-value? a1) (has-value? sum)) 
                    (set-value! a2 (- (get-value sum) (get-value a1)) me))
                ((and (has-value? a2) (has-value? sum))
                    (set-value! a1 (- (get-value sum) (get-value a2)) me)))) 
    
    (define (process-forget-value)
        (forget-value! sum me)
        (forget-value! a1 me)
        (forget-value! a2 me)
        (process-new-value))
    
    (define (me request)
        (cond   ((eq? request 'I-have-a-value) (process-new-value))
                ((eq? request 'I-lost-my-value) (process-forget-value))
                (else (error "Unknown request: ADDER" request)))) (connect a1 me)
    (connect a2 me)
    (connect sum me)
    me)

(define (inform-about-value constraint) (constraint 'I-have-a-value))

(define (inform-about-no-value constraint) (constraint 'I-lost-my-value))

(define (multiplier m1 m2 product) 
    (define (process-new-value)
        (cond   ((or (and (has-value? m1) (= (get-value m1) 0)) (and (has-value? m2) (= (get-value m2) 0)))
                    (set-value! product 0 me))
                ((and (has-value? m1) (has-value? m2))
                    (set-value! product (* (get-value m1) (get-value m2)) me))
                ((and (has-value? product) (has-value? m1)) 
                    (set-value! m2 (/ (get-value product) (get-value m1)) me))
                ((and (has-value? product) (has-value? m2)) (set-value! m1 (/ (get-value product) (get-value m2)) me)))) 
    (define (process-forget-value)
        (forget-value! product me)
        (forget-value! m1 me)
        (forget-value! m2 me)
        (process-new-value))
    
    (define (me request)
        (cond   ((eq? request 'I-have-a-value) (process-new-value))
                ((eq? request 'I-lost-my-value) (process-forget-value)) 
                (else (error "Unknown request: MULTIPLIER" request))))
    
    (connect m1 me)
    (connect m2 me)
    (connect product me)
    me)

(define (constant value connector)
    (define (me request) (error "Unknown request: CONSTANT" request))
    (connect connector me)
    (set-value! connector value me)
    me)

(define (probe name connector)
    (define (print-probe value)
        (newline) (display "Probe: ") (display name)
        (display " = ") (display value))
    (define (process-new-value)
        (print-probe (get-value connector)))
    (define process-forget-value (print-probe "?"))
    (define (me request)
        (cond   ((eq? request 'I-have-a-value) (process-new-value))
                ((eq? request 'I-lost-my-value) (process-forget-value))
                (else (error "Unknown request: PROBE" request))))
    (connect connector me)
    me)

(define false #f)
(define true #t)

(define (make-connector)

(let ((value false) (informant false) (constraints '()))
(define (set-my-value newval setter)
(cond ((not (has-value? me)) (set! value newval)
(set! informant setter) (for-each-except setter
                          inform-about-value
                          constraints))
        ((not (= value newval))
(error "Contradiction" (list value newval))) (else 'ignored)))
(define (forget-my-value retractor) (if (eq? retractor informant)
(begin (set! informant false) (for-each-except retractor
                              inform-about-no-value
                              constraints))
'ignored))
(define (connect new-constraint)
(if (not (memq new-constraint constraints)) (set! constraints
(cons new-constraint constraints))) (if (has-value? me)
      (inform-about-value new-constraint))
  'done)
(define (me request)
(cond ((eq? request 'has-value?)

(if informant true false))
((eq? request 'value) value)
((eq? request 'set-value!) set-my-value) ((eq? request 'forget) forget-my-value) ((eq? request 'connect) connect)
(else (error "Unknown operation: CONNECTOR"
request))))
me))


(define (for-each-except exception procedure list) 
    (define (loop items)
        (cond ((null? items) 'done)
            ((eq? (car items) exception) (loop (cdr items))) 
            (else (procedure (car items))
                        (loop (cdr items)))))
        (loop list))

(define (has-value? connector) (connector 'has-value?))
(define (get-value connector) (connector 'value))
(define (set-value! connector new-value informant) ((connector 'set-value!) new-value informant))
(define (forget-value! connector retractor) ((connector 'forget) retractor))
(define (connect connector new-constraint) ((connector 'connect) new-constraint))

(define C (make-connector)) 
(define F (make-connector))

(define (celsius-fahrenheit-converter c f) (let ((u (make-connector))
        (v (make-connector))
        (w (make-connector))
        (x (make-connector))
        (y (make-connector)))
    (multiplier c w u)
    (multiplier v x u)
    (adder v y f)
    (constant 9 w)
    (constant 5 x)
    (constant 32 y)
    'ok))

(define (make-account-and-serializer balance) 
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                    balance)
                "Insufficient funds"))
        (define (deposit amount)
            (set! balance (+ balance amount)) balance)
        (let ((balance-serializer (make-serializer))) 
            (define (dispatch m)
                (cond   ((eq? m 'withdraw) withdraw)
                        ((eq? m 'deposit) deposit)
                        ((eq? m 'balance) balance)
                        ((eq? m 'serializer) balance-serializer)
                        (else (error "Unknown request: MAKE-ACCOUNT" m))))
    dispatch))

(define (exchange account1 account2)
    (let ((difference   (-  (account1 'balance)
                            (account2 'balance))))
        ((account1 'withdraw) difference)
        ((account2 'deposit) difference)))

(define (deposit account amount)
    (let        ((s (account 'serializer))
                (d (account 'deposit)))
        ((s d) amount)))

(define (serialized-exchange account1 account2)
    (let    ((serializer1 (account1 'serializer))
            (serializer2 (account2 'serializer)))
        ((serializer1 (serializer2 exchange)) account1 account2)))

(define (make-serializer)
    (let ((mutex (make-mutex)))
        (lambda (p)
            (define (serialized-p . args)
                (mutex 'acquire)
                (let ((val (apply p args)))
                    (mutex 'release)
                    val))
                serialized-p)))

(define (make-mutex)
    (let ((cell (list false)))
        (define (the-mutex m) 
            (cond ((eq? m 'acquire)
                (if (test-and-set! cell) 
                    (the-mutex 'acquire))) ; retry
                ((eq? m 'release) (clear! cell))))
        the-mutex))

(define (clear! cell) (set-car! cell false))

(define (test-and-set! cell)
    (if (car cell) true (begin (set-car! cell true) false)))

(define (parallel-execute proc1 proc2)
  (let ((result1 #f)
        (result2 #f))
    (let ((thread1 (make-thread (lambda () (set! result1 (proc1))))))
      (let ((thread2 (make-thread (lambda () (set! result2 (proc2))))))
        (thread-wait thread1)
        (thread-wait thread2)
        (list result1 result2)))))

(define (cons-stream a b) (cons a (delay b)))

(define (stream-ref s n)
    (if (= n 0)
        (stream-car s)
        (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
    (if (stream-null? s)
        the-empty-stream
        (cons-stream    (proc (stream-car s))
                        (stream-map proc (stream-cdr s)))))

(define (stream-for-each proc s)
    (if (stream-null? s)
        'done
        (begin  (proc (stream-car s))
                (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
    (stream-for-each display-line s))

(define (display-line x) (newline) (display x))

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-enumerate-interval low high)
    (if (> low high)
        the-empty-stream
        (cons-stream low (stream-enumerate-interval (+ low 1) high))))

(define (stream-filter pred stream)
    (cond   ((stream-null? stream) the empty-stream)
            ((pred (stream-car stream))
            (cons-stream (stream-car stream)
                        (stream-filter
                        pred
                        (stream-cdr stream))))
            (else (stream-filter pred (stream-cdr stream)))))

(define (force delayed-object) (delayed-object))

(define (memo-proc proc)
    (let ((already-run? false) (result false))
        (lambda ()
            (if (not already-run?)
                (begin (set! result (proc)) (set! already-run? true)
                                result)
                        result))))

(define (integers-starting-from n)
    (cons-stream n (integers-starting-from (+ n 1))))

;(define integers (integers-starting-from 1))

(define (divisible? x y) (= (remainder x y) 0))

;(define no-sevens (stream-filter (lambda (x) (not (divisible? x 7))) integers))

(define (fibgen a b) (cons-stream a (fibgen b (+ a b))))

;(define fibs (fibgen 0 1))

(define (sieve stream)
    (cons-stream
        (stream-car stream)
        (sieve (stream-filter (lambda (x) (not (divisible? x (stream-car stream)))) (stream-cdr stream)))))

;(define primes (sieve (integers-starting-from 2)))

;(define ones (cons-stream 1 ones))

(define (add-streams s1 s2) (stream-map + s1 s2))

;(define integers (cons-stream 1 (add-streams ones integers)))

;(define fibs (cons-stream 0 (cons-stream 1 (add-streams (stream-cdr fibs) fibs))))

(define (scale-stream stream factor)
    (stream-map (lambda (x) (* x factor)) stream))

;(define double (cons-stream 1 (scale-stream double 2)))

;(define primes (cons-stream 2 (stream-filter prime? (integers-starting-from 3))))

(define (prime? n)
    (define (iter ps)
        (cond   ((> (square (stream-car ps)) n) true)
                ((divisible? n (stream-car ps)) false)
                (else (iter (stream-cdr ps)))))
    (iter primess))

(define (sqrt-improve guess x) (average guess (/ x guess)))

(define (sqrt-stream x)
    (define guesses 
        (cons-stream
            1.0
            (stream-map (lambda (guess) (sqrt-improve guess x)) guesses)))
    guesses)

(define (stream-null? stream) (null? stream))

(define (pi-summands n)
    (cons-stream    (/ 1.0 n) 
                    (stream-map - (pi-summands (+ n 2)))))

(define (partial-sums s) 
   (cons-stream (stream-car s) 
                (add-streams (partial-sums s) 
                             (stream-cdr s)))) 

(define pi-stream (scale-stream (partial-sums (pi-summands 1)) 4))

;(display-stream pi-streams)

(define (euler-transform s)
    (let    ((s0 (stream-ref s 0))
            ((s1 (stream-ref s 1))
            ((s2 (stream-ref s 2))
        (cons-stream    (- s2 (/ (square (- s2 s1)) (+ s0 (* -2 s1) s2)))
                        (euler-transform (stream-cdr s))))))))

(define (make-tableau transform s)
    (cons-stream s (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
    (stream-map stream-car (make-tableau transform s)))

(define (interleave s1 s2) (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (pairs s t) 
    (cons-stream
        (list (stream-car s) (stream-car t))
        (interleave
            (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t))
        (pairs (stream-cdr s) (stream-cdr t)))))

(define (integral integrand initial-value dt)
    (define int (cons-stream initial-value (add-streams (scale-stream integrand dt) int)))
    int)

(define (integral delayed-integrand initial-value dt)
    (define int
        (cons-stream
            initial-value
            (let ((integrand (force delayed-integrand)))
                (add-streams (scale-stream integrand dt) int))))
    int)

(define (solve f y0 dt)
    (define y (integral (delay dy) y0 dt))
    (define dy (stream-map f y))
    y)

(define random-numbers
    (cons-stream
        random-init
        (stream-map rand-update random-numbers)))

(define cesaro-stream
    (map-successive-pairs (lambda (r1 r2) (= (gcd r1 r2) 1)) random-numbers))

(define (map-successive-pairs f s)
    (cons-stream
        (f (stream-car s) (stream-car (stream-cdr s)))
            (map-successive-pairs f (stream-cdr (stream-cdr s)))))


(define (monte-carlo experiment-stream passed failed) (define (next passed failed)
    (cons-stream
     (/ passed (+ passed failed))
     (monte-carlo
(stream-cdr experiment-stream) passed failed))) (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
(next passed (+ failed 1)))) (define pi
(stream-map
(lambda (p) (sqrt (/ 6 p))) (monte-carlo cesaro-stream 0 0)))