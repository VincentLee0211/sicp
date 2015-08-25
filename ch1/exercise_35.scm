#|
请证明黄金分割率Φ是变换 x -> 1 + 1/x 的不动点

请利用这一事实, 通过过程 fixed-point 计算出 Φ 的值
|#

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
	(< (abs (- x y)) tolerance)))
    (define tolerance 0.00001)
    (try guess)))

(define h
  (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0))
