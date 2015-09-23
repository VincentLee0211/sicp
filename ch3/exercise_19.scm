(define cycle?
  (lambda (lst)
    (define safe-cdr
      (lambda (l)
        (if (pair? l)
            (cdr l)
            '())))
    (define iter
      (lambda (a b)
        (cond [(not (pair? a)) #f]
              [(not (pair? b)) #f]
              [(eq? a b) #t]
              [(eq? a (safe-cdr b)) #t]
              [else (iter (safe-cdr lst) (safe-cdr (safe-cdr lst)))])))
    (iter (safe-cdr lst) (safe-cdr (safe-cdr lst)))))
