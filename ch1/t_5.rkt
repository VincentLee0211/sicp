#lang racket/base

(define p (lambda () (p)))

(define test
  (lambda (x y)
    (if (= x 0)
        0
        y)))

(test 0 (p))

;; 如果解释器是正则序求值, 那么得到0
;; 求值(test 0 (p))
;; 需要求值test, 得到(if ...)
;; 此时 (= x 0) 判断, 得到结果0

;; 如果解释器是应用序求值, 那么无法停机
;; 求值(test 0 (p))
;; 需要分别求值 test, 0, (p)
;; 在(p)的求值过程值, 陷入无限递归

;; 此题的逻辑在于, 代换模型是从(test ...)求值开始的, 而不是直接考虑函数的部分