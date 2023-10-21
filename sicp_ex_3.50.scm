
(define (stream-map proc . argstreams) 
    (if (null? (car argstreams))
        the-empty-stream
        (stream-cons
            (apply proc (map stream-car argstreams)) 
            (apply stream-map proc (map stream-cdr argstreams)))))