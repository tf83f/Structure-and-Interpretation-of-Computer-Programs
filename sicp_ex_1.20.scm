(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

; Normal order
;(gcd 206 40)

;(if (= 40 0)
;    206
;    (gcd 40 (remainder 206 40)))

;(gcd 40 (remainder 206 40))

;(if (= (remainder 206 40) 0)
;    40
;    (gcd (remainder 206 40)
;         (remainder 40 (remainder 206 40))))
; => +1

;(if (= 6 0)
;    40
;    (gcd (remainder 206 40)
;         (remainder 40 (remainder 206 40))))

;(gcd (remainder 206 40)
;     (remainder 40 (remainder 206 40)))

;(if (= (remainder 40 (remainder 206 40)) 0)
;    (remainder 206 40)
;    (gcd (remainder 40 (remainder 206 40))
;         (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
; => +1

;(if (= (remainder 40 6) 0)
;    (remainder 206 40)
;    (gcd (remainder 40 (remainder 206 40))
;         (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
; => +1

;(if (= 4 0)
;    (remainder 206 40)
;    (gcd (remainder 40 (remainder 206 40))
;         (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

;(gcd (remainder 40 (remainder 206 40))
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))

;(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0)
;    (remainder 40 (remainder 206 40))
;    (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
; => +4

;(if (= 2 0)
;    (remainder 40 (remainder 206 40))
;    (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))

;(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;     (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

;(if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0)
;    (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;    (gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) (remainder a  (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))
; => +7

;(if (= 0 0)
;    (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;    (gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) (remainder a  (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))

;(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
; => +4

;2

; TOTAL => 18 

; Application order 
; (gcd 206 40) => +1
; (gcd 40 (remainder 206 40)) 
; (gcd 40 6) => +1
; (gcd 6 (remainder 40 6)) 
; (gcd 6 4) => +1
; (gcd 4 (remainder 6 4)) 
; (gcd 4 2) => +1
; (gcd 2 (remainder 4 2)) 
; (gcd 2 0)  
; 2 => +1
; TOTAL => 5

; NOTE TO MYSELF
; => NORMAL ORDER : you only compute what you need. 
; So you need to compute only the condition for the if. 
; Then according to the outcome, you do the logic and you report for the next if (uncalculated value : chain of remainder) the values, 
;which do not need yet to be calculated (expect the one for the next if)

; => APPLICATIVE ORDER : everything need to be calculated. 
So you need to compute the test and the value of the outcomes.

