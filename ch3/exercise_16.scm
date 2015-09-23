;; 统计表结构的序对个数

(define count-pairs
  (lambda (x)
    (if (not (pair? x))
        0
        (+ (count-pairs (car x))
           (count-pairs (cdr x))
           1))))

;; 3
(define x '(a b c))

(define make-cycle
  (lambda (x)
    (set-cdr! (last-pair x) x)
    x))

(define last-pair
  (lambda (x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x)))))

;; 无法返回
(define y (make-cycle '(a b c)))

;; 4
(define z '((a b) c))

;; 7
(define m '((a b) (a b) b))
