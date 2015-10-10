#lang racket

(define iterative-improve
  (lambda (good improve)
    (lambda (guess)
      (let ([next (improve guess)])
        (if (good guess next)
            next
            ((iterative-improve good improve) next))))))

(define fixed-point
  (lambda (f)
    (iterative-improve (lambda (v1 v2)
                         (< (abs (- v1 v2)) 0.00001))
                       (lambda (x)
                         (f x)))))

(define average-damp
  (lambda (f)
    (lambda (x)
      (average x (f x)))))

(define average
  (lambda (x y)
    (/ (+ x y) 2)))

(define sqrt.v1
  (lambda (x)
    ((fixed-point (average-damp (lambda (y) (/ x y)))) 1.0)))

(define sqrt.v2
  (lambda (x)
    ((iterative-improve (lambda (guess next)
                        (< (abs (- guess next)) 0.00001))
                      (lambda (guess)
                        (average guess (/ x guess))))
     1.0)))
                      