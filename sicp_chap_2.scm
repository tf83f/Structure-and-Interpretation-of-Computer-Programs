(load "sicp_chap_1.scm")

(define (linear-combination a b x y)
    (+ (* a x) (* b y)))

(define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                (* (numer y) (denom x)))
                (* (denom x) (denom y))))

(define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                (* (numer y) (denom x)))
                (* (denom x) (denom y))))

(define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
    (* (denom x) (denom y)))) 

(define (div-rat x y)
    (make-rat (* (numer x) (denom y))
                (* (denom x) (numer y))))

(define (equal-rat? x y)
    (= (* (numer x) (denom y))
        (* (numer y) (denom x))))

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

(define nil '())

(define (make-rat n d) (let ((g (gcd n d)))
(cons (/ n g) (/ d g))))

(define (numer x) (car x))

(define (denom x) (cdr x))
  
(define (print-rat x) 
    (newline)
    (display (numer x)) 
    (display " / ") 
    (display (denom x)))


(define (cons_dispatch x y)
    (define (dispatch m)
        (cond   ((= m 0) x)
                ((= m 1) y)
                (else (error "Argument not 0 or 1 : CONS" m))))
    dispatch)

(define (car_dispatch z) (z 0))
(define (cdr_dispatch z) (z 1))

(define (add-interval x y)
    (make-interval  (+ (lower-bound x) (lower-bound y))
                    (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
    (let (  (p1 (* (lower-bound x) (lower-bound y)))
            (p2 (* (lower-bound x) (upper-bound y)))
            (p3 (* (upper-bound x) (lower-bound y)))
            (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y) (mul-interval
   x
   (make-interval (/ 1.0 (upper-bound y))
                  (/ 1.0 (lower-bound y)))))

(define (make-center-width c w)
    (make-interval (- c w) (+ c w)))


(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
(/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-interval a b) (cons a b)) 

(define (list-ref items n)
    (if (= n 0)
        (car items)
        (list-ref (cdr items) (- n 1))))

(define (length_r items)
    (if (null? items)
        0
        (+ 1 (length_r (cdr items)))))

(define (length items)
    (define (length-iter a count)
        (if (null? a)
            count
            (length-iter (cdr a) (+ 1 count))))
    (length-iter items 0))


(define odds (list 1 3 5 7))
(define squares (list 1 4 9 16 25))

(define (append list1 list2)
    (if (null? list1)
        list2
        (cons (car list1) (append (cdr list1) list2))))

(define nil '()) 

(define (map proc items)
    (if (null? items)
        nil 
        (cons   (proc (car items))
                (map proc (cdr items)))))

(define (scale-list items factor)
    (map (lambda (x) (* x factor)) items))

(define (count-leaves x) 
    (cond   ((null? x) 0)
            ((not (pair? x)) 1)
            (else (+    (count-leaves (car x))
                        (count-leaves (cdr x))))))

(define (scale-tree tree factor) 
    (cond   ((null? tree) nil)
            ((not (pair? tree)) (* tree factor))
            (else (cons     (scale-tree (car tree) factor)
                            (scale-tree (cdr tree) factor)))))

(define (scale-tree-map tree factor)
    (map (lambda (sub-tree)
                (if (pair? sub-tree)
                    (scale-tree-map sub-tree factor)
                    (* sub-tree factor))) tree))

(define (sum-odd-squares tree)
    (cond   ((null? tree) 0)
            ((not (pair? tree)) (if (odd? tree) (square tree) 0))
            (else (+    (sum-odd-squares (car tree))
                        (sum-odd-squares (cdr tree))))))

(define (fib-iter a b count)
    (if (= count  0)
        b
        (fib-iter (+ a b) a (- count 1))))

(define (fib  n)
    (fib-iter 1 0 n))

(define (even-fibs n)
    (define (next k)
        (if (> k n)
            nil
            (let ((f (fib k)))
                (if (even? f)
                    (cons f (next (+ k 1)))
                    (next (+ k 1))))))
    (next 0))

(define (filter predicate sequence) 
    (cond   ((null? sequence) nil)
            ((predicate (car sequence)) (cons (car sequence) (filter predicate (cdr sequence)))) 
            (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence) 
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
    (if (> low high)
        nil
        (cons low (enumerate-interval (+ low 1) high))))

(define (enumerate-tree tree)
    (cond   ((null? tree) nil)
            ((not (pair? tree)) (list tree))
            (else (append   (enumerate-tree (car tree))
                            (enumerate-tree (cdr tree))))))

(define (sum-odd-squares tree)
    (accumulate
        + 0 (map square (filteer odd? (enumerate-tree tree)))))

(define (even-fibs n)
    (accumulate 
        cons
        nil (filter even? (map fib (enumerate-interval 0 n)))))

(define (square x) (* x x))

(define (list-fib-squares n) 
    (accumulate
    cons
    nil
    (map square (map fib (enumerate-interval 0 n)))))

(define (product-of-squares-of-odd-elements sequence) 
    (accumulate * 1 (map square (filter odd? sequence))))

(define (salary-of-highest-paid-programmer records)
    (accumulate max 0 (map salary (filter programmer? records))))

(define (flatmap proc seq)
    (accumulate append nil (map proc seq)))

(define (prime-sum? pair)
    (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
(list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n) 
    (map make-pair-sum
        (filter prime-sum? (flatmap 
                                (lambda (i)
                                    (map (lambda (j) (list i j)) 
                                        (enumerate-interval 1 (- i 1))))
                                    (enumerate-interval 1 n)))))

(define (permutations s)
    (if (null? s)
        (list nil)
        (flatmap (lambda (x) 
                    (map (lambda (p) (cons x p))
                            (permuations (remove x s)))) 
                    s)))

(define (remove item sequence)
    (filter (lambda (x) (not (= x item))) sequence))

(define (beside painter1 painter2)
    (let ((split-point (make-vect 0.5 0.0)))
        (let ((paint-left (transform-painter
                painter1
                (make-vect 0.0 0.0)
                split-point
                (make-vect 0.0 1.0)))
            (paint-right
            (transform-painter
                painter2
                split-point
                (make-vect 1.0 0.0)
                (make-vect 0.5 1.0))))
        (lambda (frame) (paint-left frame) (paint-right frame)))))

;(define wave2 (beside wave (flip-vert wave)))
;(define wave4 (below wave2 wave2))

(define (flipped-pairs painter)
    (let ((painter2 (beside painter (flip-vert painter))))
        (below painter2 painter2)))

;(define wave4 (flipped-pairs wave))

(define (right-split painter n)
    (if (= n 0)
        painter
        (let ((smaller (right-split painter (- n 1))))
            (beside painter (below smaller smaller)))))

(define (up-split painter n) 
   (if (= n 0) 
       painter 
       (let ((smaller (up-split painter (- n 1)))) 
         (below painter (beside smaller smaller))))) 

(define (corner-split painter n) 
    (if (= n 0)
        painter
        (let    ((up (up-split painter (- n 1))) 
                (right (right-split painter (- n 1))))
            (let ((top-left (beside up up))
                    (bottom-right (below right right)) 
                    (corner (corner-split painter (- n 1))))
                (beside (below painter top-left)
                  (below bottom-right corner))))))

(define (square-limit painter n)
    (let ((quater (corner-split painter n)))
        (let ((half (beside (flip-horiz quarter) quarter)))
            (below (flip-vert half) half))))

(define (square-of-four tl tr bl br)
    (lambda (painter)
        (let    ((top (beside (tl painter) (tr painter)))
                 (bottom (beside (bl painter) (br painter))))
            (below bottom top))))

(define (flipped-pairs painter)
    (let ((combine4 (square-of-four identity flip-vert identity flip-vert)))
    (combine4 painter)))

(define (square-limit painter n)
    (let ((combine4 (square-of-four flip-horiz identity rotate180 flip-vert)))
        (combine4 (corner-split painter n))))

(define (frame-coord-map frame)
    (lambda (v)
        (add-vect 
            (origin-frame frame)
            (add-vect
                (scale-vect (xcor-vect v) (edge1-frame frame))
                (scale-vect (ycor-vect v) (edge2-frame frame))))))

(define (segments->painter segment-list)
    (lambda (frame)
        (for-each
            (lambda (segment)
                (draw-line)
                    ((frame-coord-map frame)
                        (start-segment segment))
                    ((frame-coord-map frame)
                        (end-segment segment))))
                segment-list))

(define (transform-painter painter origin corner1 corner2)
    (lambda (frame)
        (let ((m (frame-coord-map frame)))
            (let ((new-origin (m origin)))
                (painter    (make-frame
                            new-origin
                            (sub-vect (m corner1) new-origin)
                            (sub-vect (m corner2) new-origin)))))))

(define (flip-vert painter)
    (transform-painter painter (make-vect 0.0 1.0) (make-vect 1.0 1.0) (make-vect 0.0 0.0)))

(define (shrink-to-upper-right painter) (transform-painter
   painter (make-vect 0.5 0.5)
   (make-vect 1.0 0.5) (make-vect 0.5 1.0)))

(define (rotate90 painter) (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (squash-inwards painter) (transform-painter painter
                     (make-vect 0.0 0.0)
                     (make-vect 0.65 0.35)
                     (make-vect 0.35 0.65)))

(define (memq item x)
    (cond   ((null? x) #f)
            ((eq? item (car x)) x)
            (else (memq item (cdr x)))))


(define (deriv exp var) 
    (cond   ((number? exp) 0)
            ((variable? exp) (if (same-variable? exp var) 1 0)) 
            ((sum? exp) (make-sum   (deriv (addend exp) var)
                                    (deriv (augend exp) var)))
            ((product? exp)
                (make-sum
                    (make-product (multiplier exp)
                                    (deriv (multiplicand exp) var))
                    (make-product (deriv (multiplier exp) var)
                                    (multiplicand exp))))
                (else (error "unknown expression type: DERIV" exp))))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))


(define (make-sum a1 a2) 
    (cond   ((=number? a1 0) a2) ((=number? a2 0) a1)
            ((and (number? a1) (number? a2)) (+ a1 a2))
            (else (list '+ a1 a2))))

(define (=number? exp num) (and (number? exp) (= exp num)))

(define (make-product m1 m2)
    (cond   ((or (=number? m1 0) (=number? m2 0)) 0)
            ((=number? m1 1) m2)
            ((=number? m2 1) m1)
            ((and (number? m1) (number? m2)) (* m1 m2))
            (else (list '* m1 m2))))

(define (sum? x) (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x) (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

(define (adjoin-set x set)
    (cond   ((null? set) (make-tree x '() '()))
            ((= x (entry set)) set)
            ((< x (entry set)) (make-tree (entry set) (adjoin-set x (left-branch set)) (right-branch set)))
            ((> x (entry set)) (make-tree (entry set) (left-branch set) (adjoin-set x (right-branch set))))))

(define (intersection-set set1 set2)
    (if (or (null? set1) (null? set2))
        '()
        (let ((x1 (car set1)) (x2 (car set2)))
            (cond   ((= x1 x2) (cons x1 (intersection-set (cdr set1) (cdr set2))))
                    ((< x1 x2) (intersection-set (cdr set1) set2))
                    ((< x2 x1) (intersection-set set1 (cdr set2)))))))

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right) (list entry left right))

(define (element-of-set? x set)
    (cond   ((null? set) false)
            ((= x (entry set)) true)
            ((< x (entry set)) (element-of-set? x (left-branch set)))
            ((> x (entry set)) (element-of-set? x (right-branch set)))))

(define (lookup given-key set-of-records)
    (cond   ((null? set-of-records) false)
            ((equal? given-key (key (car set-of-records))) (car set-if-records))
            (else (lookup given-key (cdr set-of-records)))))

(define (lookup key records)
    (cond   ((null? records) false)
            ((= (entry records) key) (entry records))
            ((< (entry records) key) (lookup key (left-branch records)))
            (else (lookup key (right-branch records)))))

(define (make-leaf symbol weight) (list 'leaf symbol weight))
(define (leaf? object) (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
    (list   left
            right
            (append (symbols left) (symbols right))
            (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
    (if (leaf? tree)
        (list (symbol-leaf tree))
        (caddr tree)))
(define (weight tree)
    (if (leaf? tree)
        (weight-leaf tree)
        (cadddr tree)))

(define (decode bits tree)
    (define (decode-1 bits current-branch)
        (if (null? bits)
            '()
            (let ((next-branch (choose-branch (car bits) current-branch)))
                (if (leaf? next-branch)
                    (cons (symbol-leaf next-branch) (decode-1 (cdr bits) tree))
                    (decode-1 (cdr bits) next-branch)))))
    (decode-1 bits tree))

(define (choose-branch bit branch)
    (cond   ((= bit 0) (left-branch branch))
            ((= bit 1) (right-branch branch))
            (else (error "bad bit: CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
    (cond   ((null? set) (list x))
            ((< (weight x) (weight (car set))) (cons x set))
            (else (cons (car set) (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
    (if (null? pairs)
        '()
        (let ((pair (car pairs)))
            (adjoin-set (make-leaf (car pair) (cadr pair))
                        (make-leaf-set (cdr pairs))))))

(define (add-complex z1 z2)
    (make-from-real-imag    (+ (real-part z1) (real-part z2))
                            (+ (imag-part z1) (imag-part z2)))) 

(define (sub-complex z1 z2)
    (make-from-real-imag    (- (real-part z1) (real-part z2))
                            (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
    (make-from-mag-ang      (* (magnitude z1) (magnitude z2))
                            (+ (angle z1) (angle z2)))) 

(define (div-complex z1 z2)
    (make-from-mag-ang  (/ (magnitude z1) (magnitude z2))
                        (- (angle z1) (angle z2))))

(define (attach-tag  type-tag contents)
    (cons type-tag contents))

(define (type-tag datum)
    (if (pair? datum)
        (car datum)
        (error "Bad tagged datum: TYPE-TAG" datum)))

(define (contents datum)
    (if (pair? datum)
        (cdr datum)
        (error "Bad tagged datum: CONTENTS" datum)))

(define (rectangular? z) (eq? (type-tag z) 'rectangular))

(define (polar? z) (eq? (type-tag z) 'polar))

(define (real-part-rectangular z) (car z))

(define (imag-part-rectangular z) (cdr z))

(define (magnitude-rectangular z)
    (sqrt (+    (square (real-part-rectangular z))
                (square (imag-part-rectangular z)))))

(define (angle-rectangular z) 
    (atan (imag-part-rectangular z)(real-part-rectangular z)))

(define (make-from-real-rectangular x y)
    (attach-tag 'rectangular (cons x y)))

(define (make-from-mag-ang-rectangular r a) 
    (attach-tag 'rectangular (cons (* r (cos a)) (* r (sin a)))))

(define (real-part-polar z)
    (* (magnitude-polar z) (cos (angle-polar z))))

(define (imag-part-polar z)
    (* (magnitude-polar z) (sin (angle-polar z))))

(define (magnitude-polar z) (car z)) 

(define (angle-polar z) (cdr z)) 

(define (make-from-real-imag-polar x y)
  (attach-tag 'polar
              (cons (sqrt (+ (square x) (square y))) (atan y x)))) 

(define (make-from-mag-ang-polar r a)
  (attach-tag 'polar (cons r a)))

(define (real-part z)
    (cond   ((rectangular? z) (real-part-rectangular (contents z)))
            ((polar? z) (real-part-polar (contents z)))
            (else (error "Unknown type: REAL-PART" z))))

(define (img-part z)
    (cond   ((rectangular? z) (img-part-rectangular (contents z)))
            ((polar? z) (img-part-polar (contents z)))
            (else (error "Unknown type: IMG-PART" z))))

(define (magnitude z) 
    (cond   ((rectangular? z) (magnitude-rectangular (contents z)))
            ((polar? z) (magnitude-polar (contents z)))
            (else (error "Unknown type: MAGNITUDE" z))))

(define (angle z)
    (cond   ((rectangular? z)(angle-rectangular (contents z)))
            ((polar? z) (angle-polar (contents z)))
            (else (error "Unknown type: ANGLE" z))))

(define (make-from-real-img x y)
    (make-from-real-imag-rectangular x y))

(define (make-from-mag-ang r a)
    (make-from-mag-ang-polar r a))

(define (install-rectangular-package)

    (define (real-part z) (car z))
    (define (imag-part z) (cdr z))
    (define (make-from-real-imag x y) (cons x y)) 
    (define (magnitude z)
        (sqrt (+ (square (real-part z))
                (square (imag-part z)))))
    (define (angle z) (atan (imag-part z) (real-part z)))
    (define (make-from-mag-ang r a) (cons (* r (cos a)) (* r (sin a))))

    (define (tag x) (attach-tag 'rectangular x)) 
    
    (put 'real-part '(rectangular) real-part) 
    (put 'imag-part '(rectangular) imag-part) 
    (put 'magnitude '(rectangular) magnitude) 
    (put 'angle '(rectangular) angle)

    (put 'make-from-real-imag 'rectangular (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'rectangular (lambda (r a) (tag (make-from-mag-ang r a))))
    'done)

(define (install-polar-package)
    (define (magnitude z) (car z))
    (define (angle z) (cdr z))
    (define (make-from-mag-ang r a) (cons r a))
    (define (real-part z) (* (magnitude z) (cos (angle z)))) 
    (define (imag-part z) (* (magnitude z) (sin (angle z)))) 
    (define (make-from-real-imag x y)
        (cons (sqrt (+ (square x) (square y)))
            (atan y x)))

    (define (tag x) (attach-tag 'polar x)) 
    (put 'real-part '(polar) real-part) 
    (put 'imag-part '(polar) imag-part) 
    (put 'magnitude '(polar) magnitude)
    (put 'angle '(polar) angle)
    (put 'make-from-real-imag 'polar    (lambda (x y) (tag (make-from-real-imag x y)))) 
    (put 'make-from-mag-ang 'polar (lambda (r a) (tag (make-from-mag-ang r a)))) 
    'done)

(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (error  "No method for these types: APPLY-GENERIC" (list op type-tags))))))

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

(define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))

(define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))

(define (make-from-real-imag x y) 
    (define (dispatch op)
        (cond   ((eq? op 'real-part) x) 
                ((eq? op 'imag-part) y)
                ((eq? op 'magnitude) (sqrt (+ (square x) (square y)))) ((eq? op 'angle) (atan y x))
                (else (error "Unknown op: MAKE-FROM-REAL-IMAG" op))))
dispatch)

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y)) 
(define (mul x y) (apply-generic 'mul x y)) 
(define (div x y) (apply-generic 'div x y))

(define (install-scheme-number-package)
    (define (tag x) (attach-tag 'scheme-number x))
    (put 'add '(scheme-number scheme-number) (lambda (x y) (tag (+ x y))))
    (put 'sub '(scheme-number scheme-number) (lambda (x y) (tag (- x y))))
    (put 'mul '(scheme-number scheme-number) (lambda (x y) (tag (* x y))))
    (put 'div '(scheme-number scheme-number) (lambda (x y) (tag (/ x y))))
    (put 'make 'scheme-number (lambda (x) (tag x)))
    'done)

(define (make-scheme-number n) 
    ((get 'make 'scheme-number) n))

(define (install-rational-package) 
    (define (numer x) (car x)) 
    (define (denom x) (cdr x)) 
    (define (make-rat n d)
        (let ((g (gcd n d)))
            (cons (/ n g) (/ d g))))
    (define (add-rat x y)
        (make-rat (+ (* (numer x) (denom y))
                        (* (numer y) (denom x)))
                    (* (denom x) (denom y))))
    (define (sub-rat x y)
        (make-rat (- (* (numer x) (denom y))
                        (* (numer y) (denom x)))
                    (* (denom x) (denom y))))
    (define (mul-rat x y)
        (make-rat (* (numer x) (numer y))
        (* (denom x) (denom y)))) (define (div-rat x y)
            (make-rat (* (numer x) (denom y))
                    (* (denom x) (numer y))))

    (define (tag x) (attach-tag 'rational x)) 
    (put 'add '(rational rational) (lambda (x y) (tag (add-rat x y)))) 
    (put 'sub '(rational rational) (lambda (x y) (tag (sub-rat x y)))) 
    (put 'mul '(rational rational) (lambda (x y) (tag (mul-rat x y)))) 
    (put 'div '(rational rational) (lambda (x y) (tag (div-rat x y)))) 
    (put 'make 'rational (lambda (n d) (tag (make-rat n d))))
    'done)

(define (make-rational n d) ((get 'make 'rational) n d))

(define (install-complex-package)
    (define (make-from-real-imag x y) ((get 'make-from-real-imag 'rectangular) x y)) 
    (define (make-from-mag-ang r a) ((get 'make-from-mag-ang 'polar) r a))
    (define (add-complex z1 z2)
        (make-from-real-imag (+ (real-part z1) (real-part z2))
                            (+ (imag-part z1) (imag-part z2))))
    (define (sub-complex z1 z2)
        (make-from-real-imag (- (real-part z1) (real-part z2))
        (- (imag-part z1) (imag-part z2)))) 
    (define (mul-complex z1 z2)
        (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                        (+ (angle z1) (angle z2))))
    (define (div-complex z1 z2)
        (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                            (- (angle z1) (angle z2))))              
    (define (tag z) (attach-tag 'complex z))
    
    (put 'add '(complex complex) (lambda (z1 z2) (tag (add-complex z1 z2))))
    (put 'sub '(complex complex) (lambda (z1 z2) (tag (sub-complex z1 z2))))
    (put 'mul '(complex complex) (lambda (z1 z2) (tag (mul-complex z1 z2))))
    (put 'div '(complex complex) (lambda (z1 z2) (tag (div-complex z1 z2))))
    (put 'make-from-real-imag 'complex (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'complex    (lambda (r a) (tag (make-from-mag-ang r a))))
    'done)

(define (make-complex-from-real-imag x y) 
    ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-from-mag-ang r a) 
    ((get 'make-from-mag-ang 'complex) r a))


(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags))) 
            (if proc
                (apply proc (map contents args)) 
                (if (= (length args) 2)
                    (let    ((type1 (car type-tags)) 
                            (type2 (cadr type-tags)) 
                            (a1 (car args))
                            (a2 (cadr args)))
                    (let    ((t1->t2 (get-coercion type1 type2)) 
                            (t2->t1 (get-coercion type2 type1)))
                        (cond   (t1->t2 (apply-generic op (t1->t2 a1) a2))
                                (t2->t1 (apply-generic op a1 (t2->t1 a2)))
                                (else (error "No method for these types" (list op type-tags))))))
                    (error "No method for these types"
                    (list op type-tags)))))))




(define (install-polynomial-package)
    (define (make-poly variable term-list) (cons variable term-list))
    (define (variable p) (car p))
    (define (term-list p) (cdr p))

    (define (variable? x) (symbol? x))
    (define (same-variable? v1 v2) (and (variable? v1) (variable? v2) (eq? v1 v2)))
    
    (define (add-terms L1 L2)
        (cond   ((empty-termlist? L1) L2)
                ((empty-termlist? L2) L1)
                (else
                    (let    ((t1 (first-term L1))
                            (t2 (first-term L2)))
                        (cond   ((> (order 1) (order 2)) (adjoin-term t1 (add-terms (rest-terms L1) L2)))
                                ((< (order 1) (order 2)) (adjoin-term t2 (add-terms L1 (rest-terms L2))))
                                (else (adjoin-term
                                    (make-term  (order t1)
                                                (add (coeff t1) (coeff t2)))
                                    (add-terms  (rest-terms L1)
                                                (rest-terms L2)))))))))

    (define (mul-terms L1 L2)
        (if (empty-termlist? L1)
            (the-empty-termlist)
            (add-terms  (mul-term-by-all-terms (first-term L1) L2)
                        (mul-terms (rest-terms L1) L2))))
    
    (define (mul-term-by-all-terms t1 L)
        (if (empty-termlist? L)
            (the-empty-termlist)
            (let ((t2 (first-term L)))
                (adjoin-term
                    (make-term (+ (order t1) (order t2))
                                (mul (coeff t1) (coeff t2)))
                    (mul-term-by-all-terms t1 (rest-terms L))))))



    (define (add-poly p1 p2)
        (if (same-variable? (variable p1) (variable p2))
            (make-poly  (variable p1) 
                        (add-terms (term-list p1) (term-list p2)))
            (error "Polys not in same var: ADD-POLY" (list p1 p2))))

    (define (mul-poly p1 p2)
        (if (same-variable? (variable p1) (variable p2))
            (make-poly  (variable p1)
                        (mul-terms (term-list p1) (term-list p2)))
            (error "Polys not in same var: MUL-POLY" (list p1 p2))))
    
    (define (ag p) (attach-tag 'polynomial p))
    (put 'add '(polynomial polynomial) (lambda (p1 p2) (tag (add-poly p1 p2))))
    (put 'mul '(polynomial polynomial) (lambda (p1 p2) (tag (mul-poly p1 p2))))
    (put 'make 'polynomial (lambda (var terms) (tag (make-poly var terms))))
    

    'done
    )

(define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))

(define (the-empty-termlist) '())
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))
(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))
(define (make-polynomial var terms)
    ((get 'make 'polynomial) var terms))

