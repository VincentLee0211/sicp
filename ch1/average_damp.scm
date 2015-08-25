;; 过程作为返回值

;; 平均阻尼
(define average
  (lambda (x y)
    (/ (+ x y) 2)))

(define average-damp
  (lambda (f)
    (lambda (x)
      (average x (f x)))))

;; 使用平均阻尼求平方根
(define sqrt
  (lambda (x)
    (fixed-point (average-damp (lambda (y) (/ x y))) 1.0)))

(define cube-root
  (lambda (x)
    (fixed-point (average-damp (lambda (y) (/ x (square y)))) 1.0)))

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
	(< (abs (- x y)) 0.0001)))
    (try guess)))
