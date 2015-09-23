(define random-in-range
  (lambda (low high)
    (let ((range (- high low)))
      (+ low (random range)))))

(define estimate-integral
  (lambda (p x1 x2 y1 y2 trials)
    (let ((xlow (min x1 x2))
          (xhigh (max x1 x2))
          (ylow (min y1 y2))
          (yhigh (max y1 y2)))
      (* (rect-area x1 x2 y1 y2)
         (monte-carlo trials (p (random-in-range xlow xhigh)
                                (random-in-range ylow yhigh)))))))

(define P?
  (lambda (x y)
    (lambda ()
      (<= (+ (expt (- x 5) 2)
             (expt (- y 7) 2))
          (expt 3 2)))))

(define rect-area
  (lambda (x1 x2 y1 y2)
    (* (abs (- x1 x2)) (abs (- y1 y2)))))

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

(define zero? (lambda (x) (= x 0)))

(define sub1 (lambda (x) (- x 1)))

(define add1 (lambda (x) (+ x 1)))
