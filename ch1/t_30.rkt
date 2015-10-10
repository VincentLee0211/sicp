#lang racket/base

(define sum
  (lambda (term a next b)
    (define iter
      (lambda (a result)
        (if (> a b)
            result
            (iter (next a) (+ result (term a))))))
    (iter a 0)))

(sum (lambda (x) x)
     1
     (lambda (x) (+ x 1))
     100)