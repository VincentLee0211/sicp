;; 下面两个过程都能将树变换为表:

(define tree->list-1
  (lambda (tree)
    (if (null? tree)
        '()
        (append (tree->list-1 (left-branch tree))
                (cons (entry tree)
                      (tree->list-1 (right-branch tree)))))))

(define tree->list-2
  (lambda (tree)
    (define copy-to-list
      (lambda (tree result-list)
        (if (null? tree)
            result-list
            (copy-to-list (left-branch tree)
                          (cons (entry tree)
                                (copy-to-list (right-branch tree)
                                              result-list))))))
    (copy-to-list tree '())))

;; 两个过程产生相同的结果

;; tree->list-2 要慢
;; 因为tree->list-1需要append操作
