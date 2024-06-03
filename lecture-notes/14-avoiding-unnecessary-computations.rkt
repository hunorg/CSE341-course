#lang racket 

(provide (all-defined-out))

; thunks let you skip expensive computations if they are not needed 
; great if you take the true-branch:

    ; (define (f th)
        ; (if (..) 0 (... (th) ...)))

; but worse if you end up using the thunk more than once: 

    ; (define (f th)
        ; (... (if (...) 0 (... (th) ...))
            ; (if (...) 0 (... (th) ...))
            ; ...
            ; (if (...) 0 (... (th) ...))))

(define (slow-add x y)
    (letrec ([slow-id (lambda (y z)
                        (if (= 0 z)
                        y
                        (slow-id (- z 1))))])
        (+ (slow-id x 50000000) y)))


