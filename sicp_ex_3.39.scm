
;P1a : (* x x)
;P1b : P1a -> x

;P2a : (+ x 1)
;P2b : P2a -> x

;Constraints :
;    -> P1a happens before P1b
;    -> P2a happens before P2b
;    -> P1a and P2 (a and b) are serialized. 
;    Thus P1a can't happen between P2a and P2b but P1b can.

;P1a P1b P2a P2b --> (* 10 10) 100->x (+ 100 1) 101->x : 101
;P2a P2b P1a P1b --> (+ 10 1) 11->x (* 11 11) 121->x : 121
;P1a P2a P1b P2b --> (* 10 10) (+ 10 1) 100->x 11->x : 11
;P1a P2a P2b P1b --> (* 10 10) (+ 10 1) 11->x 100->x : 100