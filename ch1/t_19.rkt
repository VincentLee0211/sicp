#lang racket/base

(define fib
  (lambda (n)
    (define fib-iter
      (lambda (a b p q count)
        (cond [(= count 0) b]
              [(even? count)
               (fib-iter a
                         b
                         (+ (* p p) (* q q))
                         (+ (* q q) (* 2 p q))
                         (/ count 2))]
              [else
               (fib-iter (+ (* b q) (* a q) (* a p))
                         (+ (* b p) (* a q))
                         p
                         q
                         (- count 1))])))
    (fib-iter 1 0 0 1 n)))

;; 一次变换
;; a <- bq + aq + ap
;; b <- bp + aq

;; 二次变换
;; a <- (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
;;   <- bpq + aqq + bqq + aqq + apq + bpq + apq + app
;;   <- b(qq + 2pq) + a(qq + 2pq) + a(pp + qq)

;; b <- (bp + aq)p + (bq + aq + ap)q
;;   <- bpp + apq + bqq + aqq + apq
;;   <- b(pp + qq) + a(qq + 2pq)

;; 经过二次变换
;; p -> pp + qq
;; q -> qq + 2pq