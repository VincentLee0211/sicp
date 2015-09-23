;; 实例: 集合的表示
;;
;; 集合操作
;; + union-set          计算集合的并集
;; + intersection-set   计算集合的交集
;; + element-of-set?    用于确定某个给定元素是不是某个给定集合的成员
;; + adjoin-set         以一个对象和一个集合为参数, 返回一个集合. 包含原集合元素和该元素

;; 集合作为未排序的表
(define element-of-set?
  (lambda (x set)
    (cond [(null? set) #f]
          [(equal? x (car set)) #t]
          [else (element-of-set?.v1 x (cdr set))])))

(define adjoin-set
  (lambda (x set)
    (if (element-of-set? x set)
        set
        (cons x set))))

(define intersection-set
  (lambda (set1 set2)
    (cond [(or (null? set1) (null? set2)) '()]
          [(element-of-set? (car set1) set2)
           (cons (car set1) (intersection-set (cdr set1) set2))]
          [else (intersection-set (cdr set1) set2)])))

(define union-set
  (lambda (set1 set2)
    (cond [(null? set1) set2]
          [(null? set2) set1]
          [(element-of-set? (car set1) set2)
           (union-set (cdr set1) set2)]
          [else (cons (car set1)
                      (union-set (cdr set1) set2))])))
