#lang racket

(define cont-frac
  (lambda (n d k)
    (define recur
      (lambda (i)
        (if (= i k)
            (/ (n i) (d i))
            (/ (n i) (+ (d i) (recur (+ i 1)))))))
    (recur 1)))

(define tanf
  (lambda (x k)
    (cont-frac (lambda (i)
                 (if (= i 1)
                     x
                     (- (expt x 2))))
               (lambda (i)
                 (- (* 2 i) 1))
               k)))