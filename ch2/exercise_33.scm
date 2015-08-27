;; 请填充下面缺失的表达式, 完成这一些基本的表操作看作累积的定义

(define accumulate
  (lambda (op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence))))))

;; 对当前元素执行 proc, 然后通过 cons 将结果追加到后面准备好的序列中
(define map
  (lambda (p sequence)
    (accumulate (lambda (x y) (cons (p x) y))
                '()
                sequence)))

;; 1. 若 seq1 为'(), 则直接返回 seq2
;; 2. 将当前元素追加到后续元素 append 完成的序列里
(define append
  (lambda (seq1 seq2)
    (accumulate cons seq1 seq2)))

;; 后续序列长度+1
(define length
  (lambda (sequence)
    (accumulate (lambda (x y) (inc y)) 0 sequence)))

(define inc (lambda (x) (+ x 1)))

;; 测试
(define x '(1 2 3 4 5 6))

(map square x)
;; (1 4 9 16 25)

(append x x)
;; (1 2 3 4 5 6 1 2 3 4 5 6)

(length x)
;; 6
