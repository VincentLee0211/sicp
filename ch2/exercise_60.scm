;; 集合作为未排序的表, 且允许元素重复

(define element-of-set?
  (lambda (x set)
    (cond [(null? set) #f]
          [(equal? x (car set)) #t]
          [else (element-of-set? x (cdr set))])))

(define adjoin-set
  (lambda (x set)
    (cons x set)))

(define union-set
  (lambda (set1 set2)
    (append set1 set2)))

(define intersection-set
  (lambda (set1 set2)
    (cond [(or (null? set1) (null? set2)) '()]
          [(element-of-set? (car set1) set2)
           (cons (car set1)
                 (intersection-set (cdr set1) set2))]
          [else (intersection-set (cdr set1) set2)])))
