#lang racket

(define f (lambda (g) (g 2)))

(define square (lambda (x) (* x x)))

(f square)
;; 4

(f (lambda (z) (* z (+ z 1))))
;; 6

(f f)
;; error (2 2) , 2不是过程