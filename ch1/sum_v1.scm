;; 计算从 a 到 b 的各整数之和
(define sum-integers
  (lambda (a b)
    (if (> a b)
	0
	(+ a (sum-integers (+ a 1) b)))))

(define cube (lambda (x) (* x x x)))
		     
;; 计算给定范围内的整数的立方和
(define sum-cubes
  (lambda (a b)
    (if (> a b)
	0
	(+ (cube a) (sum-cubes (+ a 1) b)))))

;; 计算序列之和
(define pi-sum
  (lambda (a b)
    (if (> a b)
	0
	(+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b)))))
