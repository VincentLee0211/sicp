(define random-init 0)

(define rand-update
  (lambda (x)
    (let ((a 6364136223846793005)
          (c 1442695040888963407)
          (m (expt 2 64)))
      (remainder (+ (* a x) c) m))))

#|
(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x)))
|#

(define rand
  (let ((x random-init))
    (define dispatch
      (lambda (m)
        (cond [(eq? m 'generate) (generate)]
              [(eq? m 'reset) reset]
              [else "unknown request -- RAND" m])))
    (define generate
      (lambda ()
        (set! x (rand-update x))
        x))
    (define reset
      (lambda (n)
        (set! x n)))
    dispatch))
