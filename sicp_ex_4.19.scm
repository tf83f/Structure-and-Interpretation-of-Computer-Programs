(let ((a 1)) 
    (define (f x)
        (define b (+ a x)) 
        (define e 5)
        (+ e b))
    (display (f 10)))


; (ben) sequential approach : it does make sense : 16 if first compute b, then a
; Alyssa view is what we get with guile scheme (error, we need to change the "seccond a with e to get ben answer)
; Eva  suppose a real simulatenous declaration, but it looks impossible  in reality (see below)

(let ((a 1))
    (define (f x)
        (let ((b '*unassigned*) (a '*unassigned*))
            (set! b (+ a x))
            (set! a 5)
            (+ a b)))
    (display (f 10)))

; conclusion in theory Alyssa is correct, but in reality we would certainly have a program that behave like Ben's description.

