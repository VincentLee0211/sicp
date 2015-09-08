;; 符号求导
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
          (else
           (error "unknown expression type -- DERIV" exp)))))

;; 谓词
(define variable?
  (lambda (x)
    (symbol? x)))

(define same-variable?
  (lambda (exp var)
    (and (variable? exp)
         (variable? var)
         (eq? exp var))))

;; 构造函数和选择函数
#|
(define make-sum
  (lambda (a1 a2)
    (list '+ a1 a2)))
|#
;; 化简
(define make-sum
  (lambda (a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2)))))

(define =number?
  (lambda (exp num)
    (and (number? exp) (= exp num))))

(define addend
  (lambda (s)
    (cadr s)))

(define augend
  (lambda (s)
    (caddr s)))

(define sum?
  (lambda (exp)
    (and (pair? exp) (eq? (car exp) '+))))

#|
(define make-product
  (lambda (m1 m2)
    (list '* m1 m2)))
|#
;; 化简
(define make-product
  (lambda (m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2)))))

(define multiplier
  (lambda (p)
    (cadr p)))

(define multiplicand
  (lambda (p)
    (caddr p)))

(define product?
  (lambda (p)
    (and (pair? p) (eq? (car p) '*))))
