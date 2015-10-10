#lang racket

(define fixed-point
  (lambda (f guess)
    (define tolerance 0.00001)
    (define close-enough?
      (lambda (v1 v2)
        (< (abs (- v1 v2)) tolerance)))
    (define try
      (lambda (guess)
        (let ([next (f guess)])
          (if (close-enough? guess next)
              next
              (try next)))))
    (try guess)))

(define cont-frac.v1
  (lambda (n d k)
    (define iter
      (lambda (k result)
        (if (= k 1)
            result
            (iter (- k 1)
                  (/ (n (- k 1))
                     (+ (d (- k 1)) result))))))
    (iter k (/ (n k) (d k)))))

(define cont-frac.v2
  (lambda (n d k)
    (define recur
      (lambda (i)
        (if (= i k)
            (/ (n k)
               (d k))
            (/ (n i)
               (+ (d i) (recur (+ i 1)))))))
    (recur 1)))

(cont-frac.v1 (lambda (i) 1.0)
              (lambda (i) 1.0)
              100)

(cont-frac.v2 (lambda (i) 1.0)
              (lambda (i) 1.0)
              100)

