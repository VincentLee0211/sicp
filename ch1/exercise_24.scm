#|
修改练习22的 timed-prime-test 过程, 让它使用 fast-prime?, 并检查你在该练习中找出的12个素数. 
|#

(define times 100)

(define timed-prime-test
  (lambda (n)
    (newline)
    (display n)
    (start-prime-test n (runtime))))

(define start-prime-test
  (lambda (n start-time)
    (if (prime? n times)
	(report-prime (- (runtime) start-time)))))

(define report-prime
  (lambda (elapsed-time)
    (display " *** ")
    (display elapsed-time)))

(define prime?
  (lambda (n times)
    (cond ((= times 0) #t)
	  ((fermat-test? n) (prime? n (- times 1)))
	  (else #f))))

(define fermat-test?
  (lambda (n)
    (define try-it
      (lambda (test)
	(= (expmod test n n) test)))
    (try-it (+ 1 (random (- n 1))))))

(define expmod
  (lambda (base exp m)
    (cond ((= exp 0) 1)
	  ((even? exp)
	   (remainder (square (expmod base (/ exp 2) m)) m))
	  (else
	   (remainder (* base (expmod base (- exp 1) m)) m)))))
