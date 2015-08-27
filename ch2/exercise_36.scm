#|
过程 accumulate-n 与 accumulate 类似, 除了它的第三个参数是一个序列的序列, 假定其中每个序列的元素个数相同. 它用指定的累积过程去组合起所有序列的第一个元素, 而后是所有序列的第二个元素, 并如此下去, 返回得到的所有结果的序列.

例如, 如果 s 是包含着4个序列的序列 ((1 2 3) (4 5 6) (7 8 9) (10 11 12)), 那么(accumulate-n + 0 s) 的值就应该是序列 (22 26 30).

请填充下面 accumulate-n 定义中所缺失的表达式
|#

(define accumulate-n
  (lambda (op init seqs)
    (if (null? (car seqs))
        '()
        (cons (accumulate op
                          init
                          (map car seqs))
              (accumulate-n op
                            init
                            (map cdr seqs))))))

(define map
  (lambda (op sequence)
    (if (null? sequence)
        '()
        (cons (op (car sequence))
              (map op (cdr sequence))))))

(define accumulate
  (lambda (op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence))))))

;; 测试
(accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
