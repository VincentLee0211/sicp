;; 求出函数 f 在范围 a 和 b 之间的定积分的近似值

(define integral
  (lambda (f a b dx)
    (define add-dx
      (lambda (x)
	(+ x dx)))
    (* (sum f (+ a (/ dx 2.0)) add-dx b) dx)))

(define sum
  (lambda (term a next b)
    (if (> a b)
	0
	(+ (term a)
	   (sum term (next a) next b)))))
