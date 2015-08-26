;; 对表的映射

;; 将某种变换应用于一个表的所有元素, 得到所有结果构成的表

(define scale-list
  (lambda (items factor)
    (if (null? items)
        '()
        (cons (* (car items) factor)
              (scale-list (cdr items) factor)))))

(scale-list '(1 2 3 4 5) 10)

;; 构造 map 抽象
(define map
  (lambda (proc items)
    (if (null? items)
        '()
        (cons (proc (car items))
              (map proc (cdr items))))))

(map abs '(-10 2.5 -11.6 17))

(map (lambda (x) (* x x)) '(1 2 3 4))

;; 使用 map 构建 scale-list
(define scale-list.v2
  (lambda (items factor)
    (map (lambda (x) (* factor x))
         items)))

(scale-list.v2 '(1 2 3 4 5) 10)
