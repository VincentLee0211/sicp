#|
请定义出 corner-split 里使用的过程 up-split, 它与 right-split 类似, 除在其中交换了 below 和 beside 的角色之外
|#

(define up-split
  (lambda (painter n)
    (if (zero? n)
        painter
        (let ((smaller (up-split painter (sub1 n))))
          (below painter (beside smaller smaller))))))
