(define fib
  (lambda (n)
    (cond [(zero? n) 0]
          [(one? n) 1]
          [else (+ (fib (sub1 n)) (fib (- n 2)))])))

(define memo-fib
  (memoize (lambda (n)
             (cond [(zero? n) 0]
                   [(one? n) 1]
                   [else (+ (memo-fib (sub1 n))
                            (memo-fib (- n 2)))]))))

(define memoize
  (lambda (f)
    (let ((table (make-table)))
      (lambda (x)
        (let ((previously-computed-result (lookup x table)))
          (or previously-computed-result
              (let ((result (f x)))
                (insert! x result table)
                result)))))))
