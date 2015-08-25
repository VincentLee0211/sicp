#|
在本节开始时给出的那个 smallest-divisor 过程做了许多无用检查: 在它检查了一个数是否能被2整除之后, 实际上已经完全没必要再他是否能被任何偶数整除了, 这说明 test-divisor 所用的值不应该是2, 3, 4, 5, 6 ...
而是2, 3, 5, 7, 9 ..., 请实现这种修改, 其中应定义一个过程 next, 用2 调用时返回3, 否则就返回其输入值加2
修改 smallest-divisor 过程, 使它去使用 (next test-divisor) 而不是 (+ test-divisor 1)
让 timed-prime-test 结合这个 smallest-divisor 版本, 运行练习22里的12个找素数的检测
因为这一修改使检查的步数减少了一半, 你可能期望它的运行速度快一倍
实际情况复合这一预期吗?如果不符合, 你所观察到的两个算法速度的比值是什么?你如何解释这一比值不是2的事实?
|#

(define prime?
  (lambda (n)
    (define smallest-divisor
      (lambda (n)
	(find-divisor n 2)))
    (define find-divisor
      (lambda (n test)
	(cond ((> (square test) n) n)
	      ((divides? test n) test)
	      (else (find-divisor n (next test))))))
    (define divides?
      (lambda (a b)
	(= (remainder b a) 0)))
    (define next
      (lambda (n)
	(if (= n 2)
	    3
	    (+ n 2))))
    (= n (smallest-divisor n))))

(define times-prime-test
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

(define search-for-primes
  (lambda (lo hi)
    (cond ((< lo hi)
	   (times-prime-test lo)
	   (search-for-primes (+ lo 1) hi))
	  (else 'done))))
