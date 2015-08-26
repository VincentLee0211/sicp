#|
请定义出 make-rat 的一个更好的版本, 使之可以正确处理整数和负数.
当有理数为正时, make-rat 应当将其规范化, 使它的分子和分母都是正的.
如果有理数为负, 那么就应只让分子为负
|#

;; 有理数四则运算, 使用构造函数和选择函数
(define add-rat
  (lambda (x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (denom x) (numer y)))
              (* (denom x) (denom y)))))

(define sub-rat
  (lambda (x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (denom x) (numer y)))
              (* (denom x) (denom y)))))

(define mul-rat
  (lambda (x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y)))))

(define div-rat
  (lambda (x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y)))))

(define equal-rat?
  (lambda (x y)
    (= (* (numer x) (denom y))
       (* (denom x) (numer y)))))

(define print-rat
  (lambda (x)
    (newline)
    (display (numer x))
    (display "/")
    (display (denom x))))

;; 有理数的构造函数和选择函数, 其中构造函数化简为最简形式, 且规范其形式
(define make-rat
  (lambda (n d)
    (let ((g (gcd n d))
          (sign (if (or (and (negative? n) (negative? d))
                        (and (positive? n) (positive? d)))
                    +
                    -)))
      (cons (sign (abs (/ n g))) (abs (/ d g))))))

(define numer (lambda (x) (car x)))
(define denom (lambda (x) (cdr x)))

(define gcd
  (lambda (m n)
    (if (= n 0)
        m
        (gcd n (remainder m n)))))

;; 测试
(define one-half (make-rat 1 -2))

(print-rat one-half)
;; -1/2

(define one-third (make-rat -1 3))

(print-rat one-third)
;; -1/3

(print-rat (add-rat one-half one-third))
;; -5/6

(print-rat (mul-rat one-half one-third))
;; 1/6

(print-rat (add-rat one-third one-third))
;; -2/3
