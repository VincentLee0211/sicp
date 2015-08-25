;; 通过区间折半寻找方程的根

(define average
  (lambda (x y)
    (/ (+ x y) 2)))

(define search
  (lambda (f neg-point pos-point)
    (let ((mid-point (average neg-point pos-point)))
      (if (close-enough? neg-point pos-point)
	  mid-point
	  (let ((test-value (f mid-point)))
	    (cond ((positive? test-value)
		   (search f neg-point mid-point))
		  ((negative? test-value)
		   (search f mid-point pos-point))
		  (else mid-point)))))))

(define close-enough?
  (lambda (x y)
    (< (abs (- x y)) 0.0001)))

(define half-interval-method
  (lambda (f a b)
    (let ((a-value (f a))
	  (b-value (f b)))
      (cond ((and (negative? a-value) (positive? b-value))
	     (search f a b))
	    ((and (negative? b-value) (positive? a-value))
	     (search f b a))
	    (else (error "Values are not of opposite sign" a b))))))
