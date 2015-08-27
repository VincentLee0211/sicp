#|
修改练习18中所做的 reverse 过程, 得到一个 deep-reverse 过程.
它以一个表为参数, 返回另一个表作为值, 结果表中的元素反转过来, 其中的子树也翻转.

例如:
(define x '((1 2) (3 4)))

x
((1 2) (3 4))

(reverse x)
((3 4) (1 2))

(deep-reverse x)
((4 3) (2 1))
|#

(define x '((1 2) (3 4)))

;; 反转序列
(define reverse
  (lambda (lst)
    (if (null? lst)
        '()
        (append (reverse (cdr lst)) (list (car lst))))))

(reverse x)

;; 反转树
(define deep-reverse
  (lambda (tree)
    (cond ((null? tree) '())
          ((not (pair? tree)) tree)
          (else (append (deep-reverse (cdr tree))
                        (list (deep-reverse (car tree))))))))

(deep-reverse x)
