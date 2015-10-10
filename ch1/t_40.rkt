#lang racket

(define cubic
  (lambda (a b c)
    (lambda (x)
      (+ (expt x 3)
         (* a (expt x 2))
         (* b x)
         c))))

(define newtons-method
  (lambda (g guess)
    (fixed-point (newton-transform g) guess)))

(define newton-transform
  (lambda (g)
    (lambda (x)
      (- x (/ (g x) ((deriv g) x))))))

(define deriv
  (lambda (g)
    (lambda (x)
      (/ (- (g (+ x dx)) (g x)) dx))))

(define dx 0.00001)

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
        (< (abs (- v1 v2)) dx)))
    (try guess)))

(newtons-method (cubic 1 -2 -3) 1)