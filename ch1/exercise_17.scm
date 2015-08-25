;; 本节里的求幂算法就是通过反复做乘法去求乘幂. 与此类似, 也可以通过反复做加法的方式求出乘积
;; 下面的乘积过程与 expt 过程类似

(define @*
  (lambda (a b)
    (if (= b 0)
	0
	(+ a (@* a (- b 1))))))

;; 这一算法居右相当于 b 的线性步数. 现在假定除了加法之外还有运算 double, 它能求出一个整数的两倍
;; 还有 halve, 它将一个(偶数) 除以2
;; 请用这些运算设计一个类似 fast-expt 的求乘积过程, 使之只用对数的计算步数

(define double (lambda (n) (* 2 n)))

(define halve (lambda (n) (/ n 2)))

(define @fast-*
  (lambda (a b)
    (cond ((= b 0) 0)
	  ((even? b) (@fast-* (double a) (halve b)))
	  (else (+ a (@fast-* a (- b 1)))))))
