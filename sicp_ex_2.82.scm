
(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                    (let ((coercion-list (get-coercion-list type-tags)))
                        (if coercion-list    
                            (apply-generic op (map coercion-list args))
                            (error "No method for these types" list op type-tags)))))))

(define (get-coercion-list type-tags)
    (define (coercion-iter type-ref list-type list-coercion)
        (if (null? list-type)
            list-coercion
            (if (get-coercion type-ref (car list-type))
                (coercion-iter type-ref (cdr list-type) (append (get-coercion type-ref (car list-type)) list-coercion))
                #f)))
    
    (define (control-iter type-to-try list-type)
        (if (null? type-to-try)
            #f
            (if (coercion-iter (car type-to-try) list-type '())
                (coercion-iter (car type-to-try) list-type '())
                (control-iter (cdr type-to-try) list-type))))
                
                
    (control-iter type-tags type-tags))