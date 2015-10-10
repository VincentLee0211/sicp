#lang racket

(define fixed-point
  (lambda (f guess)
    (define try
      (lambda (guess)
        (let ([next (f guess)])
          (if (close-enough? guess next)
              next
              (try next)))))
    (define close-enough?
      (lambda (v1 v2)
        (< (abs (- v1 v2)) 0.00001)))
    (try guess)))

(define repeated
  (lambda (f times)
    (lambda (x)
      (if (= times 1)
          (f x)
          (f ((repeated f (- times 1)) x))))))

(define average-damp
  (lambda (f)
    (lambda (x)
      (average x (f x)))))

(define average
  (lambda (x y)
    (/ (+ x y) 2)))

(define 2th
  (lambda (x)
    (fixed-point (average-damp (lambda (y) (/ x y))) 1.0)))

(define 3th
  (lambda (x)
    (fixed-point (average-damp (lambda (y) (/ x (expt y 2)))) 1.0)))

(define nth
  (lambda (n)
    (fixed-point ((repeated average-damp 2) (lambda (y) (/ 2 (expt y (- n 1))))) 1.0)))


;; times = 1
;; n     = 2, 3

;; times = 2
;; n     = 4, 5, 6, 7,

(define ensure-times
  (lambda (n)
    (floor (/ (log n) (log 2)))))

(define nth.ok
  (lambda (x n)
    (fixed-point ((repeated average-damp (ensure-times n))
                  (lambda (y) (/ x (expt y (- n 1)))))
                 1.0)))