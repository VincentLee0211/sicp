;; 对树的映射

;; 对树中的每个元素做操作
(define scale-tree.v1
  (lambda (tree factor)
    (cond ((null? tree) '())
          ((not (pair? tree)) (* tree factor))
          (else (cons (scale-tree.v1 (car tree) factor)
                      (scale-tree.v1 (cdr tree) factor))))))

;; 对树做整体变换
(define map
  (lambda (proc items)
    (if (null? items)
        '()
        (cons (proc (car items))
              (map proc (cdr items))))))

(define scale-tree.v2
  (lambda (tree factor)
    (map (lambda (sub-tree)
           (if (pair? sub-tree)
               (scale-tree.v2 sub-tree factor)
               (* sub-tree factor)))
         tree)))

;; 测试
(define tree '(1 (2 (3 4) 5) (6 7)))

(scale-tree.v1 tree 10)

(scale-tree.v2 tree 10)
