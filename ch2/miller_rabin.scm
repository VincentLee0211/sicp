;; 使用 Miller-Rabin-Test 检测素数
(define prime?
  (lambda (n)
    (fast-prime? n 100)))

(define fast-prime?
  (lambda (n times)
    (cond ((zero? times) #t)
          ((miller-rabin-test n) (fast-prime? n (sub1 times)))
          (else #f))))

(define miller-rabin-test
  (lambda (n)
    (define try-it
      (lambda (x)
        (one? (expmod x (sub1 n) n))))
    (try-it (add1 (random (sub1 n))))))

(define expmod
  (lambda (base exp m)
    (cond ((zero? exp) 1)
          ((even? exp)
           (let ((x (expmod base (/ exp 2) m)))
             (if (non-trivial-sqrt? x m)
                 0
                 (remainder (square x) m))))
          (else (remainder (* base (expmod base (sub1 exp) m)) m)))))

(define non-trivial-sqrt?
  (lambda (x m)
    (cond ((or (one? x) (= x (sub1 m))) #f)
          (else (one? (remainder (square x) m))))))

(define zero? (lambda (x) (= x 0)))

(define one? (lambda (x) (= x 1)))

(define add1 (lambda (x) (+ x 1)))

(define sub1 (lambda (x) (- x 1)))
