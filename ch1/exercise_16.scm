;; 请定义一个过程, 它能产生出一个按照迭代方式的求幂计算过程, 其中使用一系列的求平方, 就像一样 fast-expt 只用对数个步骤那样

(define &fast-expt
  (lambda (b n)
    (define iter
      (lambda (a product counter)
	(cond ((= counter 0) a)
	      ((even? counter) (iter a (square product) (/ counter 2)))
	      (else (iter (* a product) product (- counter 1))))))
    (iter 1 b n)))
