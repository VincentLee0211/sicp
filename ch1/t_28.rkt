#lang racket/base

(define fast-prime?
  (lambda (n times)
    (cond [(= times 0) #t]
          [(miller-test n) (fast-prime? n (- times 1))]
          [else #f])))

(define miller-test
  (lambda (n)
    (define try-it
      (lambda (a)
        (= (expmod a (- n 1) n) 1)))   ;; a^(n-1) mod n = 1
    (try-it (+ 1 (random (- n 1))))))

(define expmod
  (lambda (base exp m)
    (define miller-check?
      (lambda (x)
        (cond [(or (= x 1) (= x (- m 1))) #f]
              [else (= (remainder (expt x 2) m) 1)])))
    (cond [(= exp 0) 1]
          [(even? exp)
           (let ([t (expmod base (/ exp 2) m)])
             (if (miller-check? t)
                 0
                 (remainder (expt t 2) m)))]
          [else
           (remainder (* base (expmod base (- exp 1) m)) m)])))

(fast-prime? 561 100)

(fast-prime? 1105 100)

(fast-prime? 1729 100)

(fast-prime? 2465 100)

(fast-prime? 2821 100)

(fast-prime? 6601 100)

(fast-prime? 3 100)

(fast-prime? 4 100)

(fast-prime? 5 100)