#|
在1.3.3节里, 我们看到企图用朴素的方法去找 y -> x/y 的不动点, 以便计算平方根的方式不收敛, 这个缺陷可以通过平均阻尼的方式弥补.
同样方法也可用于找立方根, 将它看做是平均阻尼后的 y -> x/y^2 的不动点.
遗憾的是, 这一计算过程对于四次方根却行不通, 一次平均阻尼不足以使对 y -> x/y^3 的不动点搜寻收敛.
而在另一方面, 如果求两次平均阻尼, 这一不动点搜寻就会收敛了.

请做一些实验, 考虑将计算 n 次方根作为基于 y -> x/y^(n-1) 的反复做平均阻尼的不动点搜寻过程, 
请设法确定各种情况下需要座多少次平均阻尼. 
并请基于这一认识实现一个过程, 它使用 fixed-point, average-damp, 和练习43的 repeated 过程计算 n 次方根.
|#

;; 辅助函数
(define fixed-point
  (lambda (f guess)
    (define try
      (lambda (guess)
	(let ((next (f guess)))
	  (if (close-enough? guess next)
	      next
	      (try next)))))
    (define close-enough?
      (lambda (x y)
	(< (abs (- x y)) 0.00001)))
    (try guess)))

(define average-damp
  (lambda (f)
    (lambda (x)
      (average x (f x)))))

(define average
  (lambda (x y)
    (/ (+ x y) 2)))

(define repeated
  (lambda (f n)
    (lambda (x)
      (if (= n 1)
	  (f x)
	  (f ((repeated f (- n 1)) x))))))

;; 实验
(define sqrt_2
  (lambda (x)
    (fixed-point (average-damp (lambda (y) (/ x y))) 1.0)))

(define sqrt_3
  (lambda (x)
    (fixed-point (average-damp (lambda (y) (/ x (expt y 2)))) 1.0)))

#|
(define sqrt_4
  (lambda (x)
    (fixed-point (average-damp (lambda (y) (/ x (expt y 3)))) 1.0)))
|#

(define sqrt_4
  (lambda (x)
    (fixed-point ((repeated average-damp 2) (lambda (y) (/ x (expt y 3)))) 1.0)))

(define sqrt_7
  (lambda (x)
    (fixed-point ((repeated average-damp 2) (lambda (y) (/ x (expt y 6)))) 1.0)))

#|
(define sqrt_8
  (lambda (x)
    (fixed-point ((repeated average-damp 2) (lambda (y) (/ x (expt y 7)))) 1.0)))
|#

(define sqrt_8
  (lambda (x)
    (fixed-point ((repeated average-damp 3) (lambda (y) (/ x (expt y 7)))) 1.0)))

(define sqrt_15
  (lambda (x)
    (fixed-point ((repeated average-damp 3) (lambda (y) (/ x (expt y 14)))) 1.0)))

#|
(define sqrt_16
  (lambda (x)
    (fixed-point ((repeated average-damp 3) (lambda (y) (/ x (expt y 15)))) 1.0)))
|#

(define sqrt_16
  (lambda (x)
    (fixed-point ((repeated average-damp 4) (lambda (y) (/ x (expt y 15)))) 1.0)))

#|
2  ~  3  : 1
4  ~  7  : 2
8  ~ 15  : 3

log (2) (x)  = log (x) / log (2)  向下取整
|#

(define repeated-times
  (lambda (x)
    (floor (/ (log x) (log 2)))))

(define root-nth
  (lambda (x n)
    (fixed-point ((repeated average-damp (repeated-times n))
		  (lambda (y) (/ x (expt y (- n 1)))))
		 1.0)))
