;; 序列作为一种约定界面

;; 计算值为奇数的叶子的平方和
;;
;; 步骤
;; 1. 枚举出一棵树的树叶
;; 2. 过滤它们, 选出其中的奇数
;; 3. 对选出的每一个数求平方
;; 4. 用 + 累积起得到的结构, 从 0 开始
(define sum-odd-squares
  (lambda (tree)
    (cond ((null? tree) 0)
          ((not (pair? tree))
           (if (odd? tree)
               (square tree)
               0))
          (else (+ (sum-odd-squares (car tree))
                   (sum-odd-squares (cdr tree)))))))

;; 构造出所有偶数的斐波那契表
;;
;; 步骤
;; 1. 枚举出从 0 到 n 的整数
;; 2. 对每个整数计算相应的斐波那契数
;; 3. 过滤它们, 选出其中的偶数
;; 4. 用 cons 累积得到的结果, 从空表开始
(define even-fibs
  (lambda (n)
    (define next
      (lambda (k)
        (if (> k n)
            '()
            (let ((f (fib k)))
              (if (even? f)
                  (cons f (next (inc k)))
                  (next (inc k)))))))
    (next 0)))

(define inc (lambda (x) (+ x 1)))

(define one? (lambda (x) (= x 1)))

(define zero? (lambda (x) (= x 0)))

(define fib
  (lambda (n)
    (cond ((= n 0) 0)
          ((= n 1) 1)
          (else (+ (fib (- n 1))
                   (fib (- n 2)))))))
