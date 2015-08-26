#|
请定义出过程 reverse, 它以一个表为参数, 返回表中所包含的元素与参数表相通, 但排列顺序与参数表相反:

(reverse '(1 4 9 16 25))
(25 16 9 4 1)
|#

(define reverse
  (lambda (lst)
    (if (null? lst)
        '()
        (append (reverse (cdr lst)) (list (car lst))))))

(reverse '(1 4 9 16 25))
