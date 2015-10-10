#lang racket/base

(define product.v1
  (lambda (term a next b)
    (if (> a b)
        1
        (* (term a)
           (product.v1 term (next a) next b)))))

(define product.v2
  (lambda (term a next b)
    (define iter
      (lambda (a result)
        (if (> a b)
            result
            (iter (next a) (* result (term a))))))
    (iter a 1)))

(product.v1 (lambda (x) x)
            1
            (lambda (x) (+ x 1))
            10)

(product.v2 (lambda (x) x)
            1
            (lambda (x) (+ x 1))
            10)

(* 4.0 (product.v1 (lambda (x)
                     (if (even? x)
                         (/ (+ x 2) (+ x 1))
                         (/ (+ x 1) (+ x 2))))
                   1
                   (lambda (x) (+ x 1))
                   1000))

(* 4.0 (product.v2 (lambda (x)
                     (if (even? x)
                         (/ (+ x 2) (+ x 1))
                         (/ (+ x 1) (+ x 2))))
                   1
                   (lambda (x) (+ x 1))
                   1000))