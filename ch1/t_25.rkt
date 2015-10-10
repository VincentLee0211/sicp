#lang racket/base

(define expmod
  (lambda (base exp m)
    (remainder (fast-expt base exp) m)))

;; 这种方式不对, 因为(fast-exp base exp)可能获取很大的数
;; 大数的计算都会非常慢


(define fast-prime?
  (lambda (n times)
    (cond [(= times 0) #t]
          [(fermat-test n) (fast-prime? n (- times 1))]
          [else #f])))

(define fermat-test
  (lambda (n)
    (define try-it
      (lambda (a)
        (= (expmod a n n) a)))
    (try-it (+ 1 (random (- n 1))))))

(define fast-expt
  (lambda (b n)
    (cond [(= n 0) 1]
          [(even? n) (expt (fast-expt b (/ n 2)) 2)]
          [else (* b (fast-expt b (- n 1)))])))
