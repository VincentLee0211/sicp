#|
令 f 和 g 是两个单参数的函数, f 在 g 之后的复合定义为函数 x -> f(g(x))

请定义一个函数 compose 实现函数复合.
例如, 如果 inc 是将参数加1的函数, 那么:

((compose square inc) 6)
49
|#

(define compose
  (lambda (f g)
    (lambda (x)
      (f (g x)))))

(define inc (lambda (x) (+ x 1)))

(define square (lambda (x) (* x x)))

((compose square inc) 6)
