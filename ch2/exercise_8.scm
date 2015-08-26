#|
通过类似于 Alyssa 的推理, 说明两个区间的差应该怎样计算

请定义出相应的减法过程 sub-interval
|#

(define sub-interval
  (lambda (x y)
    (make-interval (- (lower-bound x) (upper-bound y))
                   (- (upper-bound x) (lower-bound y)))))

;; 详细查看 interval_arithmetic.scm
