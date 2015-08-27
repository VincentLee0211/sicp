#|
过程 accumulate 页称为 fold-right, 因为它将序列的第一个元素组合到右边所有元素的组合结果上.

也有一个 fold-left, 它与 fold-right 类似, 但却是按照相反方向去操作各个元素:

求下面表达式的值是什么?

如果要求用某个 op 时保证 fold-right 和 fold-left 对任何序列都产生同样的结果, 请给出 op 应该满足的性质
|#

(define fold-right
  (lambda (op init seq)
    (if (null? seq)
        init
        (op (car seq)
            (fold-right op init (cdr seq))))))

(define fold-left
  (lambda (op init seq)
    (define iter
      (lambda (result rest)
        (if (null? rest)
            result
            (iter (op result (car rest))
                  (cdr rest)))))
    (iter init seq)))

;; 求值
(fold-right / 1 '(1 2 3))
;; 3/2

(fold-left / 1 '(1 2 3))
;; 1/6

(fold-right list '() '(1 2 3))
;; '(1 (2 (3 ())))

(fold-left list '() '(1 2 3))
;; '(((() 1) 2) 3)

;; (op x y) == (op y x) 时, fold-right == fold-left
