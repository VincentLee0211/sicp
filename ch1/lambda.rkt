#lang racket/base

;; 计算从a到b的各整数之和
(define sum-integers
  (lambda (a b)
    (if (> a b)
        0
        (+ a (sum-integers (+ a 1) b)))))

(sum-integers 1 100)

;; 计算给定范围内的整数的立方和
(define sum-cubes
  (lambda (a b)
    (if (> a b)
        0
        (+ (cube a) (sum-cubes (+ a 1) b)))))

(define cube
  (lambda (x)
    (expt x 3)))

(sum-cubes 1 100)

;; 计算给定的序列之和
(define pi-sum
  (lambda (a b)
    (if (> a b)
        0
        (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b)))))

(* 8.0 (pi-sum 1 1000))

;; 求和模式
(define sum
  (lambda (term a next b)
    (if (> a b)
        0
        (+ (term a) (sum term (next a) next b)))))

;; 辅助过程
(define inc (lambda (x) (+ x 1)))

(define identity (lambda (x) x))

(define pi-term (lambda (x) (/ 1.0 (* x (+ x 2)))))

(define pi-next (lambda (x) (+ x 4)))

(define sum-integers.v2
  (lambda (a b)
    (sum identity a inc b)))

(sum-integers.v2 1 100)

(define sum-cubes.v2
  (lambda (a b)
    (sum cube a inc b)))

(sum-cubes.v2 1 100)

(define pi-sum.v2
  (lambda (a b)
    (sum pi-term a pi-next b)))

(* 8.0 (pi-sum.v2 1 1000))

;; 计算定积分
(define integral
  (lambda (f a b dx)
    (* (sum f (+ a (/ dx 2)) (lambda (x) (+ x dx)) b)
       dx)))

(integral cube 0 1 0.001)

(integral cube 0 1 0.0001)

;; 计算函数f
(define f.v1
  (lambda (x y)
    (define f-helper
      (lambda (a b)
        (+ (* x (expt a 2))
           (* y b)
           (* a b))))
    (f-helper (+ 1 (* x y))
              (- 1 y))))

(define f.v2
  (lambda (x y)
    ((lambda (a b)
       (+ (* x (expt a 2))
          (* y b)
          (* a b)))
     (+ 1 (* x y))
     (- 1 y))))

(define f.v3
  (lambda (x y)
    (let ([a (+ 1 (* x y))]
          [b (- 1 y)])
      (+ (* x (expt a 2))
         (* y b)
         (* a b)))))

;; 计算方程在区间的根
(define search
  (lambda (f neg-point pos-point)
    (let [(mid-point (average neg-point pos-point))]
      (if (close-enough? neg-point pos-point)
          mid-point
          (let [(test (f mid-point))]
            (cond [(positive? test)
                   (search f neg-point mid-point)]
                  [(negative? test)
                   (search f mid-point pos-point)]
                  [else mid-point]))))))

(define close-enough?
  (lambda (x y)
    (< (abs (- x y)) 0.001)))

(define average
  (lambda (x y)
    (/ (+ x y) 2)))

(define half-interval-method
  (lambda (f a b)
    (let ([a-value (f a)]
          [b-value (f b)])
      (cond [(and (negative? a-value) (positive? b-value))
             (search f a b)]
            [(and (negative? b-value) (positive? a-value))
             (search f b a)]
            [else (error "Values are not of opposite sign" a b)]))))

(half-interval-method sin 2.0 4.0)

(half-interval-method (lambda (x) (- (expt x 3) (* 2 x) 3))
                      1.0
                      2.0)

;; 计算不动点
(define tolerance 0.00001)

(define fixed-point
  (lambda (f guess)
    (define try
      (lambda (guess)
        (let ([next (f guess)])
          (if (close-enough? guess next)
              next
              (try next)))))
    (define close-enough?
      (lambda (v1 v2)
        (< (abs (- v1 v2)) tolerance)))
    (try guess)))

(fixed-point cos 1.0)

(fixed-point (lambda (y) (+ (sin y) (cos y)))
             1.0)

#|
(define sqrt
  (lambda (x)
    (fixed-point (lambda (y) (/ x y))
                 1.0)))
|#

(define sqrt
  (lambda (x)
    (fixed-point (lambda (y) (average y (/ x y)))
                 1.0)))

;; 函数作为返回值
(define average-damp
  (lambda (f)
    (lambda (x)
      (average x (f x)))))

(define sqrt.v2
  (lambda (x)
    (fixed-point (average-damp (lambda (y) (/ x y))) 1.0)))

(define cube-root
  (lambda (x)
    (fixed-point (average-damp (lambda (y) (/ x (expt y 2)))) 1.0)))

;; 牛顿法
(define dx 0.00001)

(define deriv
  (lambda (g)
    (lambda (x)
      (/ (- (g (+ x dx)) (g x)) dx))))

(define newton-transform
  (lambda (g)
    (lambda (x)
      (- x (/ (g x) ((deriv g) x))))))

(define newtons-method
  (lambda (g guess)
    (fixed-point (newton-transform g) guess)))

(define sqrt.v3
  (lambda (x)
    (newtons-method (lambda (y) (- x (expt y 2))) 1.0)))

(define fixed-point-of-transform
  (lambda (g transform guess)
    (fixed-point (transform g) guess)))

(define sqrt.v4
  (lambda (x)
    (fixed-point-of-transform (lambda (y) (/ x y)) average-damp 1.0)))

(define sqrt.v5
  (lambda (x)
    (fixed-point-of-transform (lambda (y) (- x (expt y 2))) newton-transform 1.0)))