#|
请定义一个与练习21中 square-list 过程类似的 square-tree 过程.

也就是说, 它应该具有下面的行为:

(square-tree '(1 (2 (3 4) 5) (6 7)))

'(1 (4 (8 16) 25) (36 49))

请以两种方式 square-tree, 直接定义, 以及使用 map 和递归定义
|#

(define square-tree.v1
  (lambda (tree)
    (cond ((null? tree) '())
          ((not (pair? tree)) (square tree))
          (else (cons (square-tree.v1 (car tree))
                      (square-tree.v1 (cdr tree)))))))

(square-tree.v1 '(1 (2 (3 4) 5) (6 7)))

(define map
  (lambda (proc items)
    (if (null? items)
        '()
        (cons (proc (car items))
              (map proc (cdr items))))))

(define square-tree.v2
  (lambda (tree)
    (map (lambda (sub-tree)
           (if (pair? sub-tree)
               (square-tree.v2 sub-tree)
               (square sub-tree)))
         tree)))

(square-tree.v2 '(1 (2 (3 4) 5) (6 7)))
