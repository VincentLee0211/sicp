#|
Ben Bitdiddle 是个专业程序员, 他看了 Alyssa 工作后评论说, 除以一个跨过横跨0的区间的意义不清楚

请修改 Alyssa 的代码, 检查这种情况并在出现这一情况时报错
|#

(define div-interval
  (lambda (x y)
    (let ((ylower (lower-bound y))
          (yupper (upper-bound y)))
      (if (and (negative? ylower) (positive? yupper))
          (error "横跨0的区间没有意义" ylower yupper)
          (mul-interval x
                        (make-interval (/ 1.0 yupper)
                                       (/ 1.0 ylower)))))))
