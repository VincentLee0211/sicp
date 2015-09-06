#|
从原点出发的一个两维向量 v 可以用一个由 x 坐标和 y 坐标构成的序对表示.

请为这样的向量实现一个数据抽象: 给出一个构造函数 make-vect, 以及对应的选择函数 xcor-vect 和 ycor-vect.
借助与给出的构造函数和选择函数, 实现过程 add-vect, sub-vect, scale-vect, 它们能完成向量加法, 减法和向量的伸缩
|#

(define make-vect (lambda (x y) (list x y)))

(define xcor-vect (lambda (v) (car v)))

(define ycor-vect (lambda v) (cadr v))

(define add-vect
  (lambda (v w)
    (make-vect (+ (xcor-vect v) (xcor-vect w))
               (+ (ycor-vect v) (ycor-vect w)))))

(define sub-vect
  (lambda (v w)
    (make-vect (- (xcor-vect v) (xcor-vect w))
               (- (ycor-vect v) (ycor-vect w)))))

(define scale-vect
  (lambda (s v)
    (make-vect (* s (xcor-vect v))
               (* s (ycor-vect v)))))
