;; 计算 X 的平方
(define square
  (lambda (x)
    (* x x)))

;; 计算 x^2 + y^2
(define sum-of-squares
  (lambda (x y)
    (+ (square x) (square y))))

;; 计算 函数 f
(define f
  (lambda (a)
    (sum-of-squares (+ a 1) (* a 2))))
