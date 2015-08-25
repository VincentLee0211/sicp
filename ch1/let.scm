;; 使用 let 重建局部变量

;; 计算函数 f(x, y) = x(1+xy)^2 + y(1-y) + (1+xy)(1-y)

;; 可以表述为
;; a = 1 + xy
;; b = 1 - y
;; f(x, y) = xa^2 + yb + ab

;; 利用辅助过程去约束局部变量
(define f.v1
  (lambda (x y)
    (define helper
      (lambda (a b)
	(+ (* x (square a))
	   (* y b)
	   (* a b))))
    (helper (+ 1 (* x y))
	    (- 1 y))))

;; 使用 lambda 表达式, 描述约束局部变量的匿名过程
(define f.v2
  (lambda (x y)
    ((lambda (a b)
       (+ (* x (square a))
	  (* y b)
	  (* a b)))
     (+ 1 (* x y))
     (- 1 y))))

;; 使用 let, 简化上面的过程
(define f.v3
  (lambda (x y)
    (let ((a (+ 1 (* x y)))
	  (b (- 1 y)))
      (+ (* x (square a))
	 (* y b)
	 (* a b)))))
	     
    
