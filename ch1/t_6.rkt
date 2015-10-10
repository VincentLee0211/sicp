#lang racket/base

(define new-if
  (lambda (predicate then-clause else-clause)
    (cond [predicate then-clause]
          [else else-clause])))

(new-if (= 2 3) 0 5)
;; 5

(new-if (= 1 1) 0 5)
;; 0

#|
(define sqrt-iter
  (lambda (guess x)
    (new-if (good-enough? guess x)
            guess
            (sqrt-iter (improve guess x) x))))
|#

;; 应用`应用序`代换模型
;; 调用(new-if ...)时, 需要确定(good-enough? ...), guess, (sqrt-iter ...)的明确值
;; 在(sqrt-iter ...)处, 无法停机

;; 但是对于(if ...), 使用特殊求值规则, 先计算predicate,
;; 1. predicate == #t, 计算consequent
;; 2. predicate == #f, 计算alternative