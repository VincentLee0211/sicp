#|
你可以通过引进一个处理被组合项的过滤器概念, 写出一个比 accumulate 更一般的版本. 

也就是说, 在计算过程中, 只组合起由给定范围得到的项里的那些满足特定条件的项.
这样得到的 filtered-accumulate 抽象取与上面累积过程同样的参数, 再加上一个另外的描述有关过滤器的谓词参数.
请写出 filtered-accumulate 作为一个过程, 说明如何用 filtered-accumualte 表达以下内容:

a. 求出在区间 a 到 b 中所有素数之和
b. 小于 n 的所有与 n 互素的正整数之乘积
|#

(define @filtered-accumulate
  (lambda (filter combiner null-value term a next b)
    (cond ((> a b) null-value)
	  ((filter a) (combiner (term a)
				(@filtered-accumulate filter
						      combiner
						      null-value
						      term
						      (next a)
						      next
						      b)))
	  (else (@filtered-accumulate filter     ;; 此处可以(combiner null-value ...) 也可以不合并, 直接求(next a), 而忽略本次操作
				      combiner
				      null-value
				      term
				      (next a)
				      next
				      b)))))

(define &filtered-accumualte
  (lambda (filter combiner null-value term a next b)
    (define iter
      (lambda (a result)
	(cond ((> a b) result)
	      ((filter a) (iter (next a) (combiner (term a) result)))
	      (else (iter (next a) result)))))  ;; 此处可以(iter (next a) (combiner null-value result)), 也可以不合并, 因为合并 null-value 对 result 无影响
    (iter a null-value)))

;; -------------------------------------------------------------------------------------------------
;; a
(define prime?
  (lambda (n)
    (define times 1000)
    (define fast-prime?
      (lambda (n times)
	(cond ((= times 0) #t)
	      ((fermat-test n) (fast-prime? n (- times 1)))
	      (else #f))))
    (define fermat-test
      (lambda (n)
	(define try-it
	  (lambda (t)
	    (= (expmod t (- n 1) n) 1)))
	(try-it (+ 1 (random (- n 1))))))
    (define expmod
      (lambda (base exp m)
	(define no-trivial-sqrt?
	  (lambda (x)
	    (cond ((or (= x 1) (= x (- m 1))) #f)
		  (else (= 1(remainder (square x) m))))))
	(cond ((= exp 0) 1)
	      ((even? exp)
	       (let ((x (expmod base (/ exp 2) m)))
		 (if (no-trivial-sqrt? x)
		     0
		     (remainder (square x) m))))
	      (else
	       (remainder (* base (expmod base (- exp 1) m)) m)))))
    (fast-prime? n times)))

(define sum-primes
  (lambda (a b)
    (@filtered-accumulate prime? + 0 (lambda (x) x) a (lambda (x) (+ x 1)) b)))

;; -------------------------------------------------------------------------------------------------
;; b
(define gcd
  (lambda (a b)
    (if (= b 0)
	a
	(gcd b (remainder a b)))))

(define product-gcd
  (lambda (n)
    (@filtered-accumulate (lambda (x) (= (gcd x n) 1))
			  *
			  1
			  (lambda (x) x)
			  1
			  (lambda (x) (+ x 1))
			  (- n 1))))
