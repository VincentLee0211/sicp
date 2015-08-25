;; 求立方根的牛顿法基于如下事实, 如果 y 是 x 的立方根的一个近似值, 那么下式将给出一个更好的近似值

;; (x / y ^ 2 + 2 * y) / 3

;; 请利用这一公式实现一个类似平方根过程的求立方根的过程

(define cube-root
  (lambda (x)
    (define cube-iter
      (lambda (guess)
	(let ((next-guess (improve guess)))
	  (if (good-enough? guess next-guess)
	      next-guess
	      (cube-iter next-guess)))))
    (define good-enough?
      (lambda (guess next-guess)
	(< (abs (- 1.0 (/ guess next-guess))) 0.001)))
    (define improve
      (lambda (guess)
	(/ (+ (/ x (square guess))
	      (* 2 guess))
	   3)))
    (cube-iter 1.0)))
