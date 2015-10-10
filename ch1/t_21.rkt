#lang racket/base

(define prime?
  (lambda (n)
    (= (smallest-divisor n) n)))

(define smallest-divisor
  (lambda (n)
    (find-divisor n 2)))

(define find-divisor
  (lambda (n test)
    (cond [(> (square test) n) n]
          [(divides? n test) test]
          [else (find-divisor n (+ test 1))])))

(define divides?
  (lambda (n test)
    (= (remainder n test) 0)))

(define square (lambda (x) (expt x 2)))

(smallest-divisor 199)

(smallest-divisor 1999)

(smallest-divisor 19999)