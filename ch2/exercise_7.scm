#|
Alyssa 的程序是不完整的, 因为她还没有确定区间抽象的实现.

这里是区间构造函数的定义:
(define make-interval (lambda (a b) (cons a b)))

请定义选择函数 upper-bound 和 lower-bound, 完成这一实现
|#

;; 构造函数
(define make-interval
  (lambda (a b)
    (cons a b)))

;; 选择函数
(define upper-bound
  (lambda (z)
    (cdr z)))

(define lower-bound
  (lambda (z)
    (car z)))
