#|
证明脚注47中列出的 Carmichael 数确实能骗过费马检查. 也就是说, 写一个过程, 它以整数 n 的参数, 对每个a < n 检查 a^n 是否与 a 模 n 同余. 用你的过程去检查当前给出的那些 Carmichael 数
|#

(define prime.v1?
  (lambda (n)
    (define smallest-divisor
      (lambda (n)
	(find-divisor n 2)))
    (define find-divisor
      (lambda (n t)
	(cond ((> (square t) n) n)
	      ((divides? n t) t)
	      (else (find-divisor n (next t))))))
    (define divides?
      (lambda (n t)
	(= (remainder n t) 0)))
    (define next
      (lambda (t)
	(if (= t 2)
	    3
	    (+ t 2))))
    (= n (smallest-divisor n))

(define prime.v2?
  (lambda (n times)
    (define fermat-test
      (lambda (n)
	(define try-it
	  (lambda (t)
	    (= (expmod t n n) t)))
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

(prime.v1? 561)
(prime.v2? 561 100)

(prime.v1? 1105)
(prime.v2? 1105 100)

(prime.v1? 1729)
(prime.v2? 1729 100)

(prime.v1? 2465)
(prime.v2? 2465 100)

(prime.v1? 2821)
(prime.v2? 2821 100)

(prime.v1? 6601)
(prime.v2? 6601 100)
