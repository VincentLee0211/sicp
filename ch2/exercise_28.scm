#|
写一个过程 fringe, 它以一个树为参数, 返回一个表, 表中的元素是这棵树的所有树叶, 按照从左到右的顺序

例如:
(define x '((1 2) (3 4)))

(fringe x)
(1 2 3 4)

(fringe '(x x))
(1 2 3 4 1 2 3 4)
|#

(define fringe
  (lambda (tree)
    (cond ((null? tree) '())
          ((not (pair? tree)) (list tree))
          (else (append (fringe (car tree))
                        (fringe (cdr tree)))))))


;; 测试

(define x '((1 2) (3 4)))

(fringe x)

(fringe (list x x))
