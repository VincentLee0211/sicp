#|
请定义一个过程 cubic, 它和 newtons-method 过程一起使用在下面形式的表达式里

(newtons-method (cubic a b c) 1)

能逼近三次方程 x^3 + ax^2 + bx + c 的零点
|#

(define cubic
  (lambda (a b c)
    (lambda (x)
      (+ (* x x x)
	 (* a (square x))
	 (* b x)
	 c))))
