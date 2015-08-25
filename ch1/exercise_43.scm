#|
如果 f 是一个数值函数, n 是一个正整数, 那么我们可以构造出 f 的 n 次重复应用, 将其定义为一个函数,
这个函数在 x 的值是 f(f(...(f(x))))

举例说, 如果 f 是函数 x -> x + 1, n 次重复应用 f 就是函数 x -> x + n

如果 f 是求一个数的平方的操作, n 次重复应用 f 就求出其参数的2^n 次幂

请写出一个过程, 它的输入是一个计算 f 的过程和一个正整数 n, 返回的是能计算 f 的 n 次重复应用的那个函数.

你的过程应该能以如下方式使用:

((repeated square 2) 5)
625
|#

(define repeated
  (lambda (f n)
    (lambda (x)
      (if (= n 1)
	  (f x)
	  (f ((repeated f (- n 1)) x))))))

((repeated square 2) 5)
