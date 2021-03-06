#|
我们可以将一个集合表示为一个元素互不相同的表, 因此就可以将一个集合的所有子集表示为表的表.

例如, 假定集合为(1 2 3), 它的所有子集的集合就是
(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))

请完成下面的过程定义, 它生成出一个集合的所有子集的集合.
请解释它为什么能完成这一工作.

|#

(define subsets
  (lambda (s)
    (if (null? s)
        (list '())
        (let ((rest (subsets (cdr s)))) ;; 求出不带第一个元素的其他所有元素的组合
          (append rest (map (lambda (item) (cons (car s) item)) rest))))))  ;; append 拼接两部分, rest 表示不带第一个元素的所有组合, (map ...) 表示带第一个元素的所有组合

(subsets '(1 2 3))
