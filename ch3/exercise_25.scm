(define make-table
  (lambda ()
    (let ((local-table (list '*table*)))

      (define dispatch
        (lambda (m)
          (cond [(eq? m 'lookup-proc) lookup]
                [(eq? m 'insert-proc!) insert]
                [else (error "unknown operation -- TABLE" m)])))

      (define lookup
        (lambda (keys)
          (if)))

      dispatch)))
