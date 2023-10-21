; By using the * (instead of the square procedure) the interpreter will use applicative order
; which mean (expmod base (/ exp 2) m) will have to be evaluated twice.
; But if we use square then (expmod base (/ exp 2) m) will be evaluated only once.
; In that end it will double the work every time the branch of the procedure is called.