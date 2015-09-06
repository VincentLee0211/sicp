#lang racket

(require sicp-pict)

;; 实现一个图形语言
;;
;; 1. 使用 Racket 而不是 Mit-Scheme
;;
;; 2. 本章使用图形语言展示数据抽象和闭包, 以非常本质的方式使用高阶过程

;; 组合操作, 给定画家构造出新画家
;;
;; 1. (beside p1 p2), 将画家p1画在框架的左边, 将画家p2画在框架的右边
;; 2. (below p1 p2), 将画家p1画在p2的下面
;; 3. (flip-vert p), 将画家p上下颠倒
;; 4. (flip-horiz p), 将画家p左右颠倒
;; 5. (rorato180 p), 将画家p翻转180'

;; 使用组合操作, 创建新的画家
;; -> 画家在有关语言的组合方式下是封闭的
;; -> 我们所用的数据在组合方式下的闭包性质非常重要, 因为这使我们能用不多几个操作构造出各种复杂的结构
(define _einstein2 (beside einstein einstein))

(define _einstein4 (below _einstein2 _einstein2))

;; 抽象出 _einstein4 的模式,
(define flipped-pairs
  (lambda (painter)
    (let ((painter2 (beside painter painter)))
      (below painter2 painter2))))

(define _einstein4.v2 (flipped-pairs einstein))

;; 对图形的右边做分割和分支
(define right-split
  (lambda (painter n)
    (if (zero? n)
        painter
        (let ((smaller (right-split painter (sub1 n))))
          (beside painter (below smaller smaller))))))

;; 对图形的上边做分割和分支
(define up-split
  (lambda (painter n)
    (if (zero? n)
        painter
        (let ((smaller (up-split painter (sub1 n))))
          (below painter (beside smaller smaller))))))

;; 抽象 right-split 和 up-split 的通用模式
(define split
  (lambda (op1 op2)
    (lambda (painter n)
      (if (zero? n)
          painter
          (let ((smaller ((split op1 op2) painter (sub1 n))))
            (op1 painter (op2 smaller smaller)))))))

(define right-split.v2 (split beside below))

(define up-split.v2 (split below beside))

;; 对图形向上和向右分支
(define corner-split
  (lambda (painter n)
    (if (zero? n)
        painter
        (let ((up (up-split painter (sub1 n)))
              (right (right-split painter (sub1 n))))
          (let ((top-left (beside up up))
                (bottom-right (below right right))
                (corner (corner-split painter (sub1 n))))
            (beside (below painter top-left)
                    (below bottom-right corner)))))))

;; 应用 corner-split 创建图形
(define square-limit
  (lambda (painter n)
    (let ((quarter (corner-split painter n)))
      (let ((half (beside (flip-horiz quarter) quarter)))
        (below (flip-vert half) half)))))

;; 抽象出 flipped-pairs 和 square-limit 的通用模式
(define square-of-four
  (lambda (tl tr bl br)
    (lambda (painter)
      (let ((top (beside (tl painter) (tr painter)))
            (bottom (beside (bl painter) (br painter))))
        (below bottom top)))))

(define flipped-pairs.v2
  (lambda (painter)
    (let ((combine4 (square-of-four identity flip-vert identity flip-vert)))
      (combine4 painter))))

(define square-limit.v2
  (lambda (painter n)
    (let ((combine4 (square-of-four flip-horiz identity rotate180 flip-vert)))
      (combine4 (corner-split painter n)))))

;; 框架
;; 1. 基准向量, 框架基准点相对于平面上某个绝对
;; 2. 角向量

(define _frame-coord-map
  (lambda (frame)
    (lambda (v)
      (_add-vect
       (_origin-frame frame)
       (_add-vect (_scale-vect (_xcor-vect v)
                               (_edge1-frame frame))
                  (_scale-vect (_ycor-vect v)
                               (_edge2-frame frame)))))))

;; 向量 构造函数和选择函数
(define _make-vect (lambda (x y) (list x y)))

(define _xcor-vect (lambda (v) (car v)))
(define _ycor-vect (lambda (v) (cadr v)))

;; 向量运算
(define _add-vect
  (lambda (v w)
    (_make-vect (+ (_xcor-vect v) (_xcor-vect w))
                (+ (_ycor-vect v) (_ycor-vect w)))))

(define _sub-vect
  (lambda (v w)
    (_make-vect (- (_xcor-vect v) (_xcor-vect w))
                (- (_ycor-vect v) (_ycor-vect w)))))

(define _scale-vect
  (lambda (s v)
    (_make-vect (* s (_xcor-vect v))
                (* s (_ycor-vect v)))))

;; 框架 选择函数和构造函数
(define _make-frame
  (lambda (origin edge1 edge2)
    (list origin edge1 edge2)))

(define _origin-frame
  (lambda (frame)
    (car frame)))

(define _edge1-frame
  (lambda (frame)
    (cadr frame)))

(define _edge2-frame
  (lambda (frame)
    (caddr frame)))

;; 画家
(define _segments->painter
  (lambda (segment-list)
    (lambda (frame)
      (for-each
       (lambda (segment)
         (draw-line
          ((frame-coord-map frame) (start-segment segment))
          ((frame-coord-map frame) (end-segment segment))))
       segment-list))))

;; 线段 构造函数和选择函数
(define _make-segment
  (lambda (v w)
    (list v w)))

(define _start-segment
  (lambda (s)
    (car s)))

(define _end-segment
  (lambda (s)
    (cadr s)))