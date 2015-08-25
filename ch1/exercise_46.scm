#|
本章描述的一些数值算法都是迭代式改进的实例.迭代式改进是一种非常具有一般性的计算策略, 它说的是:
  为了计算出某些东西, 我们可以从对答案的某个初始猜测开始, 检查这一猜测是否足够好, 如果不行就改进这一猜测, 将改进之后的猜测作为新的猜测去继续这一计算过程

请写一个过程 iterative-improve, 它以两个过程作为参数:
  其中之一表示告知某一猜测是否足够好的方法, 另一个表示改进猜测的方法

iterative-improve 的返回值应该是一个过程, 它以某一个猜测为参数, 通过不断改进, 直至得到的猜测足够好为止.
利用 iterative-improve 重写上节的 sqrt 过程和 fixed-point 过程
|#

(define iterative-improve
  (lambda (good-enough improve)
    (lambda (guess)
      (let ((next (improve guess)))
	(if (good-enough guess next)
	    next
	    ((iterative-improve good-enough improve) next))))))

(define sqrt
  (lambda (x)
    ((iterative-improve (lambda (v1 v2)
			  (< (abs (- v1 v2)) 0.00001))
			(lambda (g)
			  (average g (/ x g))))
     1.0)))

(define fixed-point
  (lambda (f guess)
    ((iterative-improve (lambda (v1 v2)
			  (< (abs (- v1 v2)) 0.00001))
			(lambda (g)
			  (average g (f g))))
     guess)))

;; 测试
(sqrt 2)

(fixed-point cos 1.0)
