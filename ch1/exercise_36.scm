#|
请修改 fixed-point, 使它能打印出计算中产生的近似值序列, 用练习22展示的 newline 和 display 基本过程.

而后通过找出 x -> log(1000)/log(x) 的不动点的方式, 确定 x^x = 1000的一个根.

请比较一下采用平均阻尼和不用平均阻尼时的计算步数

注意: 不能用猜测1去启动 fixed-point, log(1) = 0
|#

(define fixed-point
  (lambda (f guess)
    (define try
      (lambda (guess)
	(print-line guess)
	(let ((next (f guess)))
	  (if (close-enough? guess next)
	      next
	      (try next)))))
    (define close-enough?
      (lambda (x y)
	(< (abs (- x y)) 0.00001)))
    (define print-line
      (lambda (x)
	(newline)
	(display x))) 
    (try guess)))

;; 计算 x -> log(1000)/log(x)

;; 不使用平均阻尼, 计算步数较多
(define x
  (lambda ()
    (fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)))

;; 使用平均阻尼, 步数较少
(define y
  (lambda ()
    (fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 2.0)))
