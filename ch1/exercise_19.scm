#|
存在着一种以对数步数求出斐波那契数的巧妙算法
回忆 fib-iter 计算过程中状态变量 a 和 b 的交换规则, a <- a + b 和 b <- a
现在将这种变换称为 T 变换
通过观察可以发现, 从1和0开始将 T 反复应用 n 次, 将产生出一对数 Fib(n+1) 和 Fib(n)
换句话说, 斐波那契数可以通过将 T(n)应用于对偶(1, 0)而产生出来
现在将 T 看做是变换簇 T(pq) 中 p = 0 且 q = 1 的特殊情况, 其中 T(pq) 是对于对偶(a, b)按照 a <- bq + aq + ap 和 b <- bp + aq 规则的变换
请证明, 如果我们应用变换 T(pq) 两次, 其效果等同于应用同样形式的一次变换 T(p'q'), 其中的 p' 和 q' 可以由 p 和 q 计算出来. 这就指名了一条求出这种变换的平方的路径, 是我们可以通过连续求平方的方式去计算 T(n), 就像 fast-expt 过程里所做的那样
将所有这些集中到一起, 就形成了下面的过程, 其运算只需要对数的步数
|#

(define fib
  (lambda (n)
    (define iter
      (lambda (a b p q count)
	(cond ((= count 0) b)
	      ((even? count)
	       (iter a
		     b
		     (+ (square p) (square q))
		     (+ (square q) (* 2 p q))
		     (/ count 2)))
	      (else
	       (iter (+ (* b q) (* a q) (* a p))
		     (+ (* b p) (* a q))
		     p
		     q
		     (- count 1))))))
    (iter 1 0 0 1 n)))

;; 第一次变换
;; a <- bq + aq + ap
;; b <- bp + aq
;;
;; 第二次变换
;; a <- (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
;;   <- b(q^2 + 2pq) + a(q^2 + 2pq) + a(p^2 + q^2)
;; b <- (bp + aq)p + (bq + aq + ap)q
;;   <- b(p^2 + q^2) + a(q^2 + 2pq)
