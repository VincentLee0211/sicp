#lang racket/base

(define cube-root
  (lambda (x)

    (define iter
      (lambda (guess)
        (let [(next-guess (improve guess))]
          (if (good-enough? guess next-guess)
              next-guess
              (iter next-guess)))))

    (define improve
      (lambda (guess)
        (/ (+ (/ x (square guess)) (* 2 guess)) 3)))

    (define good-enough?
      (lambda (guess next-guess)
        (< (abs (- 1.0 (/ guess next-guess))) 0.001)))
    
    (iter 1.0)))

(define square
  (lambda (x)
    (* x x)))