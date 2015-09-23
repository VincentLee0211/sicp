;; queue 实现的关键是, 新元素具有一个指向之后元素的指针
;; (define new-pair (cons item '()))
;;
;; deque 实现的关键是, 新元素具有一个指向之后元素的指针和一个指向之前元素的指针
;; (define new-pair (cons item (cons '() '())))
;;
(library (deque)
  (export make-deque
          empty-deque?
          front-deque
          rear-deque
          front-insert-deque!
          rear-insert-deque!
          front-delete-deque!
          rear-delete-deque!
          print-deque)
  (import (rnrs base (6))
          (rnrs mutable-pairs (6))
          (rnrs io simple (6)))

  ;; internal procedures
  (define front-ptr (lambda (deque) (car deque)))
  (define rear-ptr (lambda (deque) (cdr deque)))

  (define set-front-ptr! (lambda (deque item) (set-car! deque item)))
  (define set-rear-ptr! (lambda (deque item) (set-cdr! deque item)))

  (define deque->list
    (lambda (deque)
      (define iter
        (lambda (lst)
          (if (null? lst)
              '()
              (cons (car lst) (iter (cddr lst))))))
      (iter (front-ptr deque))))

  ;; interface procedures
  (define make-deque
    (lambda ()
      (cons '() '())))

  (define empty-deque?
    (lambda (deque)
      (and (null? (front-ptr deque))
           (null? (rear-ptr deque)))))

  (define front-deque
    (lambda (deque)
      (if (empty-deque? deque)
          (error "FRONT called with an empty deque" deque)
          (car (front-ptr deque)))))

  (define rear-deque
    (lambda (deque)
      (if (empty-deque? deque)
          (error "REAR called with an empty deque" deque)
          (car (rear-ptr deque)))))

  (define front-insert-deque!
    (lambda (deque item)
      (let ((new-pair (cons item (cons '() '()))))
        (cond [(empty-deque? deque)
               (set-front-ptr! deque new-pair)
               (set-rear-ptr! deque new-pair)]
              [else
               (set-cdr! (cdr new-pair) (front-ptr deque))
               (set-car! (cdr (front-ptr deque)) new-pair)
               (set-front-ptr! deque new-pair)]))))

  (define rear-insert-deque!
    (lambda (deque item)
      (let ((new-pair (cons item (cons '() '()))))
        (cond [(empty-deque? deque)
               (set-front-ptr! deque new-pair)
               (set-rear-ptr! deque new-pair)]
              [else
               (set-car! (cdr new-pair) (rear-ptr deque))
               (set-cdr! (cdr (rear-ptr deque)) new-pair)
               (set-rear-ptr! deque new-pair)]))))

  (define front-delete-deque!
    (lambda (deque)
      (cond [(empty-deque? deque)
             (error "DELETE! called with an empty deque" deque)]
            [(eq? (front-ptr deque) (rear-ptr deque))
             (set-front-ptr! deque '())
             (set-rear-ptr! deque '())]
            [else
             (set-front-ptr! deque (cddr (front-ptr deque)))
             (set-cdr! (cdr (cadr (front-ptr deque))) '())
             (set-car! (cdr (front-ptr deque)) '())])))

  (define rear-delete-deque!
    (lambda (deque)
      (cond [(empty-deque? deque)
             (error "DELETE! called with an empty deque" deque)]
            [(eq? (front-ptr deque) (rear-ptr deque))
             (set-front-ptr! deque '())
             (set-rear-ptr! deque '())]
            [else
             (set-rear-ptr! deque (cadr (rear-ptr deque)))
             (set-car! (cdr (cddr (rear-ptr deque))) '())
             (set-cdr! (cdr (rear-ptr deque)) '())])))

  (define print-deque
    (lambda (deque)
      (display (deque->list deque))
      (newline))))
