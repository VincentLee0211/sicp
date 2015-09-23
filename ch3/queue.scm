;; 队列的表示
;;
;; 一个队列是一个序列, 数据项只能从一端插入, 只能从另一端删除
;;
;; make-queue
;; insert-queue!
;; delete-queue!
;; empty-queue?
;; front-queue

(define front-ptr (lambda (queue) (car queue)))
(define rear-ptr (lambda (queue) (cdr queue)))

(define set-front-ptr! (lambda (queue item) (set-car! queue item)))
(define set-rear-ptr! (lambda (queue item) (set-cdr! queue item)))

(define empty-queue? (lambda (queue) (null? (front-ptr queue))))

(define make-queue (lambda () (cons '() '())))

(define front-queue
  (lambda (queue)
    (if (empty-queue? queue)
        (error "FRONT called with an empty queue" queue)
        (car (front-ptr queue)))))

(define insert-queue!
  (lambda (queue item)
    (let ((new-pair (cons item '())))
      (cond [(empty-queue? queue)
             (set-front-ptr! queue new-pair)
             (set-rear-ptr! queue new-pair)
             queue]
            [else
             (set-cdr! (rear-ptr queue) new-pair)
             (set-rear-ptr! queue new-pair)
             queue]))))
