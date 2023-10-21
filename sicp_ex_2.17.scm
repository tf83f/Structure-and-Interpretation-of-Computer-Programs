(define (last-pair items)
    (if (null? (cdr items))
        ;(car items) ; gives back only the object : 34
        items ; gives a list of one element : (34)
        (last-pair (cdr items))))

(display (last-pair (list 23 72 149 34)))