#|
请定义一个构造函数 make-center-percent, 它以一个中心点和一个百分比为参数, 产生所需要的区间.

你还需要定义选择函数 percent, 通过它可以得到给定区间的百分数误差, 选择函数 center 与前面定义的一样
|#

(define make-center-percent
  (lambda (c p)
    (make-interval (- c (* c p)) (+ c (* c p)))))

(define center
  (lambda (i)
    (/ (+ (upper-bound i) (lower-bound i)) 2)))

(define percent
  (lambda (i)
    (/ (- (upper-bound i) (lower-bound i))
       (+ (upper-bound i) (lower-bound i)))))
