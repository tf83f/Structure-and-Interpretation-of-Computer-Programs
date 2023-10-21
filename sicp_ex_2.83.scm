(define (integer->rational  integer) (make-rational integer 1))

(define (rational->real rational)
    (make-real  (/ (* 1.0 (numer rational))
                    (denom rational))))

(define (real->complex real) (make-complex-from-real-imag real 0))

(put-coersion 'integer 'rational integer->rational) 

(put-coersion 'rational 'real rational->real) 

(put-coersion 'real 'complex real->complex) 

 (define (raise number) 
   (define tower '(integer rational real complex)) 
   (define (try tower) 
     (if (< (length tower) 2) 
         (error "Couldn't raise type" number) 
         (let ((current-type (car tower)) 
               (next-types (cdr tower)) 
               (next-type (cadr tower))) 
           (if (eq? (type-tag number) current-type) 
               ((get-coersion current-type next-type) number) 
               (try next-types))))) 
   (try tower)) 