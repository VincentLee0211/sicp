#|
请实现一种平面矩形的表示.基于你的构造函数和选择函数定义几个过程, 计算给定矩形的周长和面积等.
现在请再为矩形实现另一种表示方式.

你应该怎样设计系统, 使之能提供适当的抽象屏障, 使同一个周长或者面积过程对两种不同表示都能工作?
|#

;; 点的构造函数和选择函数
(define make-point (lambda x y) (cons x y))

(define x-point (p) (car p))
(define y-point (p) (cdr p))

;; 第一种矩形的构造函数和选择函数
(define make-rectangle (lambda (blp trp) (cons blp trp)))

(define width
  (lambda (rect)
    (let ((bl-point (car rect))
          (tr-point (cdr rect)))
      (- (x-point tr-point)
         (x-point bl-point)))))

(define height
  (lambda (rect)
    (let ((bl-point (car rect))
          (tr-point (cdr rect)))
      (- (y-point tr-point)
         (y-point bl-point)))))

;; 第二种矩形的构造函数和选择函数
(define make-rectangular
  (lambda (p w h)
    (cons p (cons w h))))

(define width
  (lambda (rect)
    (car (cdr rect))))

(define height
  (lambda (rect)
    (cdr (cdr rect))))

;; 计算矩形的周长和面积
(define area
  (lambda (rect)
    (* (width rect) (height rect))))

(define circumference
  (lambda (rect)
    (* 2 (+ (width rect) (height rect)))))
