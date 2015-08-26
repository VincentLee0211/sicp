#|
过程+, * 和 list 可以去任意个数的实际参数.

定义这类过程的一种方式是采用一种带点尾部记法形式的 define.
在一个过程定义中, 如果在形式参数表的最后一个参数之前有一个点号, 那就表明, 当这一过程被实际调用时, 前面各个形式参数将以前面的各个实际参数为值, 与平常一样.
但最后一个形式参数将以所有剩下的实际参数的表为值.

例如, 假若我们定义了:
(define (f x y . z) <body>)
过程 f 就可以用两个以上的参数调用. 如果求值:
(f 1 2 3 4 5 6)
那么在 f 的体里, x 将是 1, y 将是 2, 而 z 将是表 (3 4 5 6).

给了定义:
(define (g . w) <body>)
过程 g 可以用 0 个或多个参数调用. 如果求值:
(g 1 2 3 4 5 6)
那么在 g 的体里, w 将是表(1 2 3 4 5 6)

请采用这种记法形式写出过程 same-parity, 它以一个或者多个整数为参数, 返回所有与其第一个参数有着同样奇偶性的参数形式的表.
例如:
(same-parity 1 2 3 4 5 6 7)
(1 3 5 7)

(same-parity 2 3 4 5 6 7)
(2 4 6)
|#

(define same-parity
  (lambda (x . w)
    (define filter
      (lambda (lst)
        (cond ((null? lst) '())
              ((= (remainder x 2) (remainder (car lst) 2))
               (cons (car lst) (filter (cdr lst))))
              (else (filter (cdr lst))))))
    (cons x (filter w))))

(same-parity 1 2 3 4 5 6 7)

(same-parity 2 3 4 5 6 7)
