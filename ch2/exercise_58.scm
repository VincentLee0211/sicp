#|
Suppose we wnat to modify the differentiation program so that it works with ordinary mathematical notation, in which + and * are infix rather than prefix operators. Since the differentiation program is defined in terms of abstract data, we can modify it wo work with different representations of expressions solely by changing the predicates, selectors, and constructors that difine the representation of the algebraic expressions on which the differentiator is to operate

a. Show how to do this in order to differentiate algebraic expressions presented in infix form, such as (x + (3 * (x + (y + 2)))). To simplify the task, assume that + and * always take two arguments and that expressions are fully parenthesized.

b. The program becomes substantially harder if we allow standard algebraic notation, such as (x + 3 * (x + y + 2)), which drops unnecessary parentheses and assumes that multiplication is done before addition. Can you design appropriate predicates, selectors, and constructors for this notation such that our derivative program still works?
|#

;; A-------------------
(define deriv
  (lambda (expr var)
    (cond ((number? expr) 0)
          ((variable? expr)
           (if (same-variable? expr var) 1 0))
          ((sum? expr)
           (make-sum
            (deriv (addend expr) var)
            (deriv (augend expr) var)))
          ((product? expr)
           (make-sum
            (make-product (multiplier expr)
                          (deriv (multiplicand expr) var))
            (make-product (deriv (multiplier expr) var)
                          (multiplicand expr))))
          (else
           (error "unknown expression type -- DERIV" exp)))))

(define make-sum
  (lambda (a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((or (number? a1) (number? a2)) (+ a1 a2))
          (else (list a1 '+ a2)))))

(define addend (lambda (s) (car s)))
(define augend (lambda (s) (caddr s)))

(define sum?
  (lambda (x)
    (and (pair? x) (eq? (cadr x) '+))))

(define make-product
  (lambda (m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list m1 '* m2)))))

(define multiplier (lambda (s) (car s)))
(define multiplicand (lambda (s) (caddr s)))

(define product?
  (lambda (x)
    (and (pair? x) (eq? (cadr x) '*))))

;; B--------------------------------------------------------
(define _deriv
  (lambda (expr var)
    (cond ((_number? expr) 0)
          ((_variable? expr)
           (if (_same-variable? expr var) 1 0))
          ((_sum? expr)
           ...)
          ((_product? expr)
           ...)
          (else
           (error "unknown expression type --DERIV" exp)))))
