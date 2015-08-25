#|
请定义一个过程 double, 它以一个有一个参数的过程作为参数, double 返回一个过程.
这一过程将原来那个参数过程应用两次.
例如, 若 inc 是给参数加1的过程, (double inc) 将给参数加2.

下面表达式返回什么值:
(((double (double double)) inc) 5)
|#

;; 定义 double 函数
(define double
  (lambda (f)
    (lambda (x)
      (f (f x)))))

(define inc (lambda (x) (+ x 1)))

;; 表达式返回值
(((double (double double)) inc) 5)
;; (double double) 是将函数执行2*2次的一个函数
;; (double (double double)) 是将函数执行4*4次的一个函数

;; 21
