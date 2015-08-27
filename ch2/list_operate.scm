;; 序列操作

(define map
  (lambda (proc items)
    (if (null? items)
        '()
        (cons (proc (car items))
              (map proc (cdr items))))))

;; 使用 map 实现信号流图中的映射步骤
(map square '(1 2 3 4 5))
;; (1 4 9 16 25)

;; 实现过滤器
(define filter
  (lambda (predicate sequence)
    (cond ((null? sequence) '())
          ((predicate (car sequence))
           (cons (car sequence)
                 (filter predicate (cdr sequence))))
          (else (filter predicate (cdr sequence))))))

(filter odd? '(1 2 3 4 5))
;; (1 3 5)

;; 累积工作实现
(define accumulate
  (lambda (op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence))))))

(accumulate + 0 '(1 2 3 4 5))

(accumulate * 1 '(1 2 3 4 5))

(accumulate cons '() '(1 2 3 4 5))

;; 实现信号流图

;; 生成给定区间的整数序列
(define enumerate-interval
  (lambda (low high)
    (if (> low high)
        '()
        (cons low (enumerate-interval (inc low) high)))))

(define inc (lambda (x) (+ x 1)))

(enumerate-interval 2 7)

;; 枚举出一棵树的所有树叶
(define enumerate-tree
  (lambda (tree)
    (cond ((null? tree) '())
          ((not (pair? tree)) (list tree))
          (else (append (enumerate-tree (car tree))
                        (enumerate-tree (cdr tree)))))))

(enumerate-tree '(1 (2 (3 4) 5)))

;; 重构 sum-odd-squares 和 even-fibs
(define sum-odd-squares
  (lambda (tree)
    (accumulate + 0 (map square (filter odd? (enumerate-tree tree))))))

(define even-fibs
  (lambda (n)
    (filter even? (map fib (enumerate-interval 0 n)))))

(define one? (lambda (x) (= x 1)))
(define zero? (lambda (x) (= x 0)))

(define fib
  (lambda (n)
    (cond ((zero? n) 0)
          ((one? n) 1)
          (else (+ (fib (- n 1))
                   (fib (- n 2)))))))

;; 测试

(sum-odd-squares '(1 (2 (3 4) 5)))
;; 35

(even-fibs 10)
;; (0 2 8 34)

;; 构造前 n+1 个斐波那契数的平方的程序
(define list-fib-squares
  (lambda (n)
    (map square (map fib (enumerate-interval 0 n)))))

(list-fib-squares 10)

;; 生成一个序列中所有奇数的平方之乘积的计算
(define product-of-squares-of-odd-elements
  (lambda (sequence)
    (accumulate * 1 (map square (filter odd? sequence)))))

(product-of-squares-of-odd-elements '(1 2 3 4 5))
