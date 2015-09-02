;; 嵌套映射

;; 辅助函数
(define add1 (lambda (x) (+ x 1)))

(define sub1 (lambda (x) (- x 1)))

(define zero? (lambda (x) (= x 0)))

(define one? (lambda (x) (= x 1)))

(define prime?
  (lambda (n)
    (fast-prime? n 100)))

(define fast-prime?
  (lambda (n times)
    (cond ((zero? times) #t)
          ((miller-rabin-test n) (fast-prime? n (sub1 times)))
          (else #f))))

(define miller-rabin-test
  (lambda (n)
    (define try-it
      (lambda (r)
        (one? (expmod r (sub1 n) n))))
    (try-it (add1 (random (sub1 n))))))

(define expmod
  (lambda (base exp m)
    (cond ((zero? exp) 1)
          ((even? exp)
           (let ((x (expmod base (/ exp 2) m)))
             (if (non-trivial-sqrt? x m)
                 0
                 (remainder (square x) m))))
          (else (remainder (* base (expmod base (sub1 exp) m)) m)))))

(define non-trivial-sqrt?
  (lambda (x m)
    (cond ((or (one? x) (= x (sub1 m))) #f)
          (else (one? (remainder (square x) m))))))

;; 生成区间序列
(define enumerate-interval
  (lambda (low high)
    (if (> low high)
        '()
        (cons low (enumerate-interval (add1 low) high)))))

;; 过滤器
(define filter
  (lambda (predicate seq)
    (cond ((null? seq) '())
          ((predicate (car seq))
           (cons (car seq) (filter predicate (cdr seq))))
          (else (filter predicate (cdr seq))))))

;; 累积器
(define accumulate
  (lambda (op init seq)
    (if (null? seq)
        init
        (op (car seq)
            (accumulate op init (cdr seq))))))

;; 生成所有 i <= n & j < i 的所有可能组合
(define full-pairs
  (lambda (n)
    (accumulate append
                '()
                (map (lambda (i)
                       (map (lambda (j) (list i j))
                            (enumerate-interval 1 (sub1 i))))
                     (enumerate-interval 1 n)))))

;; 抽象出独立过程
(define flatmap
  (lambda (proc seq)
    (accumulate append '() (map proc seq))))

;; ---------------------------------------------------------------------------

;; 生成满足 i <= n & j < i 所组成的所有三元组, 过滤其中的 i + j 是素数

;; 判断 pair 是否为素数
(define prime-sum?
  (lambda (pair)
    (prime? (+ (car pair) (cadr pair)))))

;; 创建 pair 的三元组
(define make-pair-sum
  (lambda (pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair)))))

;;
(define prime-sum-pairs
  (lambda (n)
    (map make-pair-sum
         (filter prime-sum?
                 (flatmap (lambda (i)
                            (map (lambda (j) (list i j))
                                 (enumerate-interval 1 (sub1 i))))
                          (enumerate-interval 1 n))))))

;; 排列组合, 序列 S 的所有可能组合
;; 除去一种元素的所有可能组合+与该元素的组合
(define permutations
  (lambda (s)
    (if (null? s)
        (list '())
        (flatmap (lambda (x)
                   (map (lambda (p) (cons x p))
                        (permutations (remove x s))))
                 s))))

(define remove
  (lambda (item seq)
    (filter (lambda (x) (not (= x item))) seq)))
