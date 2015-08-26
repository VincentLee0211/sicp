;; 区间算术

;; 区间的构造函数和选择函数
;; (make-interval lower upper)
;; (lower-bound interval)
;; (upper-bound interval)

;; 区间加法
(define add-interval
  (lambda (x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y)))))

;; 区间乘法
(define mul-interval
  (lambda (x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
      (make-interval (min p1 p2 p3 p4)
                     (max p1 p2 p3 p4)))))

;; 区间除法
(define div-interval
  (lambda (x y)
    (mul-interval x
                  (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y))))))

;; 区间减法
(define mul-interval
  (lambda (x y)
    (make-interval (- (lower-bound x) (upper-bound y))
                   (- (upper-bound x) (lower-bound y)))))

;; 区间选择函数和构造函数
(define make-interval
  (lambda (a b)
    (cons a b)))

(define lower-bound
  (lambda (z)
    (car z)))

(define upper-bound
  (lambda (z)
    (cdr z)))

;; 另一种区间的表示方法
(define make-center-width
  (lambda (c w)
    (make-interval (- c w) (+ c w))))

(define center
  (lambda (i)
    (/ (+ (lower-bound i) (upper-bound i)) 2)))

(define width
  (lambda (i)
    (/ (- (upper-bound i) (lower-bound i)) 2)))
