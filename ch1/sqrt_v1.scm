;; 使用牛顿法求值平方根

(define sqrt-iter
  (lambda (guess x)
    (if (good-enough? guess x)
	guess
	(sqrt-iter (improve guess x)
		   x))))

(define improve
  (lambda (guess x)
    (average guess (/ x guess))))

(define average
  (lambda (x y)
    (/ (+ x y) 2)))

(define good-enough?
  (lambda (guess x)
    (< (abs (- (square guess) x)) 0.0001)))

(define sqrt
  (lambda (x)
    (sqrt-iter 1.0 x)))
