(library (queue)
  (export make-queue insert-queue! delete-queue! empty-queue? front-queue print-queue)
  (import (rnrs) (rnrs mutable-pairs))

  ;; internal procedures
  (define front-ptr
    (lambda (queue)
      (car queue)))

  (define rear-ptr
    (lambda (queue)
      (cdr queue)))

  (define set-front-ptr!
    (lambda (queue item)
      (set-car! queue item)))

  (define set-rear-ptr!
    (lambda (queue item)
      (set-cdr! queue item)))

  ;; interface to rest of the system
  (define make-queue
    (lambda ()
      (cons '() '())))

  (define empty-queue?
    (lambda (queue)
      (null? (front-ptr queue))))

  (define front-queue
    (lambda (queue)
      (if (empty-queue? queue)
          (error "FRONT called with an empty queue" queue)
          (car (front-queue queue)))))

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

  (define delete-queue!
    (lambda (queue)
      (cond [(empty-queue? queue)
             (error "DELETE! called with an empty queue" queue)]
            [else
             (set-front-ptr! queue (cdr (front-ptr queue)))
             queue])))

  (define print-queue
    (lambda (queue)
      (front-ptr queue))))
