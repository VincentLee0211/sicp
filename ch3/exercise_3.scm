#|
请修改make-account过程, 使它能创建一种带密码保护的账户
也就是说应该让make-account以一个符号作为附加的参数,

(define acc (make-account 100 'secret-password))

这样产生的账户对象在接到一个请求时, 只有同时提供了帐号创建时给定的密码, 它才处理这一请求,
否则就发生一个抱怨信息

((acc 'secret-password 'withdraw) 40)
60

((acc 'some-other-password 'deposit) 50)
"Incorrect password"
|#

(define make-account
  (lambda (balance secret)
    (define dispatch
      (lambda (pass m)
        (if (eq? pass secret)
            (cond [(eq? m 'withdraw) withdraw]
                  [(eq? m 'deposit) deposit]
                  [else (error "unknown request -- MAKE-ACCOUNT" m)])
            (lambda (amount) "Incorrect password"))))
    (define withdraw
      (lambda (amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount)) balance)
            "Insufficient funds")))
    (define deposit
      (lambda (amount)
        (set! balance (+ balance amount))
        balance))
    dispatch))
