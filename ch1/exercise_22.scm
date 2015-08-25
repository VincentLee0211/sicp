#|
大部分 list 实现都包含一个 runtime 基本过程, 调用它将返回一个整数, 表示系统已经运行的时间
在对整数 n 调用下面的 timed-prime-test 过程时, 将打印出 n 并检查 n 是否为素数
如果 n 是素数, 过程将打印出三个星号, 随后是执行这一检查所用的时间量
|#

(define timed-prime-test
  (lambda (n)
    (newline)
    (display n)
    (start-prime-test n (runtime))))

(define start-prime-test
  (lambda (n start-time)
    (if (prime? n)
	(report-prime (- (runtime) start-time)))))

(define report-prime
  (lambda (elapsed-time)
    (display " *** ")
    (display elapsed-time)))

#|
请利用这一过程写一个 search-for-primes 过程, 它检查给定范围内连续的各个奇数和素性
请用你的过程找出大于1000, 10000, 100000和1000000的三个最小的素数
请注意其中检查每个素数所需要时间
|#

(define search-for-primes
  (lambda (lo hi)
    (cond ((< lo hi)
	   (timed-prime-test lo)
	   (search-for-primes (+ lo 1) hi))
	  (else 'done))))

(define prime?
  (lambda (n)
    (define smallest-divisor
      (lambda (n)
	(find-divisor n 2)))
    (define find-divisor
      (lambda (n test)
	(cond ((> (square test) n) n)
	      ((divides? test n) test)
	      (else (find-divisor n (+ test 1))))))
    (define divides?
      (lambda (a b)
	(= (remainder b a) 0)))
    (= (smallest-divisor n) n)))
