#lang racket

(define accumulate.v1
  (lambda (combiner null-value term a next b)
    (if (> a b)
        null-value
        (combiner (term a)
                  (accumulate.v1 combiner null-value term (next a) next b)))))

(define accumulate.v2
  (lambda (combiner null-value term a next b)
    (define iter
      (lambda (a result)
        (if (> a b)
            result
            (iter (next a)
                  (combiner result (term a))))))
    (iter a null-value)))

(accumulate.v1 +
              0
              (lambda (x) x)
              1
              (lambda (x) (+ x 1))
              100)

(accumulate.v2 +
               0
               (lambda (x) x)
               1
               (lambda (x) (+ x 1))
               100)
               