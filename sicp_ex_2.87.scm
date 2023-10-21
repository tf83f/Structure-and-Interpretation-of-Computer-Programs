
(define (=zero? poly)
    (if (empty-termlist? poly)
        #t
        (if (=zero? (coeff (first-term poly)))
            (=zero? (rest-terms poly))
            #f)))
