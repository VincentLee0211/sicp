(define x '(a b))
(define z1 (cons x x))

(define z2 (cons '(a b) '(a b)))

(define set-to-wow!
  (lambda (x)
    (set-car! (car x) 'wow)
    x))
