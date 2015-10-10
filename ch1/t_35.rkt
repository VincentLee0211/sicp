#lang racket

(define fixed-point
  (lambda (f guess)
    (define try
      (lambda (guess)
        (let [(next (f guess))]
          (if (close-enough? guess next)
              next
              (try next)))))
    (define tolerance 0.00001)
    (define close-enough?
      (lambda (v1 v2)
        (< (abs (- v1 v2)) tolerance)))
    (try guess)))

(define golden-ratio
  (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0))

