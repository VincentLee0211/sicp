;; 计算 fib

;; 使用递归计算过程
(define fib.v1
  (lambda (n)
    (cond ((= n 0) 0)
	  ((= n 1) 1)
	  (else (+ (fib.v1 (- n 1))
		   (fib.v1 (- n 2)))))))

;; 使用迭代计算过程
(define fib.v2
  (lambda (n)
    (define iter
      (lambda (a b count)
	(if (= count 0)
	    b
	    (iter (+ a b)
		  a
		  (- count 1)))))
    (iter 1 0 n)))
