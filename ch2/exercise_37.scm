#|
使用解释器提供的 map 函数

假定我们将向量 V=(vi) 表示为数的序列, 将矩阵 m = (mij) 表示为向量的序列

例如, 矩阵:
  1  2  3  4
  4  5  6  7
  6  7  8  9

用序列 ((1 2 3 4) (4 5 6 7) (6 7 8 9)) 表示.
对于这种表示, 我们可以用序列操作简洁地表达基本的矩阵与向量运算.
这些运算如下:
(dot-product v w)
(matrix-*-vector m v)
(matrix-*-matrix m n)
(transpose m)

我们可以将点积(dot-product)定义为:

需要填充下面过程缺失表达式, 它们计算出其他的矩阵运算结果
|#

(define dot-product
  (lambda (v w)
    (accumualte + 0 (map * v w))))

(define matrix-*-vector
  (lambda (m v)
    (map (lambda (w) (dot-product w v)) m)))

(define transpose
  (lambda (mat)
    (accumulate-n cons '() mat)))

(define matrix-*-matrix
  (lambda (m n)
    (let ((cols (transpose n)))
      (map (lambda (w) (matrix-*-vector cols w)) m))))

(define accumulate
  (lambda (op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumualte op initial (cdr sequence))))))
#|
(define map
  (lambda (op sequence)
    (if (null? sequence)
        '()
        (cons (op (car sequence))
              (map op (cdr sequence))))))
|#

(define accumulate-n
  (lambda (op initial seqs)
    (if (null? (car seqs))
        '()
        (cons (accumulate op initial (map car seqs))
              (accumulate-n op initial (map cdr seqs))))))

(define m '((1 2 3 4) (4 5 6 6) (6 7 8 9)))

(define w '(1 2 3 4))
