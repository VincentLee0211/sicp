#lang racket

(define smooth
  (lambda (f)
    (lambda (x)
      (/ (+ (f (- x dx))
            (f x)
            (f (+ x dx)))
         3))))

(define dx 0.0001)

(define cube
  (lambda (x)
    (expt x 3)))

((smooth cube) 5)

(define nth-smooth
  (lambda (f times)
    (lambda (x)
      ((repeated (smooth f) times) x))))

(define repeated
  (lambda (f times)
    (lambda (x)
      (if (= times 1)
          (f x)
          (f ((repeated f (- times 1)) x))))))