;; 改变亦是赋值

#|
(define cons
  (lambda (x y)
    (define dispatch
      (lambda (m)
        (cond [(eq? m 'car) x]
              [(eq? m 'cdr) y]
              [else (error "Undefined operation -- CONS" m)])))
    dispatch))

(define car (lambda (z) (z 'car)))

(define cdr (lambda (z) (z 'cdr)))
|#

(define cons
  (lambda (x y)
    (define set-car!
      (lambda (v)
        (set! x v)))
    (define set-cdr!
      (lambda (v)
        (set! y v)))
    (define dispatch
      (lambda (m)
        (cond [(eq? m 'car) x]
              [(eq? m 'cdr) y]
              [(eq? m 'set-car!) set-car!]
              [(eq? m 'set-cdr!) set-cdr!]
              [else (error "Undefined operation -- CONS" m)])))
    dispatch))

(define car (lambda (z) (z 'car)))

(define cdr (lambda (z) (z 'cdr)))

(define set-car! (lambda (z new-value) ((z 'set-car!) new-value) z))

(define set-cdr! (lambda (z new-value) ((z 'set-cdr!) new-value) z))
