;; 将上节的 count-leaves 重新定义为一个累积:

(define count-leaves
  (lambda (t)
    (accumualte +
                0
                (map (lambda (x) 1)
                     (enumerate-tree t)))))

(define map
  (lambda (proc items)
    (if (null? items)
        '()
        (cons (proc (car items))
              (map proc (cdr items))))))

(define accumulate
  (lambda (op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence))))))

(define enumerate-tree
  (lambda (tree)
    (cond ((null? tree) '())
          ((not (pair? tree)) (list tree))
          (else (append (enumerate-tree (car tree))
                        (enumerate-tree (cdr tree)))))))

;; 测试
(count-leaves '(1 (2 (3 4) 5) 6))
;; 6
