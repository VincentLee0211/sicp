;; 求平方根, 引入块结构和词法作用域

(define sqrt
  (lambda (x)
    (define sqrt-iter
      (lambda (guess)
	(let ((next-guess (improve guess)))
	  (if (good-enough? guess next-guess)
	      next-guess
	      (sqrt-iter next-guess)))))
    (define good-enough?
      (lambda (guess next-guess)
	(< (abs (- 1.0 (/ guess next-guess))) 0.0001)))
    (define improve
      (lambda (guess)
	(average guess (/ x guess))))
    (sqrt-iter 1.0)))

(define average
  (lambda (x y)
    (/ (+ x y) 2)))
