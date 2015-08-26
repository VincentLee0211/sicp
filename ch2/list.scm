;; list 的各种操作

;; 辅助函数
(define inc (lambda (x) (+ x 1)))

(define dec (lambda (x) (- x 1)))

(define one? (lambda (x) (= x 1)))

;; 表长度
(define length
  (lambda (items)
    (if (null? items)
        0
        (inc (length (cdr items))))))

(define &length
  (lambda (items)
    (define iter
      (lambda (lst counter)
        (if (null? lst)
            counter
            (iter (cdr lst) (inc counter)))))
    (iter items 0)))

;; 取表元素
(define list-ref
  (lambda (items n)
    (if (one? n)
        (car items)
        (list-ref (cdr items) (dec n)))))

;; 拼接表
(define append
  (lambda (l1 l2)
    (if (null? l1)
        l2
        (cons (car l1) (append (cdr l1) l2)))))

;; 测试
(define squares '(1 4 9 16 25))

(list-ref squares 3)
;; 16

(define odds '(1 3 5 7))

(length odds)
;; 4

(append squares odds)
;; '(1 4 9 16 25 1 3 5 7)

(append odds squares)
;; '(1 3 5 7 1 4 9 16 25)
