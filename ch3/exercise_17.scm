(define count-pairs
  (lambda (x)
    (let ((memoriz '()))
      (define iter
        (lambda (x)
          (if (or (not (pair? x)) (memq x memoriz))
              0
              (begin (set! memoriz (cons x memoriz))
                     (+ (iter (car x))
                        (iter (cdr x))
                        1)))))
      (iter x))))

;; 3
(define al '(a b c))

;; 5
(define fs '(a b))
(define ft '(a b))
(define ff (list fs ft))
(set-cdr! ft fs)

;; 4
(define st '(a b))
(define ss (cons st st))
(define sf (cons ss ss))
