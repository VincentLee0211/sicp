#lang racket/base

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

(define expmod
  (lambda (base exp m)
    (cond [(= exp 0) 1]
          [(even? exp)
           (remainder (expt (expmod base (/ exp 2) m) 2) m)]
          [else
           (remainder (* base (expmod base (- exp 1) m)) m)])))

(define timed-prime-test
  (lambda (n)
    (newline)
    (display n)
    (start-prime-test n (current-inexact-milliseconds))))

(define times 100)

(define start-prime-test
  (lambda (n start-time)
    (if (fast-prime? n 100)
        (report-prime (- (current-inexact-milliseconds) start-time))
        (display ""))))

(define report-prime
  (lambda (elapsed-time)
    (display " *** ")
    (display elapsed-time)))

(define search-for-primes
  (lambda (low high)
    (cond [(> low high)
           (newline)
           (display "done")]
          [else
           (timed-prime-test low)
           (search-for-primes (+ low 1) high)])))

(search-for-primes 1001 1020)

(search-for-primes 10001 10038)

(search-for-primes 100001 100044)

(search-for-primes 1000001 1000038)
