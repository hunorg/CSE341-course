#lang racket

(provide (all-defined-out))

(define x 3) ; x = 3
(define y (+ x 2)) ; + is a function, call it here

(define cube1
  (lambda (x)
    (* x (* x x)))) ; x * (x * x )

(define cube2
  (lambda (x)
    (* x x x)))

(define (cube3 x)
  (* x x x)) ; previous with syntactic sugar

(define (pow1 x y) ; x to the yth power (y must be nonnegative)
  (if (= y 0)
      1
      (* x (pow1 x (- y 1)))))


(define test-pow-1 (pow1 3 2))

(define pow2
  (lambda (x)
    (lambda (y)
      (pow1 x y))))

(define three-to-the (pow2 3))

(define test-three-to-the (three-to-the 2))

(define sixteen (pow1 4 2))
(define sixteen2 ((pow2 4) 2))

; when you want to call a function, always (e0, e1 ... en)



