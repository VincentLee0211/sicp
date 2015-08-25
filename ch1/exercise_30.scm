#|
上面的过程 sum 将产生出一个线性递归. 我们可以重写该过程, 使之能够迭代地执行.

请说明应该怎样通过填充下面定义中缺少的表达式, 完成这一工作.

(define sum
  (lambda (term a next b)
    (define iter
      (lambda (a result)
        (if ...
	    ...
	    (iter ... ...))))
    (iter ... ...)))
|#

(define sum
  (lambda (term a next b)
    (define iter
      (lambda (a result)
	(if (> a b)
	    result
	    (iter (next a) (+ (term a) result)))))
    (iter a 0)))

;; 计算从 a 到 b 的各整数之和
(define sum-integers
  (lambda (a b)
    (sum (lambda (x) x) a (lambda (x) (+ x 1)) b)))

;; 计算给定范围内的整数的立方之和
(define sum-cubes
  (lambda (a b)
    (sum (lambda (x) (* x x x)) a (lambda (x) (+ x 1)) b)))

;; 计算序列之和
(define pi-sum
  (lambda (a b)
    (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
	 a
	 (lambda (x) (+ x 4))
	 b)))

