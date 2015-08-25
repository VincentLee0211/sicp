#|
正切函数的连分式表示由德国数学家 J.H. Lambert 在1770年发表:

tan x = x/ (1 - x^2/ (3 - x^2/ (5 - ...)))

其中 x 表示弧度.

请计算过程 (tan-cf x k), 它基于 Lambert 公式计算正切函数的近似值.
k 描述的是计算的项数.
|#

(define cont-frac
  (lambda (fn fd k)
    (define iter
      (lambda (i result)
	(if (= i 0)
	    result
	    (iter (- i 1)
		  (/ (fn i)
		     (+ (fd i) result))))))
    (iter k 0.0)))

(define tan-cf
  (lambda (x k)
    (cont-frac (lambda (i)
		 (if (= i 1)
		     x
		     (- (square x))))
	       (lambda (i)
		 (- (* 2 i) 1))
	       k)))
