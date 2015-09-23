(define cycle?
  (lambda (x)
    (define iter
      (lambda (lst memoriz)
        (cond [(not (pair? lst)) #f]
              [(memq lst memoriz) #t]
              [else (iter (cdr lst) (cons lst memoriz))])))
    (iter x '())))

(define x '(a b c))

(set-cdr! (last-pair x) x)

(define last-pair
  (lambda (x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x)))))
