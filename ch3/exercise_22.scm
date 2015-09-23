(define make-queue
  (lambda ()
    (let ((front-ptr '())
          (rear-ptr '()))
      (define dispatch
        (lambda (m)
          (cond [(eq? m 'empty-queue?) (empty-queue?)]
                [(eq? m 'front-queue) (front-queue)]
                [(eq? m 'insert-queue!) insert-queue!]
                [(eq? m 'delete-queue!) (delete-queue!)]
                [(eq? m 'print-queue) (print-queue)]
                [else (error "Unknown request -- MAKE-QUEUE" m)])))
      (define empty-queue?
        (lambda ()
          (null? front-ptr)))
      (define front-queue
        (lambda ()
          (car front-ptr)))
      (define insert-queue!
        (lambda (item)
          (let ((new-pair (cons item '())))
            (cond [(empty-queue?)
                   (set! front-ptr new-pair)
                   (set! rear-ptr new-pair)]
                  [else
                   (set-cdr! rear-ptr new-pair)
                   (set! rear-ptr new-pair)]))))
      (define delete-queue!
        (lambda ()
          (cond [(empty-queue?)
                 (error "DELETE! called with an empty queue" front-ptr)]
                [else
                 (set! front-ptr (cdr front-ptr))])))
      (define print-queue
        (lambda ()
          front-ptr))
      dispatch)))

(define empty-queue? (lambda (queue) (queue 'empty-queue?)))

(define front-queue? (lambda (queue) (queue 'front-queue)))

(define insert-queue! (lambda (queue item) ((queue 'insert-queue!) item) queue))

(define delete-queue! (lambda (queue) (queue 'delete-queue!) queue))

(define print-queue (lambda (queue) (queue 'print-queue)))
