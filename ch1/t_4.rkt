#lang racket/base

(define a-plus-abs-b
  (lambda (a b)
    ((if (> b 0) + -) a b)))

;; a + | b |

(a-plus-abs-b 3 -5)
;; 8

(a-plus-abs-b 3 5)
;; 8