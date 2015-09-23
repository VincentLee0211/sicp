;; 一维表格

;; 用一个lookup过程, 以一个键为参数, 返回与之相关联的值
(define lookup
  (lambda (key table)
    (let ((record (assoc key (cdr table))))
      (if record
          (cdr record)
          #f))))

(define assoc
  (lambda (key records)
    (cond [(null? records) #f]
          [(equal? key (caar records)) (car records)]
          [else (assoc key (cdr records))])))

;; 如果键不存在, cons一个新的键值对放在数据项最前面
;; 如果键存在, 更新值
(define insert!
  (lambda (key value table)
    (let ((record (assoc key (cdr table))))
      (if record
          (set-cdr! record value)
          (set-cdr! table (cons (cons key value) (cdr table)))))
    'ok))

;; 构造函数
(define make-table
  (lambda ()
    (list '*table*)))
