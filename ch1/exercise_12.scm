;; 写一个过程, 它采用递归计算过程计算出帕斯卡三角形

(define pascal
  (lambda (row col)
    (cond ((or (<= row 0) (<= col 0) (< row col))
	   (error "out of index" row col))
	  ((or (= col 1) (= row col))
	   1)
	  (else (+ (pascal (- row 1) (- col 1))
		   (pascal (- row 1) col))))))
	  
