(define (estimate-integral P x1 x2 y1 y2 trials)
    (*  (monte-carlo trials (lambda () (P x1 x2 y1 y2))) 4.0))
       

(define (random-in-range low high)
    (let ((range (- high low))) (+ low (random range))))

(define (circle-predicate x1 x2 y1 y2)
    (let    ((x (random-in-range x1 x2))
            (y (random-in-range y1 y2)))
        (<= (+  (* (- x 5) (- x 5)) 
                (* (- y 7) (- y 7))) 
            9)))

(define (monte-carlo trials expirement)
    (define (iter trials-remaining trials-passed)
        (cond   ((= trials-remaining 0) (/ trials-passed trials))
                ((expirement) (iter (- trials-remaining 1) (+ trials-passed 1)))
                (else (iter (- trials-remaining 1) trials-passed))))
    (iter trials 0))

(display (estimate-integral circle-predicate 2.0 8.0 4.0 10.0 100000))