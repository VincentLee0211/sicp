;; 包含序列的序列

(define inc (lambda (x) (+ x 1)))

;; 计算序列的长度
(define length
  (lambda (lst)
    (if (null? lst)
        0
        (inc (length (cdr lst))))))

;; 计算一棵数中树叶的数目
(define count-leaves
  (lambda (tree)
    (cond ((null? tree) 0)
          ((not (pair? tree)) 1 )
          (else (+ (count-leaves (car tree))
                   (count-leaves (cdr tree)))))))

;; 测试
(define x '((1 2) 3 4))

(length x)

(count-leaves x)
