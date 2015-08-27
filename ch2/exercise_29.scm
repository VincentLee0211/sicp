#|
一个二叉活动体由两个分支组成, 一个是左分支, 另一个是有分支.
每个分支是一个具有确定长度的杆, 上面或者吊着一个重量, 或者吊着另一个二叉活动体.

我们可以用复合数据对象表示这种二叉活动体, 将它通过其两个分支构造起来:
|#

(define make-mobile
  (lambda (left right)
    (list left right)))

#|
分支可以从一个 length 再加上一个 structure 构造出来, 这个 structure 或者是一个数, 或者是另一个活动体:
|#

(define make-branch
  (lambda (length structure)
    (list length structure)))

#|
a.
请写出响应的选择函数 left-branch 和 right-branch, 它们分别返回活动体的两个分支.
还有 branch-length 和 branch-structure, 它们返回一个分支上的成分

b.
用你的选择函数定义过程 total-weight, 它返回一个活动体的总重量.

c.
一个活动体称为是平衡的, 如果其左分支的力矩等于其右分支的力矩, 而且在其每个分支上吊着的子活动体也都平衡. 请设计一个过程, 它能检查一个二叉活动体是否平衡.

d.
假定我们改变活动体的表示, 采用下面构造方式

(define make-mobile
  (lambda (left right)
    (cons left right)))

(define make-branch
  (lambda (length structure)
    (cons length structure)))

你需要对自己的程序做多上修改, 才能将它改为使用这种新表示?
|#

(define left-branch (lambda (mobile) (car mobile)))
(define right-branch (lambda (mobile) (cadr mobile)))

(define branch-length (lambda (branch) (car branch)))
(define branch-structure (lambda (branch) (cadr branch)))

;; -------------------------------------------------------------------------------------------------

(define total-weight
  (lambda (mobile)
    (+ (branch-weight (left-branch mobile))
       (branch-weight (right-branch mobile)))))

(define branch-weight
  (lambda (branch)
    (* (branch-length branch)
       (if (pair? (branch-structure branch))
           (total-weight (branch-structure branch))
           (branch-structure branch)))))

;; -------------------------------------------------------------------------------------------------

(define balance-mobile?
  (lambda (mobile)
    (if (not (pair? mobile))
        #t
        (and (balance-mobile? (branch-structure (left-branch mobile)))
             (balance-mobile? (branch-structure (right-branch mobile)))
             (= (branch-weight (left-branch mobile))
                (branch-weight (right-branch mobile)))))))

;; -------------------------------------------------------------------------------------------------

;; 修改构造函数之后,
;;
;; (define right-branch (lambda (mobile) (cdr mobile)))
;; (define branch-struct (lambda (branch) (cdr branch)))

;; 测试
(define C (make-branch 5 20))
(define D (make-branch 5 20))
(define E (make-branch 20 100))

(define B (make-branch 10 (make-mobile C D)))

(define A (make-mobile B E))

(total-weight A)
;; 4000

(balance-mobile? A)
;; #t
