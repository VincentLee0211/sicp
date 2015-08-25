;; 求幂

;; 递归计算过程
(define @expt
  (lambda (b n)
    (if (= n 0)
	1
	(* b (@expt b (- n 1))))))

(define @fast-expt
  (lambda (b n)
    (cond ((= n 0) 1)
	  ((even? n) (square (@fast-expt b (/ n 2))))
	  (else (* b (@fast-expt b (- n 1)))))))

;; 迭代计算过程
(define &expt
  (lambda (b n)
    (define iter
      (lambda (product counter)
	(if (= counter 0)
	    product
	    (iter (* product b)
		  (- counter 1)))))
    (iter 1 n)))

