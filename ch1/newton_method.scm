;; 牛顿法求值不动点

;; 对函数求导
(define deriv
  (lambda (g)
    (lambda (x)
      (/ (- (g (+ x dx)) (g x))
	 dx))))

(define dx 0.00001)

;; 通过牛顿转换, 变为求函数不动点
(define newton-transform
  (lambda (g)
    (lambda (x)
      (- x (/ (g x) ((deriv g) x))))))

(define newton-method
  (lambda (g guess)
    (fixed-point (newton-transform g) guess)))

;; 求函数不动点
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
	(< (abs (- x y)) dx)))
    (try guess)))

;; 应用
(define sqrt
  (lambda (x)
    (newton-method (lambda (y) (- (square y) x)) 1.0)))
