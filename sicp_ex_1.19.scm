; Apply T once :
; a' = qb +qa + pa = (p + q)a + bq
; b' = qa + pb

; Apply T a second time :
; a" = qb' +qa' + pa' = (p + q)a' + b'q = ... = (p^2 + 2pq + 2q^2)a + (2pq + q^2)b
; b" = qa' + pb' = ... = (2pq + q^2)a + (p^2 + q^2)b

; Hence :
; p' = p^2 + q^2
; q' = 2pq + q^2


(define (square x) (* x x)) 


(define (fib n) 
   (fib-iter 1 0 0 1 n)) 
 (define (fib-iter a b p q count) 
   (cond ((= count 0) b) 
         ((even? count) 
          (fib-iter a 
                    b 
                    (+ (square p) (square q)) 
                    (+ (* 2 p q) (square q)) 
                    (/ count 2))) 
         (else (fib-iter (+ (* b q) (* a q) (* a p)) 
                         (+ (* b p) (* a q)) 
                         p 
                         q 
                         (- count 1))))) 
  

(display (fib 0))
(newline)

(display (fib 1))
(newline)

(display (fib 2))
(newline)

(display (fib 3))
(newline)


(display (fib 34))
(newline)
