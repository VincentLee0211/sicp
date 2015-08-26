#|
如果觉得将序对表示为过程还不足以令人如雷灌顶, 那么请考虑,
在一个可以对过程座各种操作的语言里, 我们完全可以没有数(至少在只考虑非负整数的情况下),
可以将0和加1操作实现为:

(define zero (lambda (f) (lambda (x) x)))

(define add1 (lambda (n) (lambda (f) (lambda (x) (f ((n f) x))))))

这一表示形式称为 Church 计数, 名字来源于其发明人数理逻辑学家 Alonzo Church, lambda 演算也是他发明的

请直接定义 one 和 two (不用 zero 和 add1)
请给出加法过程 + 的一个直接定义
|#

(define zero
  (lambda (f)
    (lambda (x)
      x)))

(define one
  (lambda (f)
    (lambda (x)
      (f x))))

(define two
  (lambda (f)
    (lambda (x)
      (f (f x)))))

(define add1
  (lambda (n)
    (lambda (f)
      (lambda (x)
        (f ((n f) x))))))

(define >+
  (lambda (m n)
    (lambda (f)
      (lambda (x)
        ((m f) ((n f) x))))))

(define inc (lambda (x) (+ x 1)))

;; 测试
((zero inc) 0)

((one inc) 0)

((two inc) 0)

(((add1 two) inc) 0)

(((>+ two two) inc) 0)
