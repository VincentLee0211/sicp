#lang racket/base

(define prime?
  (lambda (n)
    (define smallest-divisor
      (lambda (n)
        (find-divisor n 2)))
    (define find-divisor
      (lambda (n test)
        (cond [(> (expt test 2) n) n]
              [(divides? n test) test]
              [else (find-divisor n (next test))])))
    (define divides?
      (lambda (n test)
        (= (remainder n test) 0)))
    (define next
      (lambda (test)
        (if (= test 2)
            (+ test 1)
            (+ test 2))))
    (= (smallest-divisor n) n)))

(define timed-prime-test
  (lambda (n)
    (newline)
    (display n)
    (start-prime-test n (current-inexact-milliseconds))))

(define start-prime-test
  (lambda (n start-time)
    (if (prime? n)
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

