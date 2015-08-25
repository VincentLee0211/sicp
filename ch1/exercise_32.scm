#|
a. 请说明, sum 和 product 都是另一称为 accumulate 的更一般概念的特殊情况, accumulate 使用某些一般性的累积函数组合起一系列项:
   (accumulate combiner null-value term a next b)
   
accumulate 取的是与 sum 和 product 一样的项和范围描述参数, 再加上一个 combiner 过程, 它描述如何将当前项与前面各项的积累结果组合起来, 另外还有一个 null-value 参数, 它描述在所有的项都用完时的基本值.

请写出 accumulate, 并说明我们能怎样基于简单地调用 accumulate, 定义出 sum 和 product

b. 如果你的 accumulate 过程生成的是一个递归计算过程, 那么请写出一个生成迭代计算过程的过程.
   如果它生成的一个迭代计算过程, 请写一个生成递归计算过程的过程
|#

(define @accumulate
  (lambda (combiner null-value term a next b)
    (if (> a b)
	null-value
	(combiner (term a)
		  (@accumulate combiner null-value term (next a) next b)))))

(define &accumulate
  (lambda (combiner null-value term a next b)
    (define iter
      (lambda (a result)
	(if (> a b)
	    result
	    (iter (next a) (combiner (term a) result)))))
    (iter a null-value)))
