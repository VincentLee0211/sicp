#|
请考虑平面上线段的表示问题. 一个线段用一对点表示, 它们分别是线段的始点和终点.
请定义构造函数 make-segment 和选择函数 start-segment, end-segment, 它们基于点定义线段的表示.
进而, 一个点可以用数的序对表示, 序对的两个成分分别表示点的 x 坐标和 y 坐标.

请据此进一步给出构造函数 make-point 和选择函数 x-point, y-point, 用它们定义出点的这种表示.
最后, 请基于所定义的构造函数和选择函数, 定义出过程 midpoint-segment, 它以一个线段为参数, 返回选段的中点(也就是那个坐标值是两个端点的平均值的点).
为了实验这些过程, 还需要定义一种打印点的方法:

(define print-point
  (lambda (p)
    (newline)
    (display "(")
    (display (x-point p))
    (display (","))
    (display (y-point p))
    (display ")")))
|#

;; 线段的构造函数和选择函数
(define make-segment
  (lambda (sp ep)
    (cons sp ep)))

(define start-segment (lambda (segment) (car segment)))
(define end-segment (lambda (segment) (cdr segment)))

;; 点的构造函数和选择函数
(define make-point
  (lambda (x y)
    (cons x y)))

(define x-point (lambda (point) (car point)))
(define y-point (lambda (point) (cdr point)))

;; 打印点
(define print-point
  (lambda (p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ",")
    (display (y-point p))
    (display ")")))

;; 计算线段中点
(define midpoint-segment
  (lambda (segment)
    (let ((sp (start-segment segment))
          (ep (end-segment segment)))
      (make-point (average (x-point sp) (x-point ep))
                  (average (y-point sp) (y-point ep))))))

(define average
  (lambda (x y)
    (/ (+ x y) 2)))

;; 测试
(define p1 (make-point 0 0))
(define p2 (make-point 4 4))

(define sg (make-segment p1 p2))

(define m (midpoint-segment sg))

(print-point m)
