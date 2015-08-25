;; 判断一个数是不是素数

;; n^1/2
(define prime.v1?
  (lambda (n)
    (define smallest-divisor
      (lambda (n)
	(find-divisor n 2)))
    (define find-divisor
      (lambda (n test)
	(cond ((> (square test) n) n)
	      ((divides? test n) test)
	      (else (find-divisor n (+ test 1))))))
    (define divides?
      (lambda (a b)
	(= (remainder b a) 0)))
    (= n (smallest-divisor n))))

;; 概率法
(define prime.v2?
  (lambda (n times)
    (define fermat-test
      (lambda (n)
	(define try-it
	  (lambda (a)
	    (= (expmod a n n) a)))
	(try-it (+ 1 (random (- n 1))))))
    (define expmod
      (lambda (base exp m)
	(cond ((= exp 0) 1)
	      ((even? exp)
	       (remainder (square (expmod base (/ exp 2) m)) m))
	      (else
	       (remainder (* base (expmod base (- exp 1) m)) m)))))
    (cond ((= times 0) #t)
	  ((fermat-test n) (prime.v2? n (- times 1)))
	  (else #f))))
