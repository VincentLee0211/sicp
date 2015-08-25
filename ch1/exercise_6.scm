;; Alyssa P. Hacker 看不出为什么需要将 if 提供为一种特殊形式, 她问: "为什么我不能直接通过 cond 将它定义为一个常规过程呢? Alyssa 的朋友 Eva Lu Ator 断言确实可以这样做, 并定义了 if 的一个新版本:

(define new-if
  (lambda (predicate then-clause else-clause)
    (cond (predicate then-clause)
	  (else else-clause))))

;; Eva 给 Alyssa 演示她的程序:

(new-if (= 2 3) 0 5)

(new-if (= 1 1) 0 5)

;; 她很高兴地用自己的 new-if 重写了求平方根的程序:

(define sqrt-iter
  (lambda (guess x)
    (new-if (good-enough? guess x)
	    guess
	    (sqrt-iter (improve guess x)
		       x))))

;; 当 Alyssa 试着用这个过程去计算平方根时会发生什么事情呢?

;; --------------------------------------------------------------------------------------------------

;; 如果是 if
;; 应用特殊求值规则
;; 传递进去的 predicate, then-clause, else-clause 不会同时求值


;; 如果是 new-if
;; 应用`应用序`求值规则
;; 传递进去的 predicate, then-clause, else-clause 需要同时求值
;; 在 else-clause 求值时, 无法停机
