;; 函数f 由如下规则定义: 如果 n < 3, 那么 f(n) = n; 如果 n >= 3, 那么 f(n) = f(n-1) + 2f(n-2) + 3f(n-3)
;; 请写出一个采用递归计算过程计算 f 的过程. 再写一个采用迭代计算过程计算 f 的过程

;; 使用递归计算过程
(define @f
  (lambda (n)
    (if (< n 3)
	n
	(+ (@f (- n 1))
	   (* 2 (@f (- n 2)))
	   (* 3 (@f (- n 3)))))))

;; 使用迭代计算过程
(define &f
  (lambda (n)
    (define iter
      (lambda (x y z counter)
	(if (= counter 3)
	    (+ x (* 2 y) (* 3 z))
	    (iter (+ x (* 2 y) (* 3 z))
		  x
		  y
		  (- counter 1)))))
    (if (< n 3)
	n
	(iter 2 1 0 n))))
