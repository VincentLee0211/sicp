;; 符号

;; 返回表中符号第一次出现开始的那个子表
(define memq
  (lambda (item x)
    (cond ((null? x) #f)
          ((eq? (car x) item) x)
          (else (memq item (cdr x))))))
