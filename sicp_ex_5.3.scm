     (controller test-b
                    (test (op =) (reg b) (const 0))
                    (branch (label gcd-done))
                    (assign t (reg a))
                  rem-loop
                    (test (op <) (reg t) (reg b))
                    (branch (label rem-done))
                    (assign t (op -) (reg t) (reg b))
                    (goto (label rem-loop))
                  rem-done
                    (assign a (reg b))
                    (assign b (reg t))
                    (goto (label test-b))
gcd-done)

(controller 
    (assign x (op read))
    (assign guess (const 1.0))

  good-enough
    (assign temp (op *) (reg x) (reg x))
    (assign temp (op -) (reg temp) (reg guess))
    (test (op >) (reg temp) (const 0.0))
    (branch (label iter))
    (assign temp (op -) (const 0) (reg temp))
  
  iter
    (test (op <) (reg temp) (const 0.001))
    (branch (label done))

  improve
    (assign temp (op /) (reg x) (reg guess))
    (assign guess (op +) (reg guess) (reg temp))
    (assign guess (op /) (reg guess) (const 2))
    (branch (label good-enough))
  



    done)