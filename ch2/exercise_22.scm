#|
Louis Reasoner 视图重写练习21的第一个 square-list 过程, 希望使它能生成一个迭代计算过程:

|#

(define square-list.v1
  (lambda (items)
    (define iter
      (lambda (things answer)
        (if (null? things)
            answer
            (iter (cdr things)
                  (cons (square (car things)) answer)))))   ;; 倒序, 每次迭代, 将开头添加到表结构
    (iter items '())))

#|
但是很不幸, 在按这种方式定义出的 square-list 产生出的结果表中, 元素的顺序正好与我们所需要的相反.
为什么?

Louis 又试着修正其程序. 交换了 cons 的参数.
|#

(define square-list.v2
  (lambda (items)
    (define iter
      (lambda (things answer)
        (if (null? things)
            answer
            (iter (cdr things)
                  (cons answer (square (car things)))))))   ;; 每次迭代将'()添加到原子上, 组成序对
    (iter items '())))

;; 但还是不行. 请解释为什么
