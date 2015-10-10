#lang racket/base

(define fast-expt
  (lambda (b n)
    (define iter
      (lambda (a base exp)
        (cond [(= exp 0) a]
              [(even? exp) (iter a (square base) (/ exp 2))]
              [else (iter (* a base) base (- exp 1))])))
    (iter 1 b n)))

(define square (lambda (x) (* x x)))
