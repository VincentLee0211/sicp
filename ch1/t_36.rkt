#lang racket

(define fixed-point
  (lambda (f guess)
    (define try
      (lambda (guess)
        (print-line guess)
        (let ([next (f guess)])
          (if (close-enough? guess next)
              next
              (try next)))))
    (define tolerance 0.00001)
    (define close-enough?
      (lambda (v1 v2)
        (< (abs (- v1 v2)) tolerance)))
    (try guess)))

(define print-line
  (lambda (x)
    (newline)
    (display x)))

(define average
  (lambda (x y)
    (/ (+ x y) 2)))

(define y.v1
  (fixed-point (lambda (x) (/ (log 1000) (log x)))
               2.0))

(define y.v2
  (fixed-point (lambda (x) (average x (/ (log 1000) (log x))))
               2.0))