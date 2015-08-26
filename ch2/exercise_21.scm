#|
过程 square-list 以一个数值表为参数, 返回每个数的平方构成的表:
(square-list '(1 2 3 4))
(1 4 9 16)

下面是 square-list 的两个定义, 请填充其中缺少的表达式以完成它们:
|#

(define square-list.v1
  (lambda (items)
    (if (null? items)
        '()
        (cons (square (car items)) (square-list.v1 (cdr items))))))

(define square-list.v2
  (lambda (items)
    (map square items)))
