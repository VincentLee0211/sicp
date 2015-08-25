;; 找出函数不动点

(define tolerance 0.00001)

(define fixed-point
  (lambda (f guess)
    (define try
      (lambda (guess)
	(let ((next (f guess)))
	  (if (close-enough? guess next)
	      next
	      (try next)))))
    (define close-enough?
      (lambda (v1 v2)
	(< (abs (- v1 v2)) tolerance)))
    (try guess)))

(fixed-point cos 1.0)

(fixed-point (lambda (y) (+ (sin y) (cos y)))
	     1.0)

#|
(define sqrt
  (lambda (x)
    (fixed-point (lambda (y) (/ x y))
		 1.0)))
|#

(define sqrt
  (lambda (x)
    (fixed-point (lambda (y) (average y (/ x y)))
		 1.0)))

(define average
  (lambda (x y)
    (/ (+ x y) 2)))


	    
