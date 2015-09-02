#|
请写出一个过程, 它能产生出所有小于等于给定整数 n 的正的相异整数 i, j 和 k 的有序三元组,
使每个三元组的三个元之和等于给定的整数 s
|#

(define sum-equal-tuple
  (lambda (n s)
    (filter (tuple-sum? s)
            (flatmap (lambda (i)
                       (flatmap (lambda (j)
                                  (map (lambda (k) (list i j k))
                                       (enumerate-interval 1 (sub1 j))))
                                (enumerate-interval 1 (sub1 i))))
                     (enumerate-interval 1 n)))))

(define unique-pairs
  (lambda (n)
    (flatmap (lambda (i)
               (map (lambda (j) (list i j))
                    (enumerate-interval 1 (sub1 i))))
             (enumerate-interval 1 n))))


(define flatmap
  (lambda (proc seq)
    (accumulate append '() (map proc seq))))

(define map
  (lambda (proc seq)
    (if (null? seq)
        '()
        (cons (proc (car seq))
              (map proc (cdr seq))))))

(define enumerate-interval
  (lambda (low high)
    (if (> low high)
        '()
        (cons low (enumerate-interval (add1 low) high)))))

(define accumulate
  (lambda (op init seq)
    (if (null? seq)
        init
        (op (car seq)
            (accumulate op init (cdr seq))))))

(define tuple-sum?
  (lambda (s)
    (lambda (tuple)
      (= s (+ (car tuple)
              (cadr tuple)
              (caddr tuple))))))

(define add1 (lambda (x) (+ x 1)))

(define sub1 (lambda (x) (- x 1)))
