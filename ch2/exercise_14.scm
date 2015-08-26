#|
并联电阻的公式可以携程两个代数上等价的公式

r1r2/(r1+r2)

1/(1/r1 + 1/r2)

这样可以写出两个程序, 它们以不同的方式计算并联电阻值
|#

(define par1
  (lambda (r1 r2)
    (div-interval (mul-interval r1 r2)
                  (add-interval r1 r2))))

(define par2
  (lambda (r1 r2)
    (let ((one (make-interval 1 1)))
      (div-interval one
                    (add-interval (div-interval one r1)
                                  (div-interval one r2))))))

#|
Lem 抱怨说, Alyssa 程序对两种不同计算方法给出不同的值

请确认 Lem 是对的.

请你用各种不同的算术表达式来检查这一系统的行为.
请做出两个区间 A 和 B, 并用它们计算表达式 A/A 和 A/B.
如果所用区间的宽度相对于中心值取很小百分数, 你讲会得到更多的认识.

请检查对于中心-百分比形式进行计算的系统产生出的区间的界限更紧一些.
她说, 因此, 在计算并联电阻时, par2是比 par1"更好的"程序, 对吗?
|#

(define make-interval
  (lambda (a b) (cons a b)))

(define lower-bound (lambda (i) (car i)))
(define upper-bound (lambda (i) (cdr i)))

;; ----------------------------------------------

(define make-center-width
  (lambda (c w)
    (make-interval (- c w) (+ c w))))

(define center
  (lambda (i) (/ (+ (lower-bound i) (upper-bound i)) 2)))

(define width
  (lambda (i) (/ (- (upper-bound i) (lower-bound i)) 2)))

;; --------------------------------------------------------

(define make-center-percent
  (lambda (c p)
    (make-center-width c (* c p))))

(define percent
  (lambda (i)
    (/ (- (upper-bound i) (lower-bound i))
       (+ (upper-bound i) (lower-bound i)))))

;; ---------------------------------------------------------

(define add-interval
  (lambda (x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y)))))

(define div-interval
  (lambda (x y)
    (let ((ylower (lower-bound y))
          (yupper (upper-bound y)))
      (if (and (negative? ylower) (positive? yupper))
          (error "横跨0区间" ylower yupper)
          (mul-interval x
                        (make-interval (/ 1.0 yupper)
                                       (/ 1.0 ylower)))))))

(define mul-interval
  (lambda (x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
      (make-interval (min p1 p2 p3 p4)
                     (max p1 p2 p3 p4)))))


;; -----------------------------------------------------------

(define A (make-center-percent 5 .02))
(define B (make-center-percent 10 .01))

(par1 A B)

(par2 A B)

(div-interval A A)

(div-interval A B)
