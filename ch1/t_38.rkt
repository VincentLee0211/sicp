#lang racket

(define cont-frac
  (lambda (n d k)
    (define recur
      (lambda (i)
        (if (= i k)
            (/ (n i) (d i))
            (/ (n i) (+ (d i) (recur (+ i 1)))))))
    (recur 1)))

(define e
  (lambda (n)
    (+ 2.0 (cont-frac (lambda (i) 1.0)
                      (lambda (i)
                        (if (= (remainder i 3) 2)
                            (* 2 (+ 1 (quotient i 3)))
                            1))
                      n))))