#lang racket/base

(define pascal
  (lambda (row col)
    (cond [(or (<= row 0)
               (<= col 0)
               (< row col))
           (error "None value" row col)]
          [(or (= col 1)
               (= row col))
           1]
          [else (+ (pascal (- row 1) col)
                   (pascal (- row 1) (- col 1)))])))
