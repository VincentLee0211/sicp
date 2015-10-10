#lang racket/base

(define size 2)

(define pi 3.14159)

(define radius 10)

(define circumference (* 2 pi radius))

(define square (lambda (x) (* x x)))

(define sum-of-squares
  (lambda (x y)
    (+ (square x)
       (square y))))

(define f
  (lambda (a)
    (sum-of-squares (+ a 1) (* a 2))))

;; 代换
(f 5)

;; (sum-of-squares (+ a 1) (* a 2))
(sum-of-squares (+ 5 1) (* 5 2))

;; (+ (square x) (square y))
(+ (square 6) (square 10))

136

;; 求平方根
(define sqrt-iter
  (lambda (guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x))))

(define improve
  (lambda (guess x)
    (average guess (/ x guess))))

(define average
  (lambda (x y)
    (/ (+ x y) 2)))

(define good-enough?
  (lambda (guess x)
    (< (abs (- (square guess) x)) 0.001)))

(define sqrt
  (lambda (x)
    (sqrt-iter 1.0 x)))