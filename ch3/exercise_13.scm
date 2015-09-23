(define make-cycle
  (lambda (x)
    (set-cdr! (last-pair x) x)
    x))

(define last-pair
  (lambda (x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x)))))

(define z (make-cycle '(a b c)))

;; 循环结果, (last-pair z) 无法停机
