#|
可以将 right-split 和 up-split 表述为某种广义划分操作的实例

请定义一个过程 split, 使它居右如下性质, 求值:

(define right-split (split beside below))
(define up-split (spit below beside))

产生能够出过程 right-split 和 up-split, 其行为与前面定义的过程一样
|#

(define split
  (lambda (op1 op2)
    (lambda (painter)
      (let ((smaller (op2 painter painter)))
        (op1 smaller smaller)))))

(define right-split (split beside below))

(define up-split (split below beside))
