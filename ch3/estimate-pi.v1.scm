;; 蒙特卡罗方法(使用赋值)

(define rand
  (let ((random-init 0))
    (let ((x random-init))
      (lambda ()
        (define random-update
          (lambda (n)
            (let ((a 6364136223846793005)
                  (c 1442695040888963407)
                  (m (expt 2 64)))
              (remainder (+ (* a n) c) m))))
        (set! x (random-update x))
        x))))

(define estimate-pi
  (lambda (trials)
    (sqrt (/ 6 (monte-carlo trials cesaro-test)))))

(define cesaro-test
  (lambda ()
    (one? (gcd (rand) (rand)))))

(define monte-carlo
  (lambda (trials experiment)
    (define iter
      (lambda (trials-remaining trials-passed)
        (cond [(zero? trials-remaining)
               (/ trials-passed trials)]
              [(experiment)
               (iter (sub1 trials-remaining) (add1 trials-passed))]
              [else
               (iter (sub1 trials-remaining) trials-passed)])))
    (iter trials 0)))

(define one? (lambda (x) (= x 1)))
(define zero? (lambda (x) (= x 0)))

(define add1 (lambda (x) (+ x 1)))
(define sub1 (lambda (x) (- x 1)))
