;; 换零钱

;; 使用递归计算过程
;;
;; 1. 将现金数 a 换成除第一种硬币之外的所有其他硬币的不同方式数目
;; 2. 将现金数 a-d 换成所有种类的硬币的不同方式数目, 其中的 d 是第一种硬币的价值
;;
;; 规约规则
;; 1. 如果 a 就是 0, 应该算作是有 1 种换零钱的方式
;; 2. 如果 a 小于 0, 应该算作是有 0 种换零钱的方式
;; 3. 如果 n 是 0, 应该算作有 0 种换零钱的方式
(define count-change.v1
  (lambda (amount)
    (define cc
      (lambda (amount kinds-of-coins)
	(cond ((= amount 0) 1)
	      ((or (< amount 0) (= kinds-of-coins 0)) 0)
	      (else (+ (cc amount (- kinds-of-coins 1))
		       (cc (- amount (first-denomination kinds-of-coins))
			   kinds-of-coins))))))
    (define first-denomination
      (lambda (kinds-of-coins)
	(cond ((= kinds-of-coins 1) 1)
	      ((= kinds-of-coins 2) 5)
	      ((= kinds-of-coins 3) 10)
	      ((= kinds-of-coins 4) 25)
	      ((= kinds-of-coins 5) 50))))
    (cc amount 5)))

;; 使用迭代计算过程
(define count-chagne.v2 'unknown)
