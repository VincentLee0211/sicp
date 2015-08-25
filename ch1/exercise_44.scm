#|
平滑一个函数的想法是信号处理中的一个重要概念.
如果 f 是一个函数, dx 是某个很小的数值, 那么 f 的平滑也是一个函数, 它在点 x 的值就是
f(x-dx), f(x), 和 f(x+dx) 的平均值

请写出一个过程 smooth, 它的输入是一个计算 f 的过程, 返回一个计算平滑后的 f 的过程.
有时可能发现, 重复地平滑一个函数, 得到经过 n 次平滑的函数也很有价值.
说明怎样利用 smooth 和练习43的 repeated, 对给定的函数生成 n 次平滑函数
|#

;; 平滑函数
(define smooth
  (lambda (f)
    (lambda (x)
      (/ (+ (f (- x dx))
	    (f x)
	    (f (+ x dx)))
	 3.0))))

(define dx 0.00001)

;; n次平滑
(define smooth-nth
  (lambda (f n)
    (lambda (x)
      ((repeated f n) x))))

(define repeated
  (lambda (f n)
    (lambda (x)
      (if (= n 1)
	  (f x)
	  (f ((repeated f (- n 1)) x))))))
