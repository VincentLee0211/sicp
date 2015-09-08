#|
如果两个表包含同样元素, 这些元素也按同样顺序排列, 那么就称这两个表 equal?

例如:
(equal? '(this is a list) '(this is a list))     #t
(equal? '(this is a list) '(this (is a ) list))  #f

说得更准确些, 我们可以从符号相等的基本 eq? 出发, 以递归方式定义出 equal?
a 和 b 是 equal?的, 如果它们都是符号, 而且这两个符号满足 eq?; 或者它们都是表, 而且(car a) 和 (car b) 相互 equal?, 它们的 (cdr a) 和 (cdr b) 也是 equal?

请利用这一思路定义出 equal? 过程
|#

;; eq? 判断两个符号相等

;; eqan? 判断符号和数字相等
(define eqan?
  (lambda (a1 a2)
    (cond ((and (number? a1) (number? a2)) (= a1 a2))
          ((or (number? a1) (number? a2)) #f)
          (else (eq? a1 a2)))))

;; eqlist? 判断序列相等
(define eqlist?
  (lambda (l1 l2)
    (cond ((and (null? l1) (null? l2)) #t)
          ((or (null? l1) (null? l2)) #f)
          (else (and (equal? (car l1) (car l2))
                     (eqlist? (cdr l1) (cdr l2)))))))

(define atom?
  (lambda (x)
    (and (not (null? x)) (not (pair? x)))))

;; equal? 判断S-表达式相等
(define equal?
  (lambda (s1 s2)
    (cond ((and (atom? s1) (atom? s2))
           (eqan? s1 s2))
          ((or (atom? s1) (atom? s2))
           #f)
          (else (eqlist? s1 s2)))))
