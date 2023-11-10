(define (a-pythagorean-triple-between low high)
    (let ((i (an-integer-between low high)))
        (let ((j (an-integer-between i high)))
            (let ((k (an-integer-between j high)))
                (require (= (+ (* i i) (* j j)) (* k k)))
                (list i j k)))))

(define (an-element-of items)
    (require (not (null? items)))
    (amb (car items) (an-element-of (cdr items))))

(define (generate-element low high)
    (let loop ((current high) (result '()))
        (if (< current low)
            result
            (loop (- current 1) (cons current result)))))

(define (an-interger-between low high)  
    (an-element-of (generate-element low high))) 