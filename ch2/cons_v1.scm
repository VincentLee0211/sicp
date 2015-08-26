;; 使用过程表示序对

(define cons
  (lambda (x y)
    (define dispatch
      (lambda (m)
        (cond ((= m 0) x)
              ((= m 1) y)
              (else (error "Argument not 0 or 1 -- CONS" m)))))
    dispatch))

(define (car z) (z 0))
(define (cdr z) (z 1))
