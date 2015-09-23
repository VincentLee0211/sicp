(define f
  (let ((init 1/2))
    (lambda (x)
      (set! init (- x init))
      init)))

(f 0) ;; -1/2
(f 1) ;; 3/2

(f 1) ;; 1/2
(f 0) ;; -1/2
