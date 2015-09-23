(define make-account
  (lambda (balance pass)
    (define dispatch
      (lambda (secret m)
        (if (eq? secret pass)
            (cond [(eq? m 'withdraw) withdraw]
                  [(eq? m 'deposit) deposit]
                  [(eq? m 'check-pass) check-pass]
                  [else "unknown request -- DISPATCH" m])
            pass-error)))
    (define withdraw
      (lambda (amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount)) balance)
            "Insufficient funds")))
    (define deposit
      (lambda (amount)
        (set! balance (+ balance amount))))
    (define pass-error
      (lambda (amount)
        "Incorrect password"))
    dispatch))

(define acc (make-account 100 'secret-password))

(define make-joint
  (lambda (account acc-pass pass)
    (lambda (secret m)
      (define pass-error
        (lambda (amount)
          "Incorrect password"))
      (if (eq? secret pass)
          (account acc-pass m)
          pass-error))))

(define peter-acc (make-account 100 'open-sesame))

(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))
