;; 使用 smallest-divisor 过程找出下面个数的最小因子: 199, 1999, 19999

(define smallest-divisor
  (lambda (n)
    (define find-divisor
      (lambda (n test)
	(cond ((> (square test) n) n)
	      ((divides? test n) test)
	      (else (find-divisor n (+ test 1))))))
    (define divides?
      (lambda (a b)
	(= (remainder b a) 0)))
    (find-divisor n 2)))

(smallest-divisor 199)

(smallest-divisor 1999)

(smallest-divisor 19999)
