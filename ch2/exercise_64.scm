;; 将有序表变换为一颗平衡二叉树

(define list->tree
  (lambda (elements)
    (car (partial-tree elements (length elements)))))

(define partial-tree
  (lambda (elts n)
    (if (zero? n)
        (cons '() elts)
        (let ((left-size (quotient (sub1 n) 2)))
          (let ((left-result (partial-tree elts left-size)))
            (let ((left-tree (car left-result))
                  (non-left-elts (cdr left-result))
                  (right-size (- n (add1 left-size))))
              (let ((this-entry (car non-left-elts))
                    (right-result (partial-tree (cdr non-left-elts) right-size)))
                (let ((right-tree (car right-result))
                      (remaining-elts (cdr right-result)))
                  (cons (make-tree this-entry left-tree right-tree) remaining-elts)))))))))
