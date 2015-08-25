;; 下面几个过程个定义了一种加起来两个正整数的方法, 他们都基于过程 inc 和 dec

(define inc (lambda (x) (+ x 1)))
(define dec (lambda (x) (- x 1)))

(define @+
  (lambda (a b)
    (if (= a 0)
	b
	(inc (@+ (dec a) b)))))

(define &+
  (lambda (a b)
    (if (= a 0)
	b
	(&+ (dec a) (inc b)))))

;; 请用代换模型展示这两个过程在求值 (+ 4 5) 时产生的计算过程.
;; 这些计算过程是递归的或者迭代的?

;; @+ 是递归计算过程
(@+ 4 5)
(inc (@+ 3 5))
(inc (inc (@+ 2 5)))
(inc (inc (inc (@+ 1 5))))
(inc (inc (inc (inc (@+ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9

;; &+ 是迭代计算过程
(&+ 4 5)
(&+ 3 6)
(&+ 2 7)
(&+ 1 8)
(&+ 0 9)
9
     
