#lang racket

(define double
  (lambda (f)
    (lambda (x)
      (f (f x)))))

(define inc
  (lambda (x)
    (+ x 1)))

(((double (double double)) inc) 5)

;; (double double)  ==  2 * 2

;; (double (double double))  == 4 * 4

;; 对5执行16次inc操作
