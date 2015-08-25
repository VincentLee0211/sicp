;; 利用练习16和17的结果设计一个过程, 它能产生一个基于加, 加倍和折半运算的迭代计算过程, 只用对数的步数就能求出两个整数的乘积

(define double (lambda (n) (* 2 n)))

(define halve (lambda (n) (/ n 2)))

(define &fast-*
  (lambda (a b)
    (define iter
      (lambda (a sumer counter)
	(cond ((= counter 0) a)
	      ((even? counter) (iter a (double sumer) (halve counter)))
	      (else (iter (+ a sumer) sumer (- counter 1))))))
    (iter 0 a b)))
