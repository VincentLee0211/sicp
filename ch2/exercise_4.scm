#|
下面是序对的另一种过程性表示方式.
请针对这一表示验证, 对于任意的 x 和 y, (car (cons x y)) 都将产生出 x

(define cons
  (lambda (x y)
    (lambda (m)
      (m x y))))

(define car
  (lambda (z)
    (z (lambda (p q) p))))
|#

;; 完整的 cons, car, cdr
(define cons
  (lambda (x y)
    (lambda (m)
      (m x y))))

(define car
  (lambda (z)
    (z (lambda (p q) p))))

(define cdr
  (lambda (z)
    (z (lambda (p q) q))))

;; 测试
(define x (cons 1 2))
;; (lambda (m) (m x y))

(car x)
;; (x (lambda p q) p)
;; ((lambda (m) (m x y)) (lambda (p q) p))
;; ((lambda (p q) p) x y)
;; x
;; 1

(cdr x)
;; (x (lambda (p q) q))
;; ((lambda (m) (m x y)) (lambda (p q) q))
;; ((lambda (p q) q) x y)
;; y
;; 2
