#|
Louis Reasoner 在做练习24时遇到了很大困难, 他的 fast-prime? 检查看起来运行的比他的 prime? 检查还慢
Louis 请他的朋友 Eva Lu Ator 过来帮忙. 在检查 Louis 的代码时, 两个人发现他重写了 expmod 过程, 其中用了一个显示的乘法, 而没有调用 square
|#

(define expmod
  (lambda (base exp m)
    (cond ((= exp 0) 1)
	  ((even? exp)
	   (remainder (* (expmod base (/ exp 2) m)
			 (expmod base (/ exp 2) m))
		      m))
	  (else
	   (remainder (* b (expmod base (- exp 1) m)) m)))))

#|
"我看不出来这会造成什么不同", Louis 说. "我能看出", Eval 说, "采用这种方式写出该过程时, 你就把一个 lg n 的计算过程变成 n 的了
|#

;; -------------------------------------------------------------------------------------------------

;; 在(even? ...) 分支中, 需要计算两次 (expmod ...)
;; 而原来的只需要计算一次
