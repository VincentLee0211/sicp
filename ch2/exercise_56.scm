#|
Show how to extend the basic differentiator to handle more kinds of expressions. For instance, implement the differentiation rule

d(u^n)/dx = nu^(n-1)(du/dx)

by adding a new clause to the deriv program and defining appropriate procedures
exponentiation?, base, exponent, and make-exponentiation.

Build in the rules that anything raised to the power 0 is 1 and anything raised to the power 1 is the thing itself.
|#

(define deriv
  (lambda (exp var)
    (cond ((number? exp) 0)
          ((variable? exp)
           (if (same-variable? exp var) 1 0))
          ((sum? exp)
           (make-sum (deriv (addend exp) var)
                     (deriv (augend exp) var)))
          ((product? exp)
           (make-sum
            (make-product (multiplier exp)
                          (deriv (multiplicand exp) var))
            (make-product (deriv (multiplier exp) var)
                          (multiplicand exp))))
          ((exponentiation? exp)
           (make-product (exponent exp)
                         (make-product
                          (make-exponentiation (base exp)
                                               (make-sum (exponent exp) -1))
                          (deriv (base exp) var))))
          (else
           (error "unknown expression type -- DERIV" exp)))))

(define make-sum
  (lambda (a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2)))))

(define make-product
  (lambda (m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2)))))

(define make-exponentiation
  (lambda (base exp)
    (cond ((or (=number? base 1) (=number? exp 0)) 1)
          ((and (number? base) (number? exp)) (expt base exp))
          (else (list '** base exp)))))

(define addend (lambda (s) (cadr s)))
(define augend (lambda (s) (caddr s)))

(define multiplier (lambda (p) (cadr p)))
(define multiplicand (lambda (p) (caddr p)))

(define base (lambda (e) (cadr e)))
(define exponent (lambda (e) (caddr e)))

(define sum? (lambda (x) (and (pair? x) (eq? (car x) '+))))
(define product? (lambda (x) (and (pair? x) (eq? (car x) '*))))
(define exponentiation? (lambda (x) (and (pair? x) (eq? (car x) '**))))

(define =number?
  (lambda (exp num)
    (and (number? exp) (= exp num))))

(define sub1
  (lambda (x)
    (- x 1)))

(define one?
  (lambda (x)
    (= x 1)))

(define zero?
  (lambda (x)
    (= x 0)))
