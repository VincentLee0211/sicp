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


(prime? 561)
(fast-prime? 561 100)

(prime? 1105)
(fast-prime? 1105 100)

(prime? 1729)
(fast-prime? 1729 100)

(prime? 2465)
(fast-prime? 2465 100)

(prime? 2821)
(fast-prime? 2821 100)

(prime? 6601)
(fast-prime? 6601 100)