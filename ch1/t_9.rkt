#lang racket/base

(define inc (lambda (x) (+ x 1)))

(define dec (lambda (x) (- x 1)))

(define +.v1
  (lambda (a b)
    (if (= a 0)
        b
        (inc (+.v1 (dec a) b)))))

;; 递归计算过程
(+.v1 4 5)
(inc (+.v1 3 5))
(inc (inc (+.v1 2 5)))
(inc (inc (inc (+.v1 1 5))))
(inc (inc (inc (inc (+.v1 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9

(define +.v2
  (lambda (a b)
    (if (= a 0)
        b
        (+.v2 (dec a) (inc b)))))

;; 迭代计算过程
(+.v2 4 5)
(+.v2 3 6)
(+.v2 2 7)
(+.v2 1 8)
(+.v2 0 9)
9