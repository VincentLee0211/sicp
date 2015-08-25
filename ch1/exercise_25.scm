;; Alyssa P. Hacker 提出, 在写 expmod 时我们做了过多的额外工作. 她说, 毕竟我们已经知道怎么计算乘幂, 因此只需要简单地写:

(define expmod
  (lambda (base exp m)
    (remainder (fast-expt base exp) m)))

;; 她说的对吗? 这一过程能很好地应用于我们的快速素数检查程序吗? 请解释这些问题.

(define fast-expt
  (lambda (b n)
    (cond ((= n 0) 1)
	  ((even? n) (square (fast-expt b (/ n 2))))
	  (else (* b (fast-expt b (- n 1)))))))

;; 可以这样做
;;
;; 不能, 因为 base^exp 直接计算可能会是一个很大的数
;; 当大数计算的时候, 耗时会很严重
