(define (square x) (* x x))

(define (sumOfSquares x y)
    (+  (square x) 
        (square y)))


(define (sumOfSquaresOfLargestTwo x y z)
    (cond   ((and (<= x y) (<= x z)) (sumOfSquares y z))
            ((and (<= y x) (<= y z)) (sumOfSquares x z))
            (else (sumOfSquares x y))))


(display (sumOfSquaresOfLargestTwo 1 2 3)) 
(newline)
 ; 13 
(display (sumOfSquaresOfLargestTwo 1 1 1))
(newline)
 ; 2 
(display (sumOfSquaresOfLargestTwo 1 2 2)) 
(newline)
 ; 8 
(display (sumOfSquaresOfLargestTwo 1 1 2)) 
(newline)
 ; 5 
(display (sumOfSquaresOfLargestTwo 1 4 3)) 
(newline)
 ; 25 

