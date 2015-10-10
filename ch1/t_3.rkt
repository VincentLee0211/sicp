#lang racket/base

(define sum-of-two-max
  (lambda (a b c)
    (if (and (< a b) (< a c))
        (+ b c)
        (if (< b c)
            (+ a c)
            (+ a b)))))

(sum-of-two-max 1 2 3)
;; 5

(sum-of-two-max 3 4 5)
;; 9