#|
请你在练习30做出的解答进一步抽象, 做出一个过程, 使它的性质保证能以下面形式定义 square-tree:

(define square-tree (lambda (tree) (tree-map square tree)))
|#

(define square-tree
  (lambda (tree)
    (tree-map square tree)))

(define tree-map
  (lambda (proc tree)
    (map (lambda (sub-tree)
           (if (pair? sub-tree)
               (tree-map proc sub-tree)
               (proc sub-tree)))
         tree)))

(define map
  (lambda (proc items)
    (if (null? items)
        '()
        (cons (proc (car items))
              (map proc (cdr items))))))

(define x '(1 (2 (3 4) 5) (6 7)))

(square-tree x)
