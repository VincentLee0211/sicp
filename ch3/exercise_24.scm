(define make-table
  (lambda (compare)
    (let ((local-table (list '*table*)))
      (define dispatch
        (lambda (m)
          (cond [(eq? m 'lookup-proc) lookup]
                [(eq? m 'insert-proc!) insert!]
                [else (error "unknwon operation -- TABLE" m)])))

      (define lookup
        (lambda (key-1 key-2)
          (let ((subtable (assoc key-1 (cdr local-table))))
            (if subtable
                (let ((record (assoc key-2 (cdr subtable))))
                  (if record
                      (cdr record)
                      #f))
                #f))))

      (define insert!
        (lambda (key-1 key-2 value)
          (let ((subtable (assoc key-1 (cdr local-table))))
            (if subtable
                (let ((record (assoc key-2 (cdr subtable))))
                  (if record
                      (set-cdr! record value)
                      (set-cdr! subtable
                                (cons (cons key-2 value) (cdr subtable)))))
                (set-cdr! local-table
                          (cons (list key-1 (cons key-2 value)) (cdr local-table)))))
          'ok))

      (define assoc
        (lambda (key records)
          (cond [(null? records) #f]
                [(compare key (caar records)) (car records)]
                [else (assoc key (cdr records))])))
      dispatch)))

(define same-key?
  (lambda (item key)
    (if (and (number? item) (number? key))
        (< (abs (- item key)) 0.0001)
        (equal? item key))))

(define operation-table (make-table same-key?))
(define put (operation-table 'insert-proc!))
(define get (operation-table 'lookup-proc))
