(define append
  (lambda (x y)
    (if (null? x)
        y
        (cons (car x) (append (cdr x) y)))))

(define append!
  (lambda (x y)
    (set-cdr! (last-pair x) y)
    x))

(define last-pair
  (lambda (x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x)))))

(define x '(a b))
(define y '(c d))
(define z (append x y))

z
;; (a b c d)

(cdr x)
;; (b)

(define w (append! x y))

w
;; (a b c d)

(cdr x)
;; (b c d)
