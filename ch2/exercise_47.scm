#|
下面是实现框架的两个可能的过程函数,

请为每个构造函数提供适当的选择函数, 为框架做出相应的实现
|#

(define make-frame.v1
  (lambda (origin edge1 edge2)
    (list origin edge1 edge2)))

(define origin-frame.v1
  (lambda (frame)
    (car frame)))

(define edge1-frame.v1
  (lambda (frame)
    (cadr frame)))

(define edge2-frame.v1
  (lambda (frame)
    (caddr frame)))

(define make-frame.v2
  (lambda (origin edge1 edge2)
    (cons origin (cons ege1 edge2))))

(define origin-frame.v2
  (lambda (frame)
    (car frame)))

(define edge1-frame.v2
  (lambda (frame)
    (cadr frame)))

(define edge2-frame.v2
  (lambda (frame)
    (cddr frame)))
