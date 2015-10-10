#lang racket/base

(define f.v1
  (lambda (n)
    (if (< n 3)
        n
        (+ (f.v1 (- n 1))
           (* 2 (f.v1 (- n 2)))
           (* 3 (f.v1 (- n 3)))))))

(define f.v2
  (lambda (n)
    (define iter
      (lambda (a b c counter)
        (if (= counter 0)
            (+ a (* 2 b) (* 3 c))
            (iter (+ a (* 2 b) (* 3 c))
                  a
                  b
                  (- counter 1)))))
    (if (< n 3)
        n
        (iter 2 1 0 (- n 3)))))

(f.v1 3)
(f.v2 3)

(f.v1 4)
(f.v2 4)

(f.v1 10)
(f.v2 10)

(f.v1 -1)
(f.v2 -1)