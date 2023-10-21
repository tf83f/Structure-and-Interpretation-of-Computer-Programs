
 (define (make-frame origin edge1 edge2) 
   (list origin edge1 edge2)) 
 (define (frame-origin f) (car f)) 
 (define (frame-edge1 f) (cadr f)) 
 (define (frame-edge2 f) (caddr f)) 
  

 (define f (make-frame 1 2 3)) 
 (display (frame-origin f))
 (newline)
 (display (frame-edge1 f))
 (newline)
 (display (frame-edge2 f)) 
 (newline)

 (display (frame-origin f))
 (newline)
 (display (frame-edge1 f))
 (newline)
 (display (frame-edge2 f)) 
 (newline)
  