#|
请证明, 如果将 a 和 b 的序对表示为乘积 2^a3^b 对应的整数, 我们就可以只用非负整数和算术运算表示序对.

请给出对应的过程 cons, car 和 cdr 的定义
|#

;; 一个数乘以2是2的倍数, 一个数乘以3是3的倍数
;; 当 a 和 b 都是正整数时, 2^a3^b 包含了 a 个2和 b 个3

(define cons
  (lambda (a b)
    (* (expt 2 a) (expt 3 b))))

(define inc (lambda (x) (+ x 1)))

(define car
  (lambda (z)
    (if (not (=  0 (remainder z 2)))
        0
        (inc (car (quotient z 2))))))

(define cdr
  (lambda (z)
    (if (not (= 0 (remainder z 3)))
        0
        (inc (cdr (quotient z 3))))))

;; 测试
(define x (cons 5 6))

(car x)

(cdr x)
