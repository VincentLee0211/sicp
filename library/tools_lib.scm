(library (tools)
  (export one? add1 sub1 atom? first second third build)
  (import (rnrs base (6)))

  (define one? (lambda (x) (= x 1)))

  (define add1 (lambda (x) (+ x 1)))
  (define sub1 (lambda (x) (- x 1)))

  (define atom? (lambda (x) (and (not (pair? x)) (not (null? x)))))

  (define first (lambda (x) (car x)))
  (define second (lambda (x) (cadr x)))
  (define third (lambda (x) (caddr x)))
  (define build (lambda (x y) (cons x (cons y '())))))
