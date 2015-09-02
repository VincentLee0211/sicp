#|
请定义过程 unique-pairs, 给它整数 n, 它产生序对(i, j), 其中 1<=j<i<=n.

请使用 unique-pairs 去简化上面 prime-sum-pairs 的定义
|#

(define flatmap
  (lambda (proc seq)
    (accumulate append '() (map proc seq))))

(define map
  (lambda (proc seq)
    (if (null? seq)
        '()
        (cons (proc (car seq))
              (map proc (cdr seq))))))

(define enumerate-interval
  (lambda (low high)
    (if (> low high)
        '()
        (cons low (enumerate-interval (add1 low) high)))))

(define add1 (lambda (x) (+ x 1)))

(define sub1 (lambda (x) (- x 1)))

(define zero? (lambda (x) (= x 0)))

(define one? (lambda (x) (= x 1)))

(define unique-pairs
  (lambda (n)
    (flatmap (lambda (i)
               (map (lambda (j) (list i j))
                    (enumerate-interval 1 (sub1 i))))
             (enumerate-interval 1 n))))

(define prime-sum-pairs
  (lambda (n)
    (map make-pair-sum
         (filter prime-sum?
                 (unique-pairs n)))))

(define make-pair-sum
  (lambda (pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair)))))

(define prime-sum?
  (lambda (pair)
    (prime? (+ (car pair) (cadr pair)))))

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
      (lambda (a)
        (one? (expmod a (sub1 n) n))))
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
