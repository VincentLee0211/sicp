(define mystery
  (lambda (x)
    (define loop
      (lambda (x y)
        (if (null? x)
            y
            (let ((temp (cdr x)))
              (set-cdr! x y)
              (loop temp x)))))
    (loop x '())))

;; 效果等同于reverse

(define v '(a b c d))
(define w (mystery v)) ;; (d c b a)
