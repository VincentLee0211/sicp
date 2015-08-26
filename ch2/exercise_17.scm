#|
请定义出过程 last-pair, 它返回只包含给定(非空)表里最后一个元素的表

(last-pair '(23 72 149 34))
(34)
|#

(define last-pair
  (lambda (lst)
    (if (null? (cdr lst))
        lst
        (last-pair (cdr lst)))))

(last-pair '(23 72 149 34))
