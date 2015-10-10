#lang racket

(define repeated
  (lambda (f times)
    (lambda (x)
      (if (= times 1)
          (f x)
          (f ((repeated f (- times 1)) x))))))

(define square
  (lambda (x)
    (expt x 2)))

((repeated square 2) 5)
      