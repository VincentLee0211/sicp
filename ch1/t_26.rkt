#lang racket/base

(define expmod
  (lambda (base exp m)
    (cond [(= exp 0) 1]
          [(even? exp)
           (remainder (* (expmod base (/ exp 2) m)
                         (expmod base (/ exp 2) m))
                      m)]
          [else
           (remainder (* base
                         (expmod base (- exp 1) m))
                      m)])))

;; 因为(even? ...) == #t时, (expmod ...)需要计算两次
;; 而之前的方式, 只需要计算一次