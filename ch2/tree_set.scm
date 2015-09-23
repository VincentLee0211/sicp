;; 集合作为二叉树

;; 定义二叉树的构造函数和选择函数
(define entry (lambda (tree) (car tree)))
(define left-branch (lambda (tree) (cadr tree)))
(define right-branch (lambda (tree) (caddr tree)))

(define make-tree
  (lambda (entry left right)
    (list entry left right)))

(define element-of-set?
  (lambda (x set)
    (cond [(null? set) #f]
          [(= x (entry set)) #t]
          [(< x (entry set))
           (element-of-set? x (left-branch set))]
          [(> x (entry set))
           (element-of-set? x (right-branch set))])))

(define adjoin-set
  (lambda (x set)
    (cond [(null? set) (make-tree x '() '())]
          [(= x (entry set)) set]
          [(< x (entry set))
           (make-tree (entry set)
                      (adjoin-set x (left-branch set))
                      (right-branch set))]
          [(> x (entry set))
           (make-tree (entry set)
                      (left-branch set)
                      (adjoin-set x (right-branch set)))])))
