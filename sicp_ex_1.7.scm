

; for large numbers : 
; because the floating point representation can not encode all the real numbers (because it has a fixed number of bits)
; then (improve guess x) could not encode an improved guess such that abs(guess^2 - x ) < 0.001, 
; causing the procedure to keep trying to get a better guess even if it can't and never ending.

; for  small numbers :
; because we decided of a precision of 0.001, then we could be in the situation where this precision is too big (i.e x < precision)

(define (square x) (* x x))

; old (depends on x ): 

;(define (good-enough? guess x)
;    (< (abs (- (square guess) x)) 0.001))

; new (doesn't depend on x, only on the improvement of the guess )

(define (good-enough? previous-guess guess)
  (< (abs (/ (- guess previous-guess) guess)) 0.00000000001))

(define (sqrt-iter guess x)
  (if (good-enough? guess (improve guess x))
      guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(display (sqrt 1234567890123))
(newline)
(display (sqrt 12345678901234))
(newline)
(display (sqrt 0.00000000123))
(newline)