#lang racket/base

(define A
  (lambda (x y)
    (cond [(= y 0) 0]
          [(= x 0) (* 2 y)]
          [(= y 1) 2]
          [else (A (- x 1)
                   (A x (- y 1)))])))

(A 1 10)
;; 2^10 = 1024

(A 2 4)
;; 2 ^ 2 ^ 2 ^ 2 = 65536

(A 3 3)
;; 2 ^ (A 3 2) =  ... = 65536

(define f (lambda (n) (A 0 n)))
;; f = 2n

(define g (lambda (n) (A 1 n)))
;; f = 2^n

(define h (lambda (n) (A 2 n)))
;; f = 2^2^2...^2 (n)

(define k (lambda (n) (* 5 n n)))
;; k = 2n^2