#|
费马检查的一种不会被欺骗的变形称为 Miller-Rabin 检查, 它来源于费马小定理的一个变形. 这一变形断言, 
如果 n 是素数, a 是任何小于 n 的整数, 则 a 的 (n-1) 次幂与 1 模 n 同余. 要用 Miller-Rabin 检查考察
数 n 的素性, 我们应随机地取一个数 a < n 并用过程 expmod 求 a 的 (n-1) 次幂对 n 的模. 然而, 在执行
expmod 中的平方步骤时, 我们需要查看是否遇到了"1取模 n 的非平凡平方根", 也就是说, 是不是存在不等于1
或者 n-1 的数, 其平方根取模 n 等于 1. 可以证明, 如果1的这种非平凡平方根存在, 那么 n 就不是素数.
还可以证明, 如果 n 是非素数的奇数, 那么, 至少有一半的数 a < n, 按照这种方式计算 a^(n-1), 将会遇到1
取模 n 的非平凡平方根. 这也是 Miller-Rabin 检查不会受骗的原因. 请修改 expmod 过程, 让它在发现1的非
平凡平方根时报告失败, 并利用它实现一个类似 fermat-test 的过程, 完成 Miller-Rabin 检查. 通过检查一些
已知素数和非素数的方式考验你的过程. 
|#

(define prime?
  (lambda (n times)
    (cond ((= times 0) #t)
	  ((fermat-test n) (prime? n (- times 1)))
	  (else #f))))

(define fermat-test
  (lambda (n)
    (define try-it
      (lambda (t)
	(= 1 (expmod t (- n 1) n))))
    (try-it (+ 1 (random (- n 1))))))

(define expmod
  (lambda (base exp m)
    (cond ((= exp 0) 1)
	  ((even? exp)
	   (let ((x (expmod base (/ exp 2) m)))
	     (if (no-trivial-sqrt? x m)
		 0
		 (remainder (square x) m))))
	  (else
	   (remainder (* base (expmod base (- exp 1) m)) m)))))

(define no-trivial-sqrt?
  (lambda (x m)
    (cond ((or (= x 1) (= x (- m 1))) #f)
	  (else (= (remainder (square x) m) 1)))))
