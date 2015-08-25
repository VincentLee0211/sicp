;; 计算 n!

;; 使用递归计算过程
;; n! = n * (n - 1)!
(define factorial.v1
  (lambda (n)
    (if (= n 1)
	1
	(* n (factorial.v1 (- n 1))))))

;; 使用迭代计算过程
;; n! = 1 * 2 * 3 ... * n
;; a = 1 b = 1
;; a = 1 b = 2
;; a = 2 b = 3
(define factorial.v2
  (lambda (n)
    (define iter
      (lambda (product counter)
	(if (= counter n)
	    (* product counter)
	    (iter (* product counter)
		  (+ counter 1)))))
    (iter 1 1)))

;; or
#|
(define factorial.v2
  (lambda (n)
    (define iter
      (lambda (product counter)
	(if (> counter n)
	    product
	    (iter (* product counter)
		  (+ counter 1)))))
    (iter 1 1)))
|#
