;; 基于练习38的 fold-right 和 fold-left 完成 reverse 下面的定义:

(define reverse.v1
  (lambda (sequence)
    (fold-right (lambda (x y) (append y (list x)))
                '()
                sequence)))

(define reverse.v2
  (lambda (sequence)
    (fold-left (lambda (x y) (cons y x))
               '()
               sequence)))

(define fold-right
  (lambda (op initial sequence)
    (if (null? sequence)
        '()
        (op (car sequence)
            (fold-right op initial (cdr sequence))))))

(define fold-left
  (lambda (op initial sequence)
    (define iter
      (lambda (result rest)
        (if (null? rest)
            result
            (iter (op result (car rest))
                  (cdr rest)))))
    (iter initial sequence)))

;; 测试
(reverse.v1 '(1 2 3 4 5 6))

(reverse.v2 '(1 2 3 4 5 6))
