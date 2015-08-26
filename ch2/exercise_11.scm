#|
在看了这些东西之后, Ben 有说出了下面这段有些神秘的话: "通过检测区间的端点, 有可能将 mul-interval 分解为9中情况, 没种情况中所需的乘法都不超过两次".

请根据 Ben 的建议重写这个过程
|#

(define mul-interval
  (lambda (x y)
    (cond ((> (lower-bound x) 0)
           (cond ((> (lower-bound y) 0)
                  (make-interval (* (lower-bound x) (lower-bound y))
                                 (* (upper-bound x) (upper-bound y))))
                 ((< (upper-bound y) 0)
                  (make-interval (* (upper-bound x) (lower-bound y))
                                 (* (lower-bound x) (upper-bound y))))
                 (else
                  (make-interval (* (upper-bound x) (lower-bound y))
                                 (* (upper-bound x) (upper-bound y))))))
          ((< (upper-bound x) 0)
           (cond ((> (lower-bound y) 0)
                  (make-interval (* (lower-bound x) (upper-bound y))
                                 (* (upper-bound x) (lower-bound y))))
                 ((< (upper-bound y) 0)
                  (make-interval (* (upper-bound x) (upper-bound y))
                                 (* (lower-bound x) (lower-bound y))))
                 (else
                  (make-interval (* (lower-bound x) (upper-bound y))
                                 (* (lower-bound x) (lower-bound y))))))
          (else
           (cond ((> (lower-bound y) 0)
                  (make-interval (* (lower-bound x) (upper-bound y))
                                 (* (upper-bound x) (upper-bound y))))
                 ((< (upper-bound y) 0)
                  (make-interval (* (upper-bound x) (lower-bound y))
                                 (* (lower-bound x) (lower-bound y))))
                 (else
                  (make-interval (min (* (lower-bound x) (upper-bound y))
                                      (* (upper-bound x) (lower-bound y)))
                                 (max (* (lower-bound x) (lower-bound y))
                                      (* (upper-bound x) (upper-bound y))))))))))
