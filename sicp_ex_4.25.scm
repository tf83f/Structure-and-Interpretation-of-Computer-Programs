(define (unless condition usual-value exceptional-value) 
    (if condition exceptional-value usual-value))

(define (factorial n)
    (unless (= n 1)
            (* n (factorial (- n 1)))
            1))

(display (factorial 5))

; in applicative order, the call never end. Because even if (= n 1) is true
; we still will have to compute (factorial (- n 1)) without end 5 4 3 2 1 0 -1 ...

; in normal order, it will end. Because once we reach n = 1 we won't have to evaluate
; (factorial (- n 1)) and will compute the result my * our way up.