(define false #f)

(define (lookup key table)
    (let ((record (assoc key (cdr table))))
        (if record
            (cdr record)
            false)))

(define (assoc key records)
    (cond ((null? records) false)
        ((equal? key (caar records)) (car records)) 
        (else (assoc key (cdr records)))))

(define (insert! key value table)
    (let ((record (assoc key (cdr table))))
        (if record
            (set-cdr! record value) 
            (set-cdr! table
                            (cons (cons key value)
                                    (cdr table)))))
            'ok)

(define (make-table)
  (list '*table*))

 (define (table? t) 
   (and (pair? t) (eq? '*table* (car t)))) 
  
 (define (lookup-generic table key . rest-of-keys) 
   (let ((subtable-or-record (lookup key table))) 
     (cond ((not subtable-or-record) false) 
           ((null? rest-of-keys) subtable-or-record) 
           ((table? subtable-or-record) (apply lookup-generic subtable-or-record rest-of-keys)) 
           (else (error "LOOKUP-GENERIC key is not a subtable" key subtable-or-record))))) 
  
 (define (insert-generic! table value key . rest-of-keys) 
   (if (null? rest-of-keys) ; on the last key 
       (insert! key value table) 
       (let ((subtable-or-record (lookup key table))) 
         (if (table? subtable-or-record) 
             (apply insert-generic! subtable-or-record value rest-of-keys) 
             (let ((new-subtable (make-table))) 
               (insert! key new-subtable table) 
               (apply insert-generic! new-subtable value rest-of-keys)))))) 

(define t (make-table))
(insert-generic! t 'value1 1 2 3 4)
(display (lookup-generic t 1 2 3 4))
(newline)
(insert-generic! t 'value2 2 3)
(display (lookup-generic t 2 3))
(newline)