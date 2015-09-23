;; 二维表格

(define lookup
  (lambda (key-1 key-2 table)
    (let ((subtable (assoc key-1 (cdr table))))
      (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
            (if record
                (cdr record)
                #f))
          #f))))

(define assoc
  (lambda (key records)
    (cond [(null? records) #f]
          [(equal? key (caar records)) (car records)]
          [else (assoc key (cdr records))])))

(define insert!
  (lambda (key-1 key-2 value table)
    (let ((subtable (assoc key-1 (cdr table))))
      (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
            (if record
                (set-cdr! record value)
                (set-cdr! subtable
                          (cons (cons key-2 value) (cdr subtable)))))
          (set-cdr! table
                    (cons (list key-1 (cons key-2 value)) (cdr table)))))
    'ok))

(define make-table
  (lambda ()
    (list '*table*)))
