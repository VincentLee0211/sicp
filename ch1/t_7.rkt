#lang racket/base

(define sqrt.v1
  (lambda (x)

    (define sqrt-iter
      (lambda (guess)
        (print-line guess)
        (if (good-enough? guess)
            guess
            (sqrt-iter (improve guess)))))

    (define improve
      (lambda (guess)
        (average guess (/ x guess))))

    (define good-enough?
      (lambda (guess)
        (< (abs (- x (square guess))) 0.001)))
    
    (sqrt-iter 1.0)))

(define average
  (lambda (x y)
    (/ (+ x y) 2)))

(define square (lambda (x) (* x x)))

(define print-line
  (lambda (v)
    (newline)
    (display v)))

;; (sqrt.v1 1000000000000)
;; (sqrt.v1 10000000000000)

;; 当数非常大的时候, 获取的猜测值永远无法收敛到给定的精度
;; 所以无法计算

;; 当数非常小的时候, 获取的猜测值还没有到预计的值, 就收敛到给定的精度
;; 所以无法计算

(define sqrt.v2
  (lambda (x)

    (define sqrt-iter
      (lambda (guess)
        (let ([next-guess (improve guess)])
          (if (good-enough? guess next-guess)
              next-guess
              (sqrt-iter next-guess)))))

    (define improve
      (lambda (guess)
        (average guess (/ x guess))))

    (define good-enough?
      (lambda (guess next-guess)
        (< (abs (- 1.0 (/ guess next-guess))) 0.001)))
    
    (sqrt-iter 1.0)))

(sqrt.v2 1000000000000)
(sqrt.v2 10000000000000)