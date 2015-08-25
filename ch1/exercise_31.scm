#|
a. 过程 sum 是可以用高阶过程表示的大量类似抽象中最简单的一个. 请写出一个类似的成为 product 的过程,
它返回在给定范围中各点的某个函数值的乘积. 请说明如何用 product 定义 factorial.

另请按照下面的公式计算 pi 的近似值
pi/4 = (2*4*4*6*6*8 ...) / (3*3*5*5*7*7 ...)

b. 如果你的 product 过程生成的是一个递归计算过程, 那么请写出一个生成迭代计算过程的过程.
   如果它生成一个迭代计算过程, 请写一个生成递归计算过程的过程
|#

(define @product
  (lambda (term a next b)
    (if (> a b)
	1
	(* (term a) (@product term (next a) next b)))))

(define &product
  (lambda (term a next b)
    (define iter
      (lambda (init result)
	(if (> init b)
	    result
	    (iter (next init) (* (term init) result)))))
    (iter a 1)))

;; ------------------------------------------------------------------------------------------------

(define pi.v1
  (lambda (n)
    (@product (lambda (x)
		(if (even? x)
		    (/ (+ x 2) (+ x 1))
		    (/ (+ x 1) (+ x 2))))
	      1
	      (lambda (x) (+ x 1))
	      n)))

(define pi.v2
  (lambda (n)
    (&product (lambda (x)
		(if (even? x)
		    (/ (+ x 2) (+ x 1))
		    (/ (+ x 1) (+ x 2))))
	      1
	      (lambda (x) (+ x 1))
	      n)))
