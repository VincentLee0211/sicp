;; 集合作为排序的表, 使集合元素按字典顺序升序排列

(define element-of-set?
  (lambda (x set)
    (cond [(null? set) #f]
          [(= x (car set)) #t]
          [(< x (car set)) #f]
          [else (element-of-set? x (cdr set))])))

(define intersection-set
  (lambda (set1 set2)
    (if (or (null? set1) (null? set2))
        '()
        (let ((x (car set1))
              (y (car set2)))
          (cond [(= x y) (cons x (intersection-set (cdr set1) (cdr set2)))]
                [(< x y) (intersection-set (cdr set1) set2)]
                [(> x y) (intersection-set set1 (cdr set2))])))))

(define adjoin-set
  (lambda (x set)
    (if (null? set)
        (cons x set)
        (let ((y (car set)))
          (cond [(= x y) set]
                [(< x y) (cons x set)]
                [(> x y) (cons y (adjoin-set x (cdr set)))])))))

(define union-set
  (lambda (set1 set2)
    (cond [(null? set1) set2]
          [(null? set2) set1]
          [else (let ((x (car set1))
                      (y (car set2)))
                  (cond [(= x y) (cons x (union-set (cdr set1) (cdr set2)))]
                        [(< x y) (cons x (union-set (cdr set1) set2))]
                        [(> x y) (cons y (union-set set1 (cdr set2)))]))])))
