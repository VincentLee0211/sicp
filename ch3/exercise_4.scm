#|
请修改练习3中的make-account过程, 加上另一个局部状态变量, 使得如果一个帐号被用不正确的密码连续访问7次, 它就将去调用过程call-the-cops
|#

(define make-account
  (lambda (balance secret)
    (let ((times 0))
      (define dispatch
        (lambda (pass m)
          (if (equal? pass secret)
              (begin (set! times 0)
                     (cond [(eq? m 'withdraw) withdraw]
                           [(eq? m 'deposit) deposit]
                           [else (error "unknown request -- MAKE-ACCOUNT" m)]))
              pass-error)))
      (define withdraw
        (lambda (amount)
          (if (>= balance amount)
              (begin (set! balance (- balance amount)) balance)
              "Insufficient funds")))
      (define deposit
        (lambda (amount)
          (set! balance (+ balance amount))
          balance))
      (define pass-error
        (lambda (amount)
          (if (= times 7)
              (call-the-cops)
              (begin (set! times (add1 times)) "Incorrect password"))))
      (define call-the-cops
        (lambda ()
          "Do Do Do..."))
      dispatch)))

(define add1 (lambda (x) (+ x 1)))
