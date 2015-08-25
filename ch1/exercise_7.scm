#|
对于确定很小的数的平方根而言, 在计算平方根中使用的检测 good-enough?是很不好的.
还有, 在现实的计算机里, 算术运算总是以一定的有限精度进行的.
这也会使我们的检测不适合非常大的数的计算.
请解释上述论断, 用例子说明对很小和很大的数, 这种检测都可能失败.
实现 good-enough? 的另一种测咯是监视猜测值在从一次迭代到下一次的变化情况,
当改变值相对于猜测值的比率很小时就结束.
请设计一个采用这个终止测试方式的平方根过程. 
对于很大和很小的数, 这一方式能工作吗?
|#

(define average
  (lambda (x y)
    (/ (+ x y) 2)))

(define sqrt.v1
  (lambda (x)
    (define sqrt-iter
      (lambda (guess)
	(if (good-enough? guess)
	    guess
	    (sqrt-iter (improve guess)))))
    (define good-enough?
      (lambda (guess)
	(< (abs (- (square guess) x)) 0.001)))
    (define improve
      (lambda (guess)
	(average guess (/ x guess))))
    (sqrt-iter 1.0)))

(define sqrt.v2
  (lambda (x)
    (define sqrt-iter
      (lambda (guess)
	(let ((next-guess (improve guess)))
	  (if (good-enough? guess next-guess)
	      next-guess
	      (sqrt-iter next-guess)))))
    (define good-enough?
      (lambda (guess next-guess)
	(< (abs (- 1.0 (/ guess next-guess))) 0.001)))
    (define improve
      (lambda (guess)
	(average guess (/ x guess))))
    (sqrt-iter 1.0)))


;; 当数非常大时
;; (sqrt.v1 1000000000000)
;; (sqrt.v1 1000000000000)
;; 可以正常求值

;; (sqrt.v1 10000000000000)   无法停机
;; (sqrt.v2 10000000000000)   可以正常工作


;; 当数非常小时
;; (sqrt.v1 0.0000000000001)  数值比精确度还小, 无法正常结束
;; (sqrt.v2 0.0000000000001)

