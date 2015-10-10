#lang racket

(define compose
  (lambda (f g)
    (lambda (x)
      (f (g x)))))

(define square (lambda (x) (expt x 2)))

(define inc (lambda (x) (+ x 1)))

((compose square inc) 6)