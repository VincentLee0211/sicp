#lang racket/base

;; 计算阶乘
(define factorial.v1
  (lambda (n)
    (if (= n 1)
        1
        (* n (factorial.v1 (- n 1))))))

(define factorial.v2
  (lambda (n)
    (define iter
      (lambda (product counter)
        (if (> counter n)
            product
            (iter (* product counter)
                  (+ counter 1)))))
    (iter 1 1)))

;; 计算斐波那契数
(define fib.v1
  (lambda (n)
    (cond [(= n 0) 0]
          [(= n 1) 1]
          [else (+ (fib.v1 (- n 1))
                   (fib.v2 (- n 2)))])))

(define fib.v2
  (lambda (n)
    (define iter
      (lambda (a b counter)
        (if (= counter 0)
            b
            (iter (+ a b)
                  a
                  (- counter 1)))))
    (iter 1 0 n)))

;; 计算找零钱
(define count-change.v1
  (lambda (amount)
    (define cc
      (lambda (amount kinds-of-coins)
        (cond [(= amount 0) 1]
              [(or (< amount 0) (= kinds-of-coins 0)) 0]
              [else (+ (cc amount
                           (- kinds-of-coins 1))
                       (cc (- amount (first-denomination kinds-of-coins))
                           kinds-of-coins))])))
    (define first-denomination
      (lambda (kinds-of-coins)
        (cond [(= kinds-of-coins 1) 1]
              [(= kinds-of-coins 2) 5]
              [(= kinds-of-coins 3) 10]
              [(= kinds-of-coins 4) 25]
              [(= kinds-of-coins 5) 50])))
    (cc amount 5)))

;; 计算幂
(define expt.v1
  (lambda (a b)
    (if (= b 0)
        1
        (* a (expt.v1 a (- b 1))))))

(define expt.v2
  (lambda (a b)
    (define iter
      (lambda (product counter)
        (if (= counter 0)
            product
            (iter (* product a)
                  (- counter 1)))))
    (iter 1 b)))

(define square (lambda (x) (* x x)))

(define fast-expt.v1
  (lambda (a b)
    (cond [(= b 0) 1]
          [(even? b) (square (fast-expt.v1 a (/ b 2)))]
          [else (* a (fast-expt.v1 a (- b 1)))])))

(define fast-expt.v2
  (lambda (b n)
    (define iter
      (lambda (a base exp)
        (cond [(= exp 0) a]
              [(even? exp) (iter a (square base) (/ exp 2))]
              [else (iter (* a base) base (- exp 1))])))
    (iter 1 b n)))

;; 计算最大公约数
(define gcd
  (lambda (m n)
    (if (= n 0)
        m
        (gcd n (remainder m n)))))

;; 计算素数
(define prime?
  (lambda (n)
    (define smallest-divisor
      (lambda (n)
        (find-divisor n 2)))
    (define find-divisor
      (lambda (n test)
        (cond [(> (square test) n) n]
              [(divides? n test) test]
              [else (find-divisor n (+ test 1))])))
    (define divides?
      (lambda (n test)
        (= (remainder n test) 0)))
    (= (smallest-divisor n) n)))

(define fast-prime?
  (lambda (n times)
    (cond [(= times 0) #t]
          [(fermate-test n) (fast-prime? n (- times 1))]
          [else #f])))

(define fermate-test
  (lambda (n)
    (define try-it
      (lambda (a)
        (= (expmod a n n) a)))
    (try-it (+ 1 (random (- n 1))))))

(define expmod
  (lambda (base exp m)
    (cond [(= exp 0) 1]
          [(even? exp)
           (remainder (square (expmod base (/ exp 2) m)) m)]
          [else
           (remainder (* base (expmod base (- exp 1) m)) m)])))