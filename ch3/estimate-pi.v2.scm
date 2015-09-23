;; 蒙特卡罗模拟(迭代)

(define estimate-pi
  (lambda (trials)
    (sqrt (/ 6 (random-gcd-test trials random-init)))))

(define random-gcd-test
  (lambda (trials initial-x)
    (define iter
      (lambda (trials-remaining trials-passed x)
        (let ((x1 (rand-update x)))
          (let ((x2 (rand-update x1)))
            (cond [(zero? trials-remaining)
                   (/ trials-passed trials)]
                  [(one? (gcd x1 x2))
                   (iter (sub1 trials-remaining) (add1 trials-passed) x2)]
                  [else
                   (iter (sub1 trials-remaining) trials-passed x2)])))))
    (iter trials 0 initial-x)))

(define random-init 0)

(define rand-update
  (lambda (x)
    (let ((a 6364136223846793005)
          (c 1442695040888963407)
          (m (expt 2 64)))
      (remainder (+ (* a x) c) m))))

(define zero? (lambda (x) (= x 0)))

(define one? (lambda (x) (= x 1)))

(define sub1 (lambda (x) (- x 1)))

(define add1 (lambda (x) (+ x 1)))
