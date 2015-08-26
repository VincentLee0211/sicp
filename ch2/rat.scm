;; 有理数的算术运算

;; 假设已经有了一种从分子和分母构造有理数的方法
;; 假定已经存在"构造函数"和"选择函数"
;;
;; (make-rat <n> <d>)   返回一个有理数
;; (numer <x>)          返回有理数的分子
;; (denom <x>)          返回有理数的分母

;; 有理数相加
(define add-rat
  (lambda (x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y)))))

;; 有理数相减
(define sub-rat
  (lambda (x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y)))))

;; 有理数相乘
(define mul-rat
  (lambda (x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y)))))

;; 有理数相除
(define div-rat
  (lambda (x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y)))))

;; 有理数相等
(define equal-rat?
  (lambda (x y)
    (= (* (numer x) (denom y))
       (* (denom x) (numer y)))))

;; 使用序对, 完成有理数的构造函数和选择函数
#|
(define make-rat (lambda (n d) (cons n d)))
|#
;; 有理数最简形式
(define make-rat
  (lambda (n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g)))))

(define gcd
  (lambda (m n)
    (if (= n 0)
        m
        (gcd n (remainder m n)))))

(define numer (lambda (x) (car x)))
(define denom (lambda (x) (cdr x)))

;; 打印有理数
(define print-rat
  (lambda (x)
    (newline)
    (display (numer x))
    (display "/")
    (display (denom x))))

;; 测试
(define one-half (make-rat 1 2))

(print-rat one-half)
;; 1/2

(define one-third (make-rat 1 3))

(print-rat (add-rat one-half one-third))
;; 5/6

(print-rat (mul-rat one-half one-third))
;; 1/6

(print-rat (add-rat one-third one-third))
;; 6/9
