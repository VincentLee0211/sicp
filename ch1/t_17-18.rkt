#lang racket/base

(define double (lambda (x) (* 2 x)))

(define halve (lambda (x) (/ x 2)))

(define *.v1
  (lambda (a b)
    (if (= b 0)
        0
        (+ a (*.v1 a (- b 1))))))

(define *.v2
  (lambda (a b)
    (define iter
      (lambda (sum counter)
        (if (= counter 0)
            sum
            (iter (+ sum a)
                  (- counter 1)))))
    (iter 0 b)))

(define fast-*.v1
  (lambda (a b)
    (cond [(= b 0) 0]
          [(even? b) (double (fast-*.v1 a (halve b)))]
          [else (+ a (fast-*.v1 a (- b 1)))])))

(define fast-*.v2
  (lambda (a b)
    (define iter
      (lambda (a m c)
        (cond [(= c 0) a]
              [(even? c) (iter a (double m) (halve c))]
              [else (iter (+ a m) m (- c 1))])))
    (iter 0 a b)))