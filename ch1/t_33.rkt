#lang racket

(define filtered-accumulate.v1
  (lambda (predicate combiner null-value term a next b)
    (cond [(> a b) null-value]
          [(predicate a)
           (combiner (term a)
                     (filtered-accumulate.v1 predicate
                                             combiner
                                             null-value
                                             term
                                             (next a)
                                             next
                                             b))]
          [else
           (combiner null-value
                     (filtered-accumulate.v1 predicate
                                             combiner
                                             null-value
                                             term
                                             (next a)
                                             next
                                             b))])))

(define filtered-accumulate.v2
  (lambda (predicate combiner null-value term a next b)
    (define iter
      (lambda (a result)
        (cond [(> a b) result]
              [(predicate a)
               (iter (next a)
                     (combiner result (term a)))]
              [else
               (iter (next a)
                     (combiner result null-value))])))
    (iter a null-value)))

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

(define gcd
  (lambda (m n)
    (if (= n 0)
        m
        (gcd n (remainder m n)))))

;; a
(define sum-primes
  (lambda (a b)
    (filtered-accumulate.v1 prime?
                            +
                            0
                            (lambda (x) x)
                            a
                            (lambda (x) (+ x 1))
                            b)))

;; b
(define sum-gcd
  (lambda (n)
    (filtered-accumulate.v1 (lambda (x) (= (gcd n x) 1))
                            *
                            1
                            (lambda (x) x)
                            2
                            (lambda (x) (+ x 1))
                            (- n 1))))