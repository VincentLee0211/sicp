;; 随机数生成器LCG

(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (random-update x))
      x)))

(define random-init 0)

(define random-update
  (lambda (x)
    (let ((a 6364136223846793005)
          (c 1442695040888963407)
          (m (expt 2 64)))
      (remainder (+ (* a x) c) m))))
