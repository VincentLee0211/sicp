#|
在1737年, 瑞士数学家莱昂哈德.欧拉发表了一篇论文 De Fractionibus Continuis, 文中包含了 e - 2 的一个连分式展开, 其中的 e 是自然对数的底.
在这一分式中, Ni全都是1, 而 Di一次为1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ...

请写出一个程序, 其中使用在练习37中所做的 cont-frac 过程, 并能基于欧拉的展开式求出 e 的近似值
|#

(define cont-frac
  (lambda (fn fd k)
    (define recur
      (lambda (i)
	(if (> i k)
	    0
	    (/ (fn i)
	       (+ (fd i) (recur (+ i 1)))))))
    (recur 1)))

(define e
  (cont-frac (lambda (i) 1.0)
	     (lambda (i)
	       (if (= (remainder i 3) 2)
		   (* 2.0 (+ 1 (quotient i 3)))
		   1.0))
	     1000))
