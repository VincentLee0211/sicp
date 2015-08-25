;; 第一级过程

;; 描述具有普遍性的思想表述为一个函数
(define fixed-point-of-transform
  (lambda (g transform guess)
    (fixed-point (transform g) guess)))

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

;; 平均阻尼
(define sqrt.v1
  (lambda (x)
    (fixed-point-of-transform (lambda (y) (/ x y))
			      average-damp
			      1.0)))

(define average-damp
  (lambda (f)
    (lambda (x)
      (average x (f x)))))

(define average
  (lambda (x y)
    (/ (+ x y) 2)))

;; 牛顿转换
(define sqrt.v2
  (lambda (x)
    (fixed-point-of-transform (lambda (y) (- (square y) x))
			      newton-transform
			      1.0)))

(define newton-transform
  (lambda (g)
    (lambda (x)
      (- x (/ (g x) ((deriv g) x))))))

(define deriv
  (lambda (g)
    (lambda (x)
      (/ (- (g (+ x dx)) (g x)) dx))))

(define dx 0.00001)
