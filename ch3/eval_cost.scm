;; 赋值的代价

(define make-simplified-withdraw
  (lambda (balance)
    (lambda (amount)
      (set! balance (- balance amount))
      balance)))

(define W (make-simplified-withdraw 25))

(define make-decrementer
  (lambda (balance)
    (lambda (amount)
      (- balance amount))))

(define D (make-decrementer 25))

;; 同一和变化

;; 可以用D1替换D2
(define D1 (make-decrementer 25))
(define D2 (make-decrementer 25))

;; 替换之后就不一样的结果
(define W1 (make-simplified-withdraw 25))
(define W2 (make-simplified-withdraw 25))
