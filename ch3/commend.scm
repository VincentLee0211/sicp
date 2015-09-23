;; 命令式程序设计的缺陷

(define factorial.v1
  (lambda (n)
    (define iter
      (lambda (product counter)
        (if (> counter n)
            product
            (iter (* product counter)
                  (+ counter 1)))))
    (iter 1 1)))

(define factorial.v2
  (lambda (n)
    (let ((product 1)
          (counter 1))
      (define iter
        (lambda ()
          (if (> counter n)
              product
              (begin (set! product (* product counter))
                     (set! counter (+ counter 1))
                     (iter)))))
      (iter))))
