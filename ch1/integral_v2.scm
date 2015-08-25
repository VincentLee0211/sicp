;; 求出函数 f 在范围 a 和 b 之间的定积分的近似值

(define sum
  (lambda (term a next b)
    (if (> a b)
	0
	(+ (term a)
	   (sum term (next a) next b)))))

(define integral
  (lambda (f a b dx)
    (* dx
       (sum f
	    (+ a (/ dx 2.0))
	    (lambda (x) (+ x dx))
	    b))))
