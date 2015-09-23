;; 集合(二叉树实现)

(library (set)
  (export union-set intersection-set element-of-set? adjoin-set)
  (import (rnrs base (6)))

  (define entry (lambda (tree) (car tree)))

  (define left-branch (lambda (tree) (cadr tree)))

  (define right-branch (lambda (tree) (caddr tree)))

  (define tree->list
    (lambda (tree)
      (if (null? tree)
          '()
          (append (tree->list (left-branch tree))
                  (cons (entry tree)
                        (tree->list (right-branch tree)))))))

  (define list->tree
    (lambda (elements)
      (define partial-tree
        (lambda (elts n)
          (if (zero? n)
              (cons '() elts)
              (let ((left-size (quotient (sub1 n) 2)))
                (let ((left-result (partial-tree elts left-size)))
                  (let ((left-tree (car left-result))
                        (non-left-elts (cdr result-result))
                        (right-size (- n (add1 left-size))))
                    (let ((this-entry (car non-left-elts))
                          (right-result (partial-tree (cdr non-left-elts) right-size)))
                      (let ((right-tree (car right-result))
                            (remaining-elts (cdr right-result)))
                        (cons (make-tree this-entry left-tree right-tree) remaining-tree)))))))))
      (car (partial-tree elements (length elements)))))

  (define union-set-list
    (lambda (slt1 slt2)
      (cond [(null? slt1) slt2]
            [(null? slt2) slt1]
            [else (let ((x1 (car slt1))
                        (x2 (car slt2)))
                    (cond [(= x1 x2)
                           (cons x1 (union-set-list (cdr slt1) (cdr slt2)))]
                          [(< x1 x2)
                           (cons x1 (union-set-list (cdr slt1) slt2))]
                          [(> x1 x2)
                           (cons x2 (union-set-list slt1 (cdr slt2)))]))])))

  (define intersection-set-list
    (lambda (slt1 slt2)
      (if (or (null? slt1) (null? slt2))
          '()
          (let ((x1 (car slt1))
                (x2 (car slt2)))
            (cond [(= x1 x2)
                   (cons x1 (intersection-set-list (cdr slt1) (cdr slt2)))]
                  [(< x1 x2)
                   (intersection-set-list (cdr slt1) set2)]
                  [(> x1 x2)
                   (intersection-set-list slt1 (cdr slt2))])))))

  (define make-tree
    (lambda (entry left right)
      (list entry left right)))

  (define element-of-set?
    (lambda (x set)
      (cond [(null? set) #f]
            [(= x (entry set)) #t]
            [(< x (entry set))
             (element-of-set? x (left-branch set))]
            [(> x (entry set))
             (element-of-set? x (right-branch set))])))

  (define adjoin-set
    (lambda (x set)
      (cond [(null? set) (make-tree x '() '())]
            [(= x (entry set)) set]
            [(< x (entry set))
             (make-tree (entry set)
                        (adjoin-set x (left-branch set))
                        (right-branch set))]
            [(> x (entry set))
             (make-tree (entry set)
                        (left-branch set)
                        (adjoin-set x (right-branch set)))])))

  (define union-set
    (lambda (set1 set2)
      (list->tree
       (union-set-list
        (tree->list set1)
        (tree->list set2)))))

  (define intersection-set
    (lambda (set1 set2)
      (list->tree
       (intersection-list
        (tree->list set1)
        (tree->list set2))))))
