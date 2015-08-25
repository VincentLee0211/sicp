;; 基于高阶过程描述`求和`的概念

(define inc (lambda (x) (+ x 1)))

(define identity (lambda (x) x))

(define sum
  (lambda (term a next b)
    (if (> a b)
	0
	(+ (term a)
	   (sum term (next a) next b)))))

;; 计算从 a 到 b 的各整数之和
(define sum-integers
  (lambda (a b)
    (sum identity a inc b)))

;; 计算给定范围内的整数的立方之和
(define sum-cubes
  (lambda (a b)
    (sum cube a inc b)))

;; 计算序列之和
(define pi-sum
  (lambda (a b)
    (define pi-term
      (lambda (x)
	(/ 1.0 (* x (+ x 2)))))
    (define pi-next
      (lambda (x)
	(+ x 4)))
    (sum pi-term a pi-next b)))
