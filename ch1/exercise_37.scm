#|
a.
一个无穷连分式是一个如下形式的表达式:
f = N1 / (D1 + N2/ (D2 + N3/ (D3 + ...)))
作为一个例子, 我们可以证明在所有的 Ni 和 Di 都等于1时, 这一无穷连分式产生出1/O, 其中的 O 就是黄金分割率.
逼近某个无穷连分式的一种方法是在给定数目的项之后截断, 这样的一个截断成为 k 项有限连分式, 其形式是:
N1/ (D1 + N2/ (D2 + N3/ (D3 + ... + NK/ DK)))
假定 n 和 d 都是只有一个参数的过程, 它们分别返回连分式的项 Ni 和 Di
请定义一个过程 cont-frac, 使得对(cont-frac n d k)的求值计算出 k 项有限连分式的值
通过如下调用检查你的过程对于顺序的 k 值是否逼近1/O:

(cont-frac (lambda (i) 1.0)
	   (lambda (i) 1.0)
	   k)

你需要取多大的 k 才能保证得到的近似值具有十进制的4位精度?

b.
如果你的过程产生一个递归计算过程, 那么请写另一个产生迭代计算的过程.
如果它产生迭代计算, 请写出另一个过程, 使之产生一个递归计算过程
|#

#|
(define &cont-frac
  (lambda (fn fd k)
    (define iter
      (lambda (index result)
	(if (= index 1)
	    result
	    (iter (- index 1)
		  (/ (fn (- index 1))
		     (+ (fd (- index 1)) result))))))
    (iter k (/ (fn k) (fd k))))) 
|#

(define &cont-frac
  (lambda (fn fd k)
    (define iter
      (lambda (index result)
	(if (= index 0)
	    result
	    (iter (- index 1)
		  (/ (fn index)
		     (+ (fd index) result))))))
    (iter k 0.0)))

#|
(define @cont-frac
  (lambda (fn fd k)
    (define recur
      (lambda (index)
	(if (= index k)
	    (/ (fn index) (fd index))
	    (/ (fn index)
	       (+ (fd index) (recur (+ index 1)))))))
    (recur 1)))
|#

(define @cont-frac
  (lambda (fn fd k)
    (define recur
      (lambda (index)
	(if (> index k)
	    0
	    (/ (fn index)
	       (+ (fd index) (recur (+ index 1)))))))
    (recur 1)))
