#|
Extend the differentiation program to handle sums and products of arbitrary numbers of (two or more) terms. Then the last example above could be expressed as

(deriv '(* x y (+ x 3)) 'x)

Try to do this by changing only the representation for sums and products, without changing the deriv procedure at all. For example, the addend of a sum would be the first term, and the augend would be the sum of the rest of the terms
|#

(define deriv
  (lambda (expr var)
    (cond ((number? expr) 0)
          ((variable? expr)
           (if (same-variable? expr var) 1 0))
          ((sum? expr)
           (make-sum (deriv (addend expr) var)
                     (deriv (augend expr) var)))
          ((product? expr)
           (make-sum
            (make-product (multiplier expr)
                          (deriv (multiplicand expr) var))
            (make-product (deriv (multiplier expr) var)
                          (multiplicand expr))))
          (else
           (error "unknown expression type -- DERIV" expr)))))

(define make-sum
  (lambda (a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2)))))

(define addend (lambda (s) (cadr s)))
(define augend
  (lambda (s)
    (if (null? (cdddr s))
        (caddr s)
        (cons (car s) (cddr s)))))

(define sum? (lambda (x) (and (pair? x) (eq? (car x) '+))))

(define make-product
  (lambda (m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2)))))

(define multiplier (lambda (s) (cadr s)))
(define multiplicand
  (lambda (s)
    (if (null? (cdddr s))
        (caddr s)
        (cons (car s) (cddr s)))))

(define product? (lambda (x) (and (pair? x) (eq? (car x) '*))))

(define variable? (lambda (expr) (symbol? expr)))
(define same-variable?
  (lambda (v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2))))

(define =number?
  (lambda (expr num)
    (and (number? expr) (= expr num))))
